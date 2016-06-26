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
    getter :fundamental_types, :structs, :types, :functions, :typedef
    getter :structs_nodes
    getter :struct_fields, :formatter, :lib_info

    @fundamental_types : Hash(Id, Type)
    @structs : Array(Types::Struct)
    @types : Hash(Id, Type)
    @typedef : Array(TypeDef)
    @functions : Hash(Id, Function)

    @structs_nodes : Array(XML::Node)

    @struct_fields : Hash(Id, Field)

    @formatter : CodeFormatter
    @lib_info = LibInfo.new

    def initialize(xml : XML::Node)
      @fundamental_types = Hash(Id, Type).new
      @structs = Array(Types::Struct).new
      @types = Hash(Id, Type).new
      @typedef = Array(TypeDef).new
      @functions = Hash(Id, Function).new

      @struct_fields = Hash(Id, Field).new

      @structs_nodes = Array(XML::Node).new
      @formatter = CodeFormatter.new

      parse(xml)
      build
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
            @struct_fields[field.id] = field
          when "Struct"
            n = node["name"]?
            if n && !n.empty?
              @structs_nodes << node unless node["incomplete"]?
            end
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
            @types[typedef.id] = AliasedType.new typedef.name
          when "ArrayType"
            arr = ArrayType.new self, node
            @types[arr.id] = arr
          end
        end
      else
        raise "Invalid XML"
      end
    end

    def build
      @structs_nodes.each do |node|
        struct_ = Types::Struct.new self, node
        @structs << struct_
      end
    end
  end
end
