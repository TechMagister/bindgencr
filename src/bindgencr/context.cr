
require "./types"

require "xml"

module Bindgencr

  class Context

    getter :fundamental_types

    @fundamental_types : Array(Type)

    def initialize(xml : XML::Node)
      @fundamental_types = Array(Type).new
      first_elem = xml.first_element_child 

      if first_elem
        first_elem.children.each do |node|
          if node.name == "FundamentalType"
            @fundamental_types << ScalarType.new(self, node)
          end
        end

      else
        raise "Invalid XML"
      end

    end

  end

end