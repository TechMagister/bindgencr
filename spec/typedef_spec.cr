require "./spec_helper"

describe Bindgencr::Types::TypeDef do
  it "should parse" do
    xml = <<-XML
    <Typedef id="_15" name="__uint32_t" type="_22" context="_1" location="f1:14" file="f1" line="14"/>
    XML

    node = XML.parse xml
    node = node.first_element_child if node
    raise "Bad XML" unless node

    ctx = MockContext.new
    typedef = TypeDef.new ctx, node

    typedef.id.should eq("_15")
    typedef.name.should eq("__uint32_t")
    typedef.from.should eq("_22")
  end

  it "should render" do
    xml = <<-XML
    <Typedef id="_15" name="__uint32_t" type="_22" context="_1" location="f1:14" file="f1" line="14"/>
    XML

    expected = "alias X__uint32_t = UInt32"

    node = XML.parse xml
    node = node.first_element_child if node
    raise "Bad XML" unless node

    ctx = MockContext.new
    ctx.fundamental_types["_22"] = MockScalarType.new ctx, "_22", "unsigned int"
    typedef = TypeDef.new ctx, node
    render = typedef.render

    render.should eq(expected)
  end
end
