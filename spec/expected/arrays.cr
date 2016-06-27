#
# Generated file
#

@[Link("test")]
lib LibTest

  struct Mystruct
    array : Int32[5]
    arr : Int8[10]
  end
  struct X__va_list_tag
    gp_offset : UInt32
    fp_offset : UInt32
    overflow_arg_area : Void*
    reg_save_area : Void*
  end
  alias X__int128_t = Int64
  alias X__uint128_t = UInt64
  alias X__builtin_ms_va_list = UInt8*
  alias X__builtin_va_list = X__va_list_tag*
end

