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

    STDLIB = [
      "__stddef_max_align_t.h",
      "alloca.h",
      "assert.h",
      "bits/pthreadtypes.h",
      "bits/sigset.h",
      "bits/time.h",
      "bits/types.h",
      "bits/waitstatus.h",
      "complex.h",
      "ctype.h",
      "errno.h",
      "fenv.h",
      "float.h",
      "inttypes.h",
      "iso646.h",
      "limits.h",
      "locale.h",
      "math.h",
      "sdtargs.h",
      "setjmp.h",
      "signal.h",
      "stdalign.h",
      "stdarg.h",
      "stdatomic.h",
      "stdbool.h",
      "stddef.h",
      "stdint.h",
      "stdio.h",
      "stdlib.h",
      "stdnoreturn.h",
      "string.h",
      "sys/select.h",
      "sys/sysmacros.h",
      "sys/types.h",
      "tgmath.h",
      "threads.h",
      "time.h",
      "uchar.h",
      "wchar.h",
      "wctype.h"
      ]
end
