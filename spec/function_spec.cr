require "./spec_helper"

describe Bindgencr::Types::Function do

  it "should create a function" do 

    xml = <<-XML
    <Function id="_6" name="test1" returns="_12" context="_1" location="f1:2" file="f1" line="2" mangled="_Z5test1">
      <Argument name="arg1" type="_13" location="f1:2" file="f1" line="2"/>
      <Argument name="arg2" type="_14" location="f1:2" file="f1" line="2"/>
    </Function>
    XML

    node =  XML.parse(xml)
    node = node.first_element_child if node

    if node
      ctx = MockContext.new
      fn = Function.new ctx, node

      fn.id.should eq("_6")
      fn.name.should eq("test1")
      fn.returns.should eq("_12")
      fn.arguments.should eq([
        {name: "arg1", argtype: "_13"},
        {name: "arg2", argtype: "_14"}
      ])

    else
      raise "Bad XML"
    end
  end

  it "should render a function" do

    xml = <<-XML
    <?xml version="1.0"?>
    <GCC_XML version="0.9.0" cvs_revision="1.139">
      <FundamentalType id="_12" name="int" size="32" align="32"/>
      <FundamentalType id="_13" name="char" size="8" align="8"/>
      <FundamentalType id="_14" name="float" size="32" align="32"/>
    </GCC_XML>
    XML

    fnxml = <<-XML
    <Function id="_6" name="test1" returns="_12" context="_1" location="f1:2" file="f1" line="2" mangled="_Z5test1">
      <Argument name="arg1" type="_13" location="f1:2" file="f1" line="2"/>
      <Argument name="arg2" type="_14" location="f1:2" file="f1" line="2"/>
    </Function>
    XML

    expected = <<-EXP
    fun test1(arg1 : Int8, arg2 : Float32) : Int32
    EXP

    ctx = Context.new XML.parse(xml)

    node =  XML.parse(fnxml)
    node = node.first_element_child if node

    if node
      fn = Function.new ctx, node
      rendered = fn.render
      rendered.should eq(expected)
    else
      raise "Bad XML"
    end

  end

end