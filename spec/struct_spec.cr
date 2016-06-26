require "./spec_helper"

require "spec"

include Bindgencr

describe Bindgencr::Types::Struct do
  #  <?xml version="1.0"?>
  #  <GCC_XML version="0.9.0" cvs_revision="1.139">
  #    <Struct id="_6" name="basic" context="_1" location="f1:1" file="f1" line="1" members="_11 _12 _13" size="96" align="32"/>
  #    <Field id="_11" name="member1" type="_16" context="_6" access="public" location="f1:2" file="f1" line="2" offset="0"/>
  #    <Field id="_12" name="member2" type="_14" context="_6" access="public" location="f1:3" file="f1" line="3" offset="32"/>
  #    <Field id="_13" name="member3" type="_17" context="_6" access="public" location="f1:4" file="f1" line="4" offset="64"/>
  #    <FundamentalType id="_16" name="int" size="32" align="32"/>
  #    <FundamentalType id="_17" name="unsigned int" size="32" align="32"/>
  #    <FundamentalType id="_14" name="char" size="8" align="8"/>
  #  </GCC_XML>
  it "should render the struct" do
    expected = <<-EXP
    struct Basic
      member1 : Int32
      member2 : Int8
      member3 : UInt32
    end
    EXP

    node = XML.parse(%(<Struct id="_6" name="basic" context="_1" location="f1:1" file="f1" line="1" members="_11 _12 _13" size="96" align="32"/>))
    node = node.first_element_child

    if node
      ctx = MockContext.new
      ctx.fundamental_types["_16"] = MockScalarType.new(ctx, "_16", "int")
      ctx.fundamental_types["_17"] = MockScalarType.new(ctx, "_17", "unsigned int")
      ctx.fundamental_types["_14"] = MockScalarType.new(ctx, "_14", "char")
      ctx.fields["_11"] = Field.new("_11", "member1", "_16")
      ctx.fields["_12"] = Field.new("_12", "member2", "_14")
      ctx.fields["_13"] = Field.new("_13", "member3", "_17")
      structt = Types::Struct.new(ctx, node)
      structt.name.should eq("basic")
      structt.fields_ids.should eq(["_11", "_12", "_13"])
      structt.render.should eq(expected)
    else
      raise "Bad XML"
    end
  end
end
