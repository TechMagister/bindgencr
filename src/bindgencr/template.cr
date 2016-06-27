module Bindgencr
  TEMPLATE = <<-TPL
    #
    # Generated file
    #

    @[Link(%link%)]
    lib %libname%

    %structs%

    %typedef%

    %functions%

    end


    TPL
end
