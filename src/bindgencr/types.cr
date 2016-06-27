require "xml"

module Bindgencr::Types

  extend self

  alias Id = String

  def get_rtype_id(ctx : Context, typeid : Id)

    type_or_nil = ctx.type(typeid)

    if type_or_nil.is_a? Pointer && (ptr = type_or_nil)
      return get_rtype_id ctx, ptr.inner
    elsif type = type_or_nil
      return type.id
    end

  end

  abstract class Type
    getter :name, :id
    @name : String = ""
    @id : Id = ""
    abstract def initialize(context : Context, node : XML::Node)
    abstract def render(level : UInt8 = 0_u8) : String
  end

  class AliasedType < Type
    getter :name
    @name : String
    @from_id : Id

    def initialize(context : Context, node : XML::Node)
      @name, @from_id = ""
      raise "Unsupported constructor"
    end

    def initialize(@name, @from_id = "")
    end

    def render(level : UInt8 = 0_u8) : String
      name = (@name[0] == '_') ? "X" + @name : @name.camelcase
      name
    end
  end

  #
  # Used for the typedef
  #
  class TypeDef < Type
    getter :id, :name, :from, :file

    @id : Id
    @name : String
    @from : Id
    @file : String? # used to clean the alias part

    def initialize(@context : Context, node : XML::Node)
      if node && (id = node["id"]?) && (name = node["name"]?) && (from = node["type"]?)
        @id, @name, @from = id, name, from
        @file = node["file"]?
      else
        raise "Invalid Node for Typedef"
      end
    end

    def render(level : UInt8 = 0_u8) : String
      if @name[0] == '_'
        name = "X" + @name
      else
        name = @name.camelcase
      end

      res = String.build do |buff|
        buff << @context.formatter.indent * level
        buff << "alias " << name << " = "
        buff << @context.type(@from).render
      end

      res
    end
  end

  #
  # Used to generate pointers
  #
  class Pointer < Type
    getter :id, :inner
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

    def render(level : UInt8 = 0_u8) : String
      inner = @context.type(@inner)
      res = inner.render + "*"
      case inner
      when FunctionPtr
        res = inner.render
      when Scalar
        res = "UInt8*" if inner.name == "char"
      end
      res
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

    def render(level : UInt8 = 0_u8) : String
      ret_type = @context.type(@returns)
      extra_parenthesis = false
      if ret_type.is_a? Pointer
        inner = @context.type(ret_type.inner)
        extra_parenthesis = inner.is_a? FunctionPtr
      end

      res = String.build do |buff|
        argsize = @arguments.size
        buff << '('
        @arguments.each_index do |i|
          arg = @arguments[i]
          buff << "(" if i == 0 && i != argsize-1
          buff << ", " if i != 0
          buff << @context.type(arg).render
          buff << ")" if i == argsize-1 && argsize != 1
        end
        buff << " -> (" + ret_type.render + ")" if extra_parenthesis
        buff << " -> " + ret_type.render  if !extra_parenthesis
        buff << ')'
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
          argnum = 0
          arguments.each do |arg|
            if arg && (atype = arg["type"]?) 
              if aname = arg["name"]?
                @arguments << {name: aname, argtype: atype}
              else
                @arguments << {name: "arg#{argnum+=1}", argtype: atype}
              end
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
            buff << arg[:name].underscore << " : " << @context.type(arg[:argtype]).render
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

    SCALARS = {
      "int"                    => "Int32",
      "long long int"          => "Int64",
      "void"                   => "Void",
      "double"                 => "Float64",
      "long double"            => "Float64",
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
      "long int"               => "Int64"
    }

    def initialize(@context : Context, @node : XML::Node)
      if @node && (id = @node["id"]) && (name = @node["name"])
        @id = id
        @name = name
      else
        raise "Invalid Node for ScalarType"
      end
    end

    def render(level : UInt8 = 0_u8) : String
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
  class StructType < Type
    getter :fields_ids, :complete, :file

    @@anonymous: Int32 = -1

    @fields_ids : Array(Id)?
    @complete = true
    @file : String?

    def is_anonymous(name : String)
      name.starts_with? "anon_struct_"
    end

    def initialize(@context : Context, @node : XML::Node, prefix = "anon_struct_")
      if @node && (id = @node["id"]?) && (name = @node["name"]?)
        @id , @name = id, name
        @file = @node["file"]?
        @complete = !@node["incomplete"]?

        @name = prefix + (@@anonymous+=1).to_s if @name.empty?

        if (members = @node["members"]?)
          @fields_ids = members.split ' '
        else
          @fields_ids = Array(Id).new if ! @node["incomplete"]?
        end
      else
        raise "Invalid node : " + @node.inspect
      end
    end

    def render(level : UInt8 = 0_u8) : String
      if @name[0]? == '_'
        name = 'X' + @name
      else
        name = @name.camelcase
      end

      fids = @fields_ids

      buffer = String.build do |buff|
        buff << @context.formatter.indent * level
        buff << "struct " + name << "\n"
        if fids && !fids.empty?
          fids.each do |f|
            field = @context.fields[f]?
            raise "The struct " + @name + " as an unsupported member type." unless field

            next if field.name.empty?
            next if is_anonymous(field.name)
            buff << @context.formatter.indent * (level + 1)
            buff << field.name << " : " << @context.type(field.type).render << "\n"
          end
        else
          buff << @context.formatter.indent * (level + 1)
          buff << "__data : UInt8[0]\n"
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
        max = max.empty? ? "0" : max
        @id, @type, @max = id, to, max.to_u32+1
      else
        raise "Invalid Node for Typedef"
      end
    end
    def render(level : UInt8 = 0_u8) : String
      res = String.build do |buff|
        buff << @context.type(@type).render
        buff << "[" << @max << "]"
      end
      res
    end
  end

  class Union < StructType

    def anon_prefix
      "anon_union_"
    end

    def initialize(@context : Context, node : XML::Node)
      super(@context, node, "anon_union_")
    end

    def render(level : UInt8 = 0_u8) : String
      if @name[0]? == '_'
        name = 'X' + @name
      else
        name = @name.camelcase
      end

      buffer = String.build do |buff|
        buff << @context.formatter.indent * level
        buff << "union " + name << "\n"
        if fids = @fields_ids
          fids.each do |f|
            buff << @context.formatter.indent * (level + 1)

            field = @context.fields[f]?
            if field
              next if field.name.empty?
              buff << field.name << " : " << @context.type(field.type).render << "\n"
            elsif field = @context.type f
              next if field.name.empty?
              next if is_anonymous(field.name)
              buff << field.name << " : " << field.render << "\n"
            else
              raise "The union #{@name} #{@id} as an unsupported member type."
            end
          end
        end

        buff << @context.formatter.indent * level << "end"
      end
      buffer
    end

  end

  class Enumeration < Type

    getter :values, :file

    @values : Array(Tuple(String, String))
    @file : String?

    def initialize(@context : Context, node : XML::Node)
      if node && (id = node["id"]?) && (name = node["name"]?)
        @id, @name, @values = id, name, Array(Tuple(String, String)).new
        @file = node["file"]?
        if (values = node.children.select { |n| n.name == "EnumValue" })
          values.each do |arg|
            if (evname = arg["name"]?) && (evinit = arg["init"]?)
              @values << {evname, evinit}
            end
          end
        end

      else
        raise "Invalid node for Enumeration"
      end
    end
    def render(level : UInt8 = 0_u8) : String
      name = @name.camelcase

      res = String.build do |buff|
        buff << @context.formatter.indent * level
        buff << "enum " << name << "\n"

        @values.each do |v|
          buff << @context.formatter.indent * (level+1)
          buff << v[0].camelcase << " = " << v[1] << "\n"
        end

        buff << @context.formatter.indent * level
        buff << "end\n"
      end
      res

    end
  end

end
