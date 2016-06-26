require "./spec_helper"

describe Bindgencr::Generator do

  it "should render empty template" do
    ctx = MockContext.new
    generator = Generator.new ctx
    rendered = generator.render

    expected = <<-EXP
    #
    # Generated file
    #

    @[Link("")]
    lib 
    end

    EXP

    rendered.should eq(expected)

  end

  it "should render basic_struct" do
    xml = XML.parse(File.read("spec/input/basic_struct.xml"))
    expected = File.read "spec/expected/basic_struct.cr"

    ctx = Context.new xml
    ctx.lib_info.link = "test"
    ctx.lib_info.libname = "LibTest"
    generator = Generator.new ctx

    rendered = generator.render

    rendered.should eq(expected)

  end


end