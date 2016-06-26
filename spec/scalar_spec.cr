require "./spec_helper"

require "xml"

def is_scalar_eq(strnode, expected_id, expected_render)
  mock_context = MockContext.new
  node = XML.parse(strnode).first_element_child
  if node
    scalar = Bindgencr::Types::Scalar.new(mock_context, node)
    scalar.id.should eq(expected_id)
    scalar.render.should eq(expected_render)
  else
    raise "Something wrong with this node"
  end
end

describe Bindgencr::Types::Scalar do
  it "should render the scalar type" do
    node = "<FundamentalType id=\"_314\" name=\"__int128\" size=\"128\" align=\"128\"/>"
    is_scalar_eq(node, "_314", "Int64")

    node = "<FundamentalType id=\"_315\" name=\"unsigned __int128\" size=\"128\" align=\"128\"/>"
    is_scalar_eq(node, "_315", "UInt64")

    node = "<FundamentalType id=\"_320\" name=\"int\" size=\"32\" align=\"32\"/>"
    is_scalar_eq(node, "_320", "Int32")
    node = "<FundamentalType id=\"_321\" name=\"long long int\" size=\"64\" align=\"64\"/>"
    is_scalar_eq(node, "_321", "Int64")

    node = "<FundamentalType id=\"_322\" name=\"long long unsigned int\" size=\"64\" align=\"64\"/>"
    is_scalar_eq(node, "_322", "UInt64")

    node = "<FundamentalType id=\"_378\" name=\"void\" size=\"0\" align=\"8\"/>"
    is_scalar_eq(node, "_378", "Void")

    node = "<FundamentalType id=\"_394\" name=\"double\" size=\"64\" align=\"64\"/>"
    is_scalar_eq(node, "_394", "Float64")

    node = "<FundamentalType id=\"_395\" name=\"unsigned char\" size=\"8\" align=\"8\"/>"
    is_scalar_eq(node, "_395", "UInt8")

    node = "<FundamentalType id=\"_403\" name=\"unsigned int\" size=\"32\" align=\"32\"/>"
    is_scalar_eq(node, "_403", "UInt32")

    node = "<FundamentalType id=\"_549\" name=\"char\" size=\"8\" align=\"8\"/>"
    is_scalar_eq(node, "_549", "Int8")
  end
end
