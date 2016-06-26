require "./spec_helper.cr"

describe Bindgencr::Types::Pointer do

  it "should render basic types pointer" do

    scalars = {
      "_0" => "Int32*",
      "_1" => "Int64*",
      "_2" => "Void*",
      "_3" => "Float64*",
      "_4" => "Int64*",
      "_5" => "UInt64*",
      "_6" => "UInt64*",
      "_7" => "UInt8*",
      "_8" => "UInt32*",
      "_9" => "Int8*"
    }

    ctx = MockContext.new

    i = 0
    Scalar::SCALARS.each do |k,v|
      ctx.fundamental_types["_"+i.to_s] = MockScalarType.new ctx, "_"+i.to_s, k
      i += 1
    end

    scalars.each do |k, v|
      p = MockPointerType.new ctx, i.to_s, k
      p.render.should eq(v)
      i += 1
    end
    

  end

end