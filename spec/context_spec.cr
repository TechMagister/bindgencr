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
    ft[0].id.should eq("_7")
    ft[2].render.should eq("Int32")

  end

end
