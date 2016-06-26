
require "./types"

require "xml"

module Bindgencr

  class Field 
    property :id, :name, :type
    @id : Id
    @name : String
    @type : Id

    def initialize(node : XML::Node)
      if node && (id = node["id"]) && (name = node["name"]) && (type_t = node["type"])
        @id , @name, @type = id, name, type_t
      else
        raise "Invalide node"
      end
    end

    def initialize(@id : Id, @name : String, @type : Id)
    end
  end

  struct CodeFormatter
    property :indent

    def initialize()
      @indent = "  "
    end
  end

  class Context

    getter :fundamental_types
    getter :struct_fields, formatter

    @fundamental_types : Hash(Id, Type)

    @structs_nodes = Array(XML::Node).new

    @struct_fields : Hash(Id, Field)

    @formatter : CodeFormatter

    def initialize(xml : XML::Node)
      @fundamental_types = Hash(Id, Type).new
      @struct_fields = Hash(Id,Field).new
      @formatter = CodeFormatter.new

      parse(xml)
    end

    def type(id : Id)
      @fundamental_types[id]
    end

    def parse(xml)
      first_elem = xml.first_element_child 

        if first_elem
          first_elem.children.each do |node|
            case node.name
            when "FundamentalType"
              sc = ScalarType.new(self, node)
              @fundamental_types[sc.id] = sc
            when "Field"
              field = Field.new node
              @struct_fields[field.id] = field
            end
          end

        else
          raise "Invalid XML"
        end
    end

  end

end