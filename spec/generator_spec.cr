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

  it "should render functions" do
    xml = XML.parse(File.read("spec/input/functions.xml"))
    expected = File.read "spec/expected/functions.cr"

    ctx = Context.new xml
    ctx.lib_info.link = "test"
    ctx.lib_info.libname = "LibTest"
    generator = Generator.new ctx

    rendered = generator.render

    rendered.should eq(expected)
  end

  it "should render function pointer" do
    xml = XML.parse(File.read("spec/input/p_function.xml"))
    expected = File.read "spec/expected/p_function.cr"

    ctx = Context.new xml
    ctx.lib_info.link = "test"
    ctx.lib_info.libname = "LibTest"
    generator = Generator.new ctx

    rendered = generator.render

    rendered.should eq(expected)
  end


end
