require "spec"
require "../src/bindgencr/*"

include Bindgencr

class MockContext < Context
  def initialize()
    super(XML.parse("<fakenode/>"))
  end
end

class MockScalarType < ScalarType
  def initialize(@context, @id, @name, @node = XML.parse("<fakenode/>"))
  end
end

class MockStructType < StructType
  def initialize(@context, @id, @name, @fields_ids, @node = XML.parse("<fakenode/>"))
  end
end
