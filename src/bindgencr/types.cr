require "xml"

module Bindgencr

  alias Id = String

  abstract class Type
    abstract def initialize(@context : Context, @node : XML::Node)
    abstract def render() : String
  end

  class ScalarType < Type

    getter :id

    @id : Id
    @name : String

    SCALARS = {
      "int"                 => "Int32",
      "long long int"       => "Int64",
      "void"                => "Void",
      "double"              => "Float64",
      "__int128"            => "Int64",
      "unsigned __int128"   => "UInt64",
      "long long unsigned int" => "UInt64",
      "void"                => "Void",
      "unsigned char"       => "UInt8",
      "unsigned int"        => "UInt32",
      "char"                => "Int8"
    }

    def initialize(@context : Context, @node : XML::Node)
      if @node && (id = @node["id"]) && (name = @node["name"])
        @id = id
        @name = name
      else
        raise "Invalid Node for ScalarType"
      end
    end

    def render() : String
      begin
        SCALARS[@name]
      rescue
        raise "Unsupported type"
      end
    end
  end

  class StructType

    getter :id, :name, :fields_ids

    @id : Id
    @name : String
    @fields_ids : Array(Id)

    def initialize(@context : Context, @node : XML::Node)
      if @node && (id = @node["id"]?)  && (name = @node["name"]?) && (members = @node["members"]?)
        @id = id
        @name = name
        @fields_ids = members.split ' '
      else
        raise "Invalid node : " + @node.inspect
      end
    end
    def render(level = 0) : String
      buffer = String.build do |buff|
        buff << @context.formatter.indent * level
        buff << "struct " + @name << "\n"
        @fields_ids.each do |f|
          field = @context.struct_fields[f]
          buff << @context.formatter.indent * (level+1)
          buff << field.name << " : " << @context.type(field.type).render << "\n"
        end
        buff << @context.formatter.indent * level << "end"
      end
      buffer
    end
  end

end