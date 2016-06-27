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
    property :link, :libname

    def initialize(@link = "", @libname = "")
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

      # in case typdef and struc have the same name
      @typedef.select! do |t|
        from = self.type t.from
        from.name != t.name
      end

      # remove incomplete declaration
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
    end

  end
end
