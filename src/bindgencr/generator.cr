
module Bindgencr

  class Generator

    @context : Context

    def initialize(@context)
    end

    def render
      tpl = TEMPLATE

      tpl  = tpl.gsub /%link%/, render_link
      tpl  = tpl.gsub /%libname%/, render_libname
      tpl  = tpl.gsub /%structs%/, render_structs
      tpl  = tpl.gsub /%typedef%/, render_typedef
      tpl  = tpl.gsub /%functions%/, render_functions
      tpl  = tpl.gsub /%alias%/, render_alias
      tpl
    end

    def render_link
      ""
    end

    def render_libname
      ""
    end

    def render_structs
    end

    def render_typedef
      ""
    end

    def render_functions
      ""
    end

    def render_alias
      ""
    end


  end


end