require "xml"

module Bindgencr

  abstract class Type
    abstract def initialize(@node : XML::Node)
    abstract def render() : String
  end

  class ScalarType < Type

    getter :id

    @id : String?
    @name : String?

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

    def initialize(@node : XML::Node)
      @id = @node["id"]
      @name = @node["name"]
    end

    def render() : String
      begin
        SCALARS[@name]
      rescue
        raise "Unsupported type"
      end
    end
  end

end