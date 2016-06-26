require "./spec_helper"

require "xml"

include Bindgencr

describe Bindgencr::Context do

  it "should add fundamental types" do

    xml = <<-XML
    <?xml version="1.0"?>
    <GCC_XML version="0.9.0" cvs_revision="1.139">
      <FundamentalType id="_7" name="__int128" size="128" align="128"/>
      <FundamentalType id="_8" name="unsigned __int128" size="128" align="128"/>
      <FundamentalType id="_16" name="int" size="32" align="32"/>
      <FundamentalType id="_17" name="unsigned int" size="32" align="32"/>
      <FundamentalType id="_23" name="void" size="0" align="8"/>
    </GCC_XML>
    XML

    context = Context.new(XML.parse(xml))

    context.fundamental_types.size.should eq(5)

    ft = context.fundamental_types
    ft.keys.should eq(["_7", "_8", "_16", "_17", "_23"])

  end

  it "should add struct fields" do

    xml = <<-XML
    <?xml version="1.0"?>
    <GCC_XML version="0.9.0" cvs_revision="1.139">
      <Field id="_11" name="member1" type="_16" context="_6" access="public" location="f1:2" file="f1" line="2" offset="0"/>
      <Field id="_12" name="member2" type="_14" context="_6" access="public" location="f1:3" file="f1" line="3" offset="32"/>
      <Field id="_13" name="member3" type="_17" context="_6" access="public" location="f1:4" file="f1" line="4" offset="64"/>
    </GCC_XML>
    XML

    context = Context.new(XML.parse(xml))
    context.struct_fields.size.should eq(3)
    context.struct_fields.keys.should eq(["_11", "_12", "_13"])

  end

  it "should add structs nodes" do
    xml = <<-XML
    <?xml version="1.0"?>
    <GCC_XML version="0.9.0" cvs_revision="1.139">
      <Struct id="_15" name="__va_list_tag" context="_1" location="f0:0" file="f0" line="0" members="_18 _19 _20 _21" size="192" align="64"/>
    </GCC_XML>
    XML

    expected = XML.parse(%(<Struct id="_15" name="__va_list_tag" context="_1" location="f0:0" file="f0" line="0" members="_18 _19 _20 _21" size="192" align="64"/>))
    expected = expected.first_element_child

    if expected
      context = Context.new(XML.parse(xml))
      context.structs_nodes.size.should eq(1)
      context.structs_nodes[0].to_xml.should eq(expected.to_xml)
    else
      raise "Bad XML"
    end
  end

  it "should add build structs" do
    xml = <<-XML
    <?xml version="1.0"?>
    <GCC_XML version="0.9.0" cvs_revision="1.139">
      <Struct id="_6" name="basic" context="_1" location="f1:1" file="f1" line="1" members="_11 _12 _13" size="96" align="32"/>
      <Field id="_11" name="member1" type="_16" context="_6" access="public" location="f1:2" file="f1" line="2" offset="0"/>
      <Field id="_12" name="member2" type="_14" context="_6" access="public" location="f1:3" file="f1" line="3" offset="32"/>
      <Field id="_13" name="member3" type="_17" context="_6" access="public" location="f1:4" file="f1" line="4" offset="64"/>
    </GCC_XML>
    XML

    context = Context.new(XML.parse(xml))
    expected = MockStructType.new context, "_6", "basic", "_11 _12 _13".split ' '

    context.structs.size.should eq(1)
    st = context.structs[0]
    st.id.should eq(expected.id)
    st.name.should eq(expected.name)
    st.fields_ids.should eq(expected.fields_ids)

  end

  it "should add pointers to types" do

    xml = <<-XML
    <?xml version="1.0"?>
    <GCC_XML version="0.9.0" cvs_revision="1.139">
      <PointerType id="_9" type="_15"/>
      <Field id="_11" name="member1" type="_17" context="_6" access="public" location="f1:2" file="f1" line="2" offset="0"/>
      <Field id="_12" name="member2" type="_15" context="_6" access="public" location="f1:3" file="f1" line="3" offset="32"/>
      <Field id="_13" name="member3" type="_18" context="_6" access="public" location="f1:4" file="f1" line="4" offset="64"/>
      <Field id="_14" name="member4" type="_9" context="_6" access="public" location="f1:5" file="f1" line="5" offset="128"/>
      <FundamentalType id="_15" name="char" size="8" align="8"/>
      <FundamentalType id="_17" name="int" size="32" align="32"/>
      <FundamentalType id="_18" name="unsigned int" size="32" align="32"/>
      <FundamentalType id="_24" name="void" size="0" align="8"/>
    </GCC_XML>
    XML

    context = Context.new(XML.parse(xml))
    context.types.size.should eq(1)
    context.types["_9"].should_not be_nil

  end

  it "should add function pointer to types" do

    xml = <<-XML
    <?xml version="1.0"?>
    <GCC_XML version="0.9.0" cvs_revision="1.139">
      <Variable id="_6" name="f" type="_11" context="_1" location="f1:1" file="f1" line="1" mangled="_Z1f"/>
      <PointerType id="_11" type="_14"/>
      <FunctionType id="_14" returns="_22">
        <Argument type="_23"/>
      </FunctionType>
      <FundamentalType id="_21" name="void" size="0" align="8"/>
      <FundamentalType id="_22" name="int" size="32" align="32"/>
      <FundamentalType id="_23" name="float" size="32" align="32"/>
    </GCC_XML>
    XML

    context = Context.new(XML.parse(xml))
    context.types.size.should eq(2)
    context.types["_14"].should_not be_nil

  end

  it "should add functions" do
    xml = <<-XML
    <?xml version="1.0"?>
    <GCC_XML version="0.9.0" cvs_revision="1.139">
      <Function id="_6" name="test1" returns="_12" context="_1" location="f1:2" file="f1" line="2" mangled="_Z5test1">
        <Argument name="arg1" type="_13" location="f1:2" file="f1" line="2"/>
        <Argument name="arg2" type="_14" location="f1:2" file="f1" line="2"/>
      </Function>
      <FundamentalType id="_12" name="int" size="32" align="32"/>
      <FundamentalType id="_13" name="char" size="8" align="8"/>
      <FundamentalType id="_14" name="float" size="32" align="32"/>
    </GCC_XML>
    XML

    context = Context.new(XML.parse(xml))
    context.functions.size.should eq(1)
    context.functions["_6"]?.should_not be_nil

  end

end
