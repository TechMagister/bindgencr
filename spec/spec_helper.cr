require "spec"
require "../src/bindgencr/*"

include Bindgencr

class MockContext < Context
  def initialize()
    super(XML.parse("<fakenode/>"))
  end
end

class MockScalarType < Types::Scalar
  def initialize(@context, @id, @name, @node = XML.parse("<fakenode/>"))
  end
end

class MockStructType < Types::Struct
  def initialize(@context, @id, @name, @fields_ids, @node = XML.parse("<fakenode/>"))
  end
end

class MockPointerType < Types::Pointer
  def initialize(@context, @id, @inner, @node = XML.parse("<fakenode/>"))
  end
end
