require "./spec_helper"

describe Bindgencr::Types::Enumeration do

  it "should render the enum" do

    xml =<<-XML
    <Enumeration id="_307" name="json_type" context="_1" location="f16:100" file="f16" line="100">
      <EnumValue name="json_type_null" init="0"/>
      <EnumValue name="json_type_boolean" init="1"/>
      <EnumValue name="json_type_double" init="2"/>
      <EnumValue name="json_type_int" init="3"/>
      <EnumValue name="json_type_object" init="4"/>
      <EnumValue name="json_type_array" init="5"/>
      <EnumValue name="json_type_string" init="6"/>
    </Enumeration>
    XML

    expected =<<-EXP
    enum JsonType
      JsonTypeNull = 0
      JsonTypeBoolean = 1
      JsonTypeDouble = 2
      JsonTypeInt = 3
      JsonTypeObject = 4
      JsonTypeArray = 5
      JsonTypeString = 6
    end

    EXP

    node = XML.parse xml
    node = node.first_element_child if node
    raise "Bad XML" unless node

    ctx = MockContext.new
    enume = Enumeration.new ctx, node

    enume.render.should eq(expected)

  end

end