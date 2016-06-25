require "spec"
require "../src/bindgencr/*"

include Bindgencr

class MockContext < Context
  def initialize()
    @fundamental_types = Array(Type).new
  end
end