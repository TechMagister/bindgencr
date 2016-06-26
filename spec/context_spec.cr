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

  it "should add structs" do

  end

end
