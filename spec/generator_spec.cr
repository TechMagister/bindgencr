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

    @[Link()]
    lib 

    

    

    

    

    end

    EXP

    rendered.should eq(expected)

  end

end