module Bindgencr
  TEMPLATE = <<-TPL
    #
    # Generated file
    #

    @[Link(%link%)]
    lib %libname%

    %main%

    %typedef%

    %functions%

    end


    TPL
end
