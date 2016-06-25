
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

%alias%

end

TPL

end