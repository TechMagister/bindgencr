require "./spec_helper"

describe Bindgencr::Types::ArrayType do

  it "should parse" do
    xml = <<-XML
    <ArrayType id="_16" min="0" max="9" type="_13"/>
    XML

    node = XML.parse xml
    node = node.first_element_child if node
    raise "Bad XML" unless node

    ctx = MockContext.new
    arr = ArrayType.new ctx, node

    arr.id.should eq("_16")
    arr.type.should eq("_13")
    arr.max.should eq(10)
  end

  it "should render" do
    xml = <<-XML
    <ArrayType id="_16" min="0" max="9" type="_13"/>
    XML

    expected = "Int8[10]"

    node = XML.parse xml
    node = node.first_element_child if node
    raise "Bad XML" unless node

    ctx = MockContext.new
    ctx.fundamental_types["_13"] = MockScalarType.new ctx, "_13", "char"
    arr = ArrayType.new ctx, node
    render = arr.render

    render.should eq(expected)
  end

end