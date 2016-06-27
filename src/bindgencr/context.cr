require "./types"

require "xml"

module Bindgencr
  include Types

  class Field
    property :id, :name, :type
    @id : Id
    @name : String
    @type : Id

    def initialize(node : XML::Node)
      if node && (id = node["id"]) && (name = node["name"]) && (type_t = node["type"])
        @id, @name, @type = id, name, type_t
      else
        raise "Invalide node"
      end
    end

    def initialize(@id : Id, @name : String, @type : Id)
    end
  end

  struct CodeFormatter
    property :indent

    def initialize
      @indent = "  "
    end
  end

  struct LibInfo
    property :link, :libname, :prefix

    def initialize(@link = "", @libname = "", @prefix = "")
    end
  end

  class Context
    getter :fundamental_types, :main, :types, :functions, :typedef
    getter :structs_nodes
    getter :fields, :formatter, :lib_info

    @fundamental_types : Hash(Id, Type)
    @main : Array(Type)
    @types : Hash(Id, Type)
    @typedef : Array(TypeDef)
    @functions : Hash(Id, Function)

    @structs_nodes : Array(XML::Node)
    @union_nodes : Array(XML::Node)
    @qualifiers : Array(Tuple(String, String))

    @fields : Hash(Id, Field)

    @formatter : CodeFormatter
    @lib_info = LibInfo.new
    @avoid_files : Array(Id)

    def initialize(xml : XML::Node)
      @fundamental_types = Hash(Id, Type).new
      @main = Array(Type).new
      @types = Hash(Id, Type).new
      @typedef = Array(TypeDef).new
      @functions = Hash(Id, Function).new

      @fields = Hash(Id, Field).new

      @structs_nodes = Array(XML::Node).new
      @union_nodes = Array(XML::Node).new
      @qualifiers = Array(Tuple(String, String)).new

      @avoid_files = Array(Id).new

      @formatter = CodeFormatter.new

      parse(xml)
      build
      sanitize
    end

    def type(id : Id)
      (ret = @fundamental_types[id]?) || (ret = @types[id])
      ret
    end

    def parse(xml)
      first_elem = xml.first_element_child

      if first_elem
        file_nodes = (first_elem.children.select {|n| n.name == "File" })
        @avoid_files = file_nodes.compact_map { |f|
          found = STDLIB.find { |l|
            if val = f["name"]?
              val.ends_with? l
            end
          }
          if found && (id = f["id"]?)
            id
          end
        }

        first_elem.children.each do |node|
          case node.name
          when "FundamentalType"
            sc = Scalar.new(self, node)
            @fundamental_types[sc.id] = sc
          when "Field"
            field = Field.new node
            @fields[field.id] = field
          when "Struct"
            @structs_nodes << node
          when "Union"
            @union_nodes << node
          when "PointerType"
            p = Pointer.new self, node
            @types[p.id] = p
          when "Function"
            next if @avoid_files.includes? node["file"]?
            func = Function.new self, node
            @functions[func.id] = func
          when "FunctionType"
            fnptr = FunctionPtr.new self, node
            @types[fnptr.id] = fnptr
          when "Typedef"
            typedef = TypeDef.new self, node
            @typedef << typedef
            @types[typedef.id] = AliasedType.new typedef.name, typedef.from
          when "ArrayType"
            max = node["max"]?
            if max && max != "0"
              arr = ArrayType.new self, node
              @types[arr.id] = arr
            else
              arr = Pointer.new self, node
              @types[arr.id] = arr
            end
          when "Enumeration"
            enumeration = Enumeration.new self, node
            @main << enumeration
            @types [enumeration.id] = AliasedType.new enumeration.name
          when "CvQualifiedType"
            id, typ = node["id"]?, node["type"]
            if id && typ
              @qualifiers << {id, typ}
            end
          end
        end
      else
        raise "Invalid XML"
      end
    end

    def build

      # structs
      @structs_nodes.each do |node|
        struct_ = StructType.new self, node
        @main << struct_
        @types[struct_.id] = AliasedType.new struct_.name
      end

      # unions
      @union_nodes.each do |node|
        union_ = Union.new self, node
        @main << union_
        @types[union_.id] = AliasedType.new union_.name
      end

      # qualifiers
      @qualifiers.each do |id, t|
        @types [id] = self.type(t)
      end
    end

    def sanitize

      dependency_list = build_deplist
      clean_typedef dependency_list
      clean_structs dependency_list

      # ----- remove incomplete declaration -----
      @main.select! do |s|
        keep = true
        @main.each do |is|
          next if s.object_id == is.object_id
          if is.name.camelcase == s.name.camelcase && (s.is_a? StructType && !s.complete)
            keep = false
            break
          end
        end
        keep
      end
    end # DEF

    #
    # Check used types
    #
    def get_used_types(id : Id) : Array(Id)
      ret = Array(Id).new
      ret << id

      type_or_nil = self.type(id)
      if type_t = type_or_nil
        case type_t
        when Pointer
          ret.concat get_used_types(type_t.inner)
        when StructType
          if fids = type_t.fields_ids
            fids.each do |field_id|
              ret.concat get_used_types(field_id)
            end
          end
        end
      end

      ret
    end

    #
    # Build a list of used types
    #
    def build_deplist
      # check if we really need this typdef
      # build ref tree, considering all functions are useful
      dependency_list = Array(Id).new
      @functions.each do |name, func|
        returns_t = get_used_types(func.returns)
        
        dependency_list.concat returns_t

        func.arguments.each do |arg|
          arg_t = get_used_types(arg[:argtype])
          dependency_list.concat arg_t
        end

      end #@functions.each
      dependency_list.uniq!
    end # def build_deptree

    #
    # Remove unused typdef that are not part of the library
    #
    def clean_typedef(dependency_list)

      # ----- in case typdef and struc have the same name -----
      @typedef.select! do |t|
        from = self.type t.from
        from.name != t.name
      end

      # ----- clean typedef -----
      to_remove = Array(TypeDef).new
      @typedef.each do |td|
        next if !@avoid_files.includes? td.file # keep from wanted files
        to_remove << td if !dependency_list.includes? td.id
      end
      @typedef.select! { |td| !to_remove.includes?(td) }
    end # def clean_typedef

    #
    # Remove unused struct that are not part of the library
    #
    def clean_structs(dependency_list)

      to_remove = Array(Type).new
      @main.each do |type|
        case type
        when StructType
          next if !@avoid_files.includes? type.file # keep from wanted files
        when Enumeration
          next if !@avoid_files.includes? type.file # keep from wanted files
        end

        to_remove << type if !dependency_list.includes? type.id
      end

      @main.select! { |t| !to_remove.includes?(t) }
      
    end # def clean_structs

  end # CLASS
end # MODULE
