require "xml"

module Bindgencr::Types
  alias Id = String

  abstract class Type
    abstract def initialize(context : Context, node : XML::Node)
    abstract def render(level : UInt8 = 0) : String
  end

  class AliasedType < Type
    @name : String

    def initialize(context : Context, node : XML::Node)
      @name = ""
      raise "Unsupported constructor"
    end

    def initialize(@name : String)
    end

    def render(level : UInt8 = 0) : String
      name = (@name[0] == '_') ? "X" + @name : @name.camelcase
      name
    end
  end

  #
  # Used for the typedef
  #
  class TypeDef < Type
    getter :id, :name, :type

    @id : Id
    @name : String
    @type : Id

    def initialize(@context : Context, node : XML::Node)
      if node && (id = node["id"]) && (name = node["name"]) && (to = node["type"])
        @id, @name, @type = id, name, to
      else
        raise "Invalid Node for Typedef"
      end
    end

    def render(level : UInt8 = 0) : String
      if @name[0] == '_'
        name = "X" + @name
      else
        name = @name.camelcase
      end

      res = String.build do |buff|
        buff << @context.formatter.indent * level
        buff << "alias " << name << " = "
        buff << @context.type(@type).render
      end

      res
    end
  end

  #
  # Used to generate pointers of simple types
  #
  class Pointer < Type
    getter :id
    @id : Id
    @inner : Id

    def initialize(@context : Context, node : XML::Node)
      if node && (id = node["id"]) && (to = node["type"])
        @id = id
        @inner = to
      else
        raise "Invalid Node for Pointer"
      end
    end

    def render(level : UInt8 = 0) : String
      inner = @context.type(@inner)
      case inner
      when FunctionPtr
        inner.render
      else
        inner.render + "*"
      end
    end
  end

  #
  # Used to generate pointers of functions
  #
  class FunctionPtr < Type
    getter :id, :returns, :arguments

    @id : Id
    @returns : Id
    @arguments : Array(Id)

    def initialize(@context : Context, node : XML::Node)
      @arguments = Array(Id).new

      if node
        id, returns = node["id"]?, node["returns"]
        raise "Invalid node for FunctionPtr" unless id && returns
        @id, @returns = id, returns

        if (arguments = node.children.select { |n| n.name == "Argument" })
          arguments.each do |arg|
            if arg && (atype = arg["type"]?)
              @arguments << atype
            end
          end
        end
      else
        raise "Invalid node for FunctionPtr"
      end
    end

    def render(level : UInt8 = 0) : String
      res = String.build do |buff|
        buff << "("
        notfirst = false
        @arguments.each do |arg|
          buff << ", " if notfirst
          buff << @context.type(arg).render
          notfirst = true
        end
        buff << ") -> " + @context.type(@returns).render
      end
      res
    end
  end

  #
  # Used to generate function line
  #
  class Function < Type
    getter :id, :name, :arguments, :returns

    @id : Id
    @name : String
    @arguments : Array(NamedTuple(name: String, argtype: Id))
    @returns : Id

    def initialize(@context : Context, node : XML::Node)
      if node
        id, name, returns = node["id"]?, node["name"]?, node["returns"]?
        raise "Invalid Node for Function" unless id && name && returns
        @id, @name, @returns = id, name, returns
        @arguments = Array(NamedTuple(name: String, argtype: Id)).new

        if (arguments = node.children.select { |n| n.name == "Argument" })
          arguments.each do |arg|
            if arg && (atype = arg["type"]?) && (aname = arg["name"]?)
              @arguments << {name: aname, argtype: atype}
            end
          end
        end
      else
        raise "Invalid Node for Function"
      end
    end

    def render(level = 0) : String
      name = name.underscore
      result = String.build do |buff|
        buff << @context.formatter.indent * level << "fun " << name
        if !@arguments.empty?
          buff << "("
          notfirst = false
          @arguments.each do |arg|
            buff << ", " if notfirst
            buff << arg[:name] << " : " << @context.type(arg[:argtype]).render
            notfirst = true
          end
          buff << ")"
        end
        buff << " : " << @context.type(@returns).render
      end
      result
    end
  end

  #
  # Used to generate scalar types
  #
  class Scalar < Type
    getter :id

    @id : Id
    @name : String

    SCALARS = {
      "int"                    => "Int32",
      "long long int"          => "Int64",
      "void"                   => "Void",
      "double"                 => "Float64",
      "__int128"               => "Int64",
      "unsigned __int128"      => "UInt64",
      "long long unsigned int" => "UInt64",
      "unsigned char"          => "UInt8",
      "unsigned int"           => "UInt32",
      "char"                   => "Int8",
      "float"                  => "Float32",
      "short unsigned int"     => "UInt16",
      "long unsigned int"      => "UInt64",
      "signed char"            => "Int8",
      "short int"              => "Int16",
    }

    def initialize(@context : Context, @node : XML::Node)
      if @node && (id = @node["id"]) && (name = @node["name"])
        @id = id
        @name = name
      else
        raise "Invalid Node for ScalarType"
      end
    end

    def render(level = 0) : String
      begin
        SCALARS[@name]
      rescue
        raise "Unsupported type : " + @name
      end
    end
  end

  #
  # Used to generate structs declarations
  #
  class Struct
    getter :id, :name, :fields_ids

    @id : Id
    @name : String
    @fields_ids : Array(Id)

    def initialize(@context : Context, @node : XML::Node)
      if @node && (id = @node["id"]?) && (name = @node["name"]?) && !name.empty?
        @id = id
        @name = name
        if (members = @node["members"]?)
          @fields_ids = members.split ' '
        else
          @fields_ids = Array(Id).new
        end
      else
        raise "Invalid node : " + @node.inspect
      end
    end

    def render(level = 0) : String
      if @name[0]? == '_'
        name = 'X' + @name
      else
        name = @name.camelcase
      end

      buffer = String.build do |buff|
        buff << @context.formatter.indent * level
        buff << "struct " + name << "\n"
        @fields_ids.each do |f|
          field = @context.struct_fields[f]?
          raise "The struct " + @name + " as an unsupported member type." unless field

          buff << @context.formatter.indent * (level + 1)
          buff << field.name << " : " << @context.type(field.type).render << "\n"
        end

        buff << @context.formatter.indent * level << "end"
      end
      buffer
    end
  end

  #
  # Array type
  #
  class ArrayType < Type
    getter :id, :type, :max

    @id : Id
    @type : Id
    @max : UInt32

    def initialize(@context : Context, node : XML::Node)
      if node && (id = node["id"]) && (to = node["type"]) && (max = node["max"])
        @id, @type, @max = id, to, max.to_u32+1
      else
        raise "Invalid Node for Typedef"
      end
    end
    def render(level : UInt8 = 0) : String
      res = String.build do |buff|
        buff << @context.type(@type).render
        buff << "[" << @max << "]"
      end
      res
    end
  end

end
