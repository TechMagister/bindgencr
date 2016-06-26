module Bindgencr
  class Generator
    @context : Context

    def initialize(@context)
    end

    def render
      tpl = TEMPLATE

      tpl = tpl.gsub /%link%/, render_link
      tpl = tpl.gsub /%libname%/, render_libname
      tpl = tpl.gsub /%structs%/, render_structs
      tpl = tpl.gsub /%typedef%/, render_typedef
      tpl = tpl.gsub /%functions%/, render_functions
      tpl = tpl.gsub /%alias%/, render_alias
      tpl = tpl.gsub /\n{3,}/, "\n"
    end

    def render_link
      '"' + @context.lib_info.link + '"'
    end

    def render_libname
      @context.lib_info.libname
    end

    def render_structs
      rendered = String.build do |buff|
        @context.structs.each do |s|
          buff << s.render 1
          buff << "\n"
        end
      end
      rendered
    end

    def render_typedef
      rendered = String.build do |buff|
        @context.typedef.each do |t|
          buff << t.render 1_u8
          buff << "\n"
        end
      end
      rendered
    end

    def render_functions
      rendered = String.build do |buff|
        @context.functions.each do |id, f|
          buff << f.render 1_u8
          buff << "\n"
        end
      end
      rendered
    end

    def render_alias
      ""
    end
  end
end
