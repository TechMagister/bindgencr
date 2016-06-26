require "./spec_helper.cr"

describe Bindgencr::Types::Pointer do
  it "should render basic types pointer" do
    scalars = {
      "_0"  => "Int32*",
      "_1"  => "Int64*",
      "_2"  => "Void*",
      "_3"  => "Float64*",
      "_4"  => "Int64*",
      "_5"  => "UInt64*",
      "_6"  => "UInt64*",
      "_7"  => "UInt8*",
      "_8"  => "UInt32*",
      "_9"  => "Int8*",
      "_10" => "Float32*",
      "_11" => "UInt16*",
    }

    ctx = MockContext.new

    i = 0
    Scalar::SCALARS.each do |k, v|
      ctx.fundamental_types["_" + i.to_s] = MockScalarType.new ctx, "_" + i.to_s, k
      i += 1
    end

    scalars.each do |k, v|
      p = MockPointerType.new ctx, i.to_s, k
      p.render.should eq(v)
      i += 1
    end
  end

  it "should create function pointer" do
    # c : int (*f)(float)
    # cr : f = ->(Float32) : Int32

    xml = <<-XML
    <FunctionType id="_14" returns="_22">
      <Argument type="_23"/>
    </FunctionType>
    XML

    node = XML.parse xml
    node = node.first_element_child if node
    raise "Bad XML" unless node

    ctx = MockContext.new
    fnptr = FunctionPtr.new ctx, node

    fnptr.id.should eq("_14")
    fnptr.returns.should eq("_22")
    fnptr.arguments.size.should eq(1)
    fnptr.arguments[0].should eq("_23")
  end

  it "should create a callback returning a callback" do

    xml =<<-XML
    <Field id="_359" name="xDlSym" type="_572" context="_31" access="public" location="f2:1211" file="f2" line="1211" offset="704"/>
    <PointerType id="_572" type="_685"/>
    <FunctionType id="_685" returns="_369">
      <Argument type="_451"/>
      <Argument type="_325"/>
      <Argument type="_319"/>
    </FunctionType>
    <PointerType id="_369" type="_581"/>
    <FunctionType id="_581" returns="_378"/>
    <FundamentalType id="_378" name="void" size="0" align="8"/>
    <PointerType id="_451" type="_32"/>
    <Struct id="_31" name="sqlite3_vfs" context="_1" location="f2:1197" file="f2" line="1197" members="_347 _348 _349 _350 _351 _352 _353 _354 _355 _356 _357 _358 _359 _360 _361 _362 _363 _364 _365 _366 _367 _368" size="1344" align="64"/>
    <Typedef id="_32" name="sqlite3_vfs" type="_31" context="_1" location="f2:1195" file="f2" line="1195"/>
    XML

  end

end
