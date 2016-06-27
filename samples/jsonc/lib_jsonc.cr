#
# Generated file
#

@[Link("json-c")]
lib LibJsonC

  enum JsonType
    JsonTypeNull = 0
    JsonTypeBoolean = 1
    JsonTypeDouble = 2
    JsonTypeInt = 3
    JsonTypeObject = 4
    JsonTypeArray = 5
    JsonTypeString = 6
  end

  enum JsonTokenerError
    JsonTokenerSuccess = 0
    JsonTokenerContinue = 1
    JsonTokenerErrorDepth = 2
    JsonTokenerErrorParseEof = 3
    JsonTokenerErrorParseUnexpected = 4
    JsonTokenerErrorParseNull = 5
    JsonTokenerErrorParseBoolean = 6
    JsonTokenerErrorParseNumber = 7
    JsonTokenerErrorParseArray = 8
    JsonTokenerErrorParseObjectKeyName = 9
    JsonTokenerErrorParseObjectKeySep = 10
    JsonTokenerErrorParseObjectValueSep = 11
    JsonTokenerErrorParseString = 12
    JsonTokenerErrorParseComment = 13
    JsonTokenerErrorSize = 14
  end

  enum JsonTokenerState
    JsonTokenerStateEatws = 0
    JsonTokenerStateStart = 1
    JsonTokenerStateFinish = 2
    JsonTokenerStateNull = 3
    JsonTokenerStateCommentStart = 4
    JsonTokenerStateComment = 5
    JsonTokenerStateCommentEol = 6
    JsonTokenerStateCommentEnd = 7
    JsonTokenerStateString = 8
    JsonTokenerStateStringEscape = 9
    JsonTokenerStateEscapeUnicode = 10
    JsonTokenerStateBoolean = 11
    JsonTokenerStateNumber = 12
    JsonTokenerStateArray = 13
    JsonTokenerStateArrayAdd = 14
    JsonTokenerStateArraySep = 15
    JsonTokenerStateObjectFieldStart = 16
    JsonTokenerStateObjectField = 17
    JsonTokenerStateObjectFieldEnd = 18
    JsonTokenerStateObjectValue = 19
    JsonTokenerStateObjectValueAdd = 20
    JsonTokenerStateObjectSep = 21
    JsonTokenerStateArrayAfterSep = 22
    JsonTokenerStateObjectFieldStartAfterSep = 23
    JsonTokenerStateInf = 24
  end

  struct AnonStruct0
    __val : Int32[2]
  end
  struct AnonStruct1
    quot : Int32
    rem : Int32
  end
  struct AnonStruct2
    quot : Int64
    rem : Int64
  end
  struct AnonStruct3
    quot : Int64
    rem : Int64
  end
  struct AnonStruct4
    __val : UInt64[16]
  end
  struct Timespec
    tv_sec : X__time_t
    tv_nsec : X__syscall_slong_t
  end
  struct Timeval
    tv_sec : X__time_t
    tv_usec : X__suseconds_t
  end
  struct AnonStruct5
    __fds_bits : X__fd_mask[16]
  end
  struct X__pthread_internal_list
    __prev : X__pthread_internal_list*
    __next : X__pthread_internal_list*
  end
  struct RandomData
    fptr : Int32T*
    rptr : Int32T*
    state : Int32T*
    rand_type : Int32
    rand_deg : Int32
    rand_sep : Int32
    end_ptr : Int32T*
  end
  struct Drand48Data
    __x : UInt16[3]
    __old_x : UInt16[3]
    __c : UInt16
    __init : UInt16
    __a : UInt64
  end
  struct AnonStruct6
    quot : Int64
    rem : Int64
  end
  struct JsonObjectIter
    key : UInt8*
    val : JsonObject*
    entry : LhEntry*
  end
  struct Printbuf
    __data : UInt8[0]
  end
  struct LhTable
    size : Int32
    count : Int32
    collisions : Int32
    resizes : Int32
    lookups : Int32
    inserts : Int32
    deletes : Int32
    name : UInt8*
    head : LhEntry*
    tail : LhEntry*
    table : LhEntry*
    free_fn : LhEntryFreeFn*
    hash_fn : LhHashFn*
    equal_fn : LhEqualFn*
  end
  struct ArrayList
    array : Void**
    length : Int32
    size : Int32
    free_fn : ArrayListFreeFn*
  end
  struct JsonTokener
    str : UInt8*
    pb : Printbuf*
    max_depth : Int32
    depth : Int32
    is_double : Int32
    st_pos : Int32
    char_offset : Int32
    err : JsonTokenerError
    ucs_char : UInt32
    quote_char : Int8
    stack : JsonTokenerSrec*
    flags : Int32
  end
  struct LhEntry
    k : Void*
    v : Void*
    next : LhEntry*
    prev : LhEntry*
  end
  struct AnonStruct7
    __clang_max_align_nonce1 : Int64
    __clang_max_align_nonce2 : Float64
  end
  struct JsonTokenerSrec
    state : JsonTokenerState
    saved_state : JsonTokenerState
    obj : JsonObject*
    current : JsonObject*
    obj_field_name : UInt8*
  end
  struct JsonObjectIterInfo
    __data : UInt8[0]
  end
  struct JsonObjectIterator
    opaque_ : Void*
  end
  struct JsonObject
    __data : UInt8[0]
  end
  struct AnonStruct8
    __w_termsig : UInt32
    __w_coredump : UInt32
    __w_retcode : UInt32
  end
  struct AnonStruct9
    __w_stopval : UInt32
    __w_stopsig : UInt32
  end
  struct AnonStruct10
    __lock : Int32
    __futex : UInt32
    __total_seq : UInt64
    __wakeup_seq : UInt64
    __woken_seq : UInt64
    __mutex : Void*
    __nwaiters : UInt32
    __broadcast_seq : UInt32
  end
  struct AnonStruct11
    __lock : Int32
    __nr_readers : UInt32
    __readers_wakeup : UInt32
    __writer_wakeup : UInt32
    __nr_readers_queued : UInt32
    __nr_writers_queued : UInt32
    __writer : Int32
    __shared : Int32
    __rwelision : Int8
    __pad1 : UInt8[7]
    __pad2 : UInt64
    __flags : UInt32
  end
  struct X__va_list_tag
    gp_offset : UInt32
    fp_offset : UInt32
    overflow_arg_area : Void*
    reg_save_area : Void*
  end
  struct X__pthread_mutex_s
    __lock : Int32
    __count : UInt32
    __owner : Int32
    __nusers : UInt32
    __kind : Int32
    __spins : Int16
    __elision : Int16
    __list : X__pthread_list_t
  end
  union Wait
    w_status : Int32
        __wait_terminated : AnonStruct8
        __wait_stopped : AnonStruct9
  end
  union AnonUnion0
    __uptr : Wait*
    __iptr : Int32*
  end
  union PthreadAttrT
    __size : Int8[56]
    __align : Int64
  end
  union AnonUnion1
    __data : X__pthread_mutex_s
    __size : Int8[40]
    __align : Int64
  end
  union AnonUnion2
    __size : Int8[4]
    __align : Int32
  end
  union AnonUnion3
        __data : AnonStruct10
    __size : Int8[48]
    __align : Int64
  end
  union AnonUnion4
    __size : Int8[4]
    __align : Int32
  end
  union AnonUnion5
        __data : AnonStruct11
    __size : Int8[56]
    __align : Int64
  end
  union AnonUnion6
    __size : Int8[8]
    __align : Int64
  end
  union AnonUnion7
    __size : Int8[32]
    __align : Int64
  end
  union AnonUnion8
    __size : Int8[4]
    __align : Int32
  end
  alias X__int128_t = Int64
  alias X__uint128_t = UInt64
  alias X__builtin_ms_va_list = UInt8*
  alias X__builtin_va_list = X__va_list_tag*
  alias SizeT = UInt64
  alias WcharT = Int32
  alias X__u_char = UInt8
  alias X__u_short = UInt16
  alias X__u_int = UInt32
  alias X__u_long = UInt64
  alias X__int8_t = Int8
  alias X__uint8_t = UInt8
  alias X__int16_t = Int16
  alias X__uint16_t = UInt16
  alias X__int32_t = Int32
  alias X__uint32_t = UInt32
  alias X__int64_t = Int64
  alias X__uint64_t = UInt64
  alias X__quad_t = Int64
  alias X__u_quad_t = UInt64
  alias X__dev_t = UInt64
  alias X__uid_t = UInt32
  alias X__gid_t = UInt32
  alias X__ino_t = UInt64
  alias X__ino64_t = UInt64
  alias X__mode_t = UInt32
  alias X__nlink_t = UInt64
  alias X__off_t = Int64
  alias X__off64_t = Int64
  alias X__pid_t = Int32
  alias X__fsid_t = AnonStruct0
  alias X__clock_t = Int64
  alias X__rlim_t = UInt64
  alias X__rlim64_t = UInt64
  alias X__id_t = UInt32
  alias X__time_t = Int64
  alias X__useconds_t = UInt32
  alias X__suseconds_t = Int64
  alias X__daddr_t = Int32
  alias X__key_t = Int32
  alias X__clockid_t = Int32
  alias X__timer_t = Void*
  alias X__blksize_t = Int64
  alias X__blkcnt_t = Int64
  alias X__blkcnt64_t = Int64
  alias X__fsblkcnt_t = UInt64
  alias X__fsblkcnt64_t = UInt64
  alias X__fsfilcnt_t = UInt64
  alias X__fsfilcnt64_t = UInt64
  alias X__fsword_t = Int64
  alias X__ssize_t = Int64
  alias X__syscall_slong_t = Int64
  alias X__syscall_ulong_t = UInt64
  alias X__loff_t = X__off64_t
  alias X__qaddr_t = X__quad_t*
  alias X__caddr_t = UInt8*
  alias X__intptr_t = Int64
  alias X__socklen_t = UInt32
  alias X__WAIT_STATUS = AnonUnion0
  alias DivT = AnonStruct1
  alias LdivT = AnonStruct2
  alias LldivT = AnonStruct3
  alias UChar = X__u_char
  alias UShort = X__u_short
  alias UInt = X__u_int
  alias ULong = X__u_long
  alias QuadT = X__quad_t
  alias UQuadT = X__u_quad_t
  alias FsidT = X__fsid_t
  alias LoffT = X__loff_t
  alias InoT = X__ino_t
  alias DevT = X__dev_t
  alias GidT = X__gid_t
  alias ModeT = X__mode_t
  alias NlinkT = X__nlink_t
  alias UidT = X__uid_t
  alias OffT = X__off_t
  alias PidT = X__pid_t
  alias IdT = X__id_t
  alias SsizeT = X__ssize_t
  alias DaddrT = X__daddr_t
  alias CaddrT = X__caddr_t
  alias KeyT = X__key_t
  alias ClockT = X__clock_t
  alias TimeT = X__time_t
  alias ClockidT = X__clockid_t
  alias TimerT = X__timer_t
  alias Ulong = UInt64
  alias Ushort = UInt16
  alias Uint = UInt32
  alias Int8T = Int8
  alias Int16T = Int16
  alias Int32T = Int32
  alias Int64T = Int64
  alias UInt8T = UInt8
  alias UInt16T = UInt16
  alias UInt32T = UInt32
  alias UInt64T = UInt64
  alias RegisterT = Int64
  alias X__sig_atomic_t = Int32
  alias X__sigset_t = AnonStruct4
  alias SigsetT = X__sigset_t
  alias SusecondsT = X__suseconds_t
  alias X__fd_mask = Int64
  alias FdSet = AnonStruct5
  alias FdMask = X__fd_mask
  alias BlksizeT = X__blksize_t
  alias BlkcntT = X__blkcnt_t
  alias FsblkcntT = X__fsblkcnt_t
  alias FsfilcntT = X__fsfilcnt_t
  alias PthreadT = UInt64
  alias X__pthread_list_t = X__pthread_internal_list
  alias PthreadMutexT = AnonUnion1
  alias PthreadMutexattrT = AnonUnion2
  alias PthreadCondT = AnonUnion3
  alias PthreadCondattrT = AnonUnion4
  alias PthreadKeyT = UInt32
  alias PthreadOnceT = Int32
  alias PthreadRwlockT = AnonUnion5
  alias PthreadRwlockattrT = AnonUnion6
  alias PthreadSpinlockT = Int32
  alias PthreadBarrierT = AnonUnion7
  alias PthreadBarrierattrT = AnonUnion8
  alias X__compar_fn_t = ((Void*, Void*) -> Int32)
  alias Uint8T = UInt8
  alias Uint16T = UInt16
  alias Uint32T = UInt32
  alias Uint64T = UInt64
  alias IntLeast8T = Int8
  alias IntLeast16T = Int16
  alias IntLeast32T = Int32
  alias IntLeast64T = Int64
  alias UintLeast8T = UInt8
  alias UintLeast16T = UInt16
  alias UintLeast32T = UInt32
  alias UintLeast64T = UInt64
  alias IntFast8T = Int8
  alias IntFast16T = Int64
  alias IntFast32T = Int64
  alias IntFast64T = Int64
  alias UintFast8T = UInt8
  alias UintFast16T = UInt64
  alias UintFast32T = UInt64
  alias UintFast64T = UInt64
  alias IntptrT = Int64
  alias UintptrT = UInt64
  alias IntmaxT = Int64
  alias UintmaxT = UInt64
  alias X__gwchar_t = Int32
  alias ImaxdivT = AnonStruct6
  alias JsonBool = Int32
  alias JsonObjectDeleteFn = ((JsonObject*, Void*) -> Void)
  alias JsonObjectToJsonStringFn = ((JsonObject*, Printbuf*, Int32, Int32) -> Int32)
  alias LhEntryFreeFn = (LhEntry* -> Void)
  alias LhHashFn = (Void* -> UInt64)
  alias LhEqualFn = ((Void*, Void*) -> Int32)
  alias ArrayListFreeFn = (Void* -> Void)
  alias PtrdiffT = Int64
  alias MaxAlignT = AnonStruct7
  fun mc_set_debug(debug : Int32) : Void
  fun mc_get_debug : Int32
  fun mc_set_syslog(syslog : Int32) : Void
  fun mc_debug(msg : UInt8*) : Void
  fun mc_error(msg : UInt8*) : Void
  fun mc_info(msg : UInt8*) : Void
  fun json_object_get(obj : JsonObject*) : JsonObject*
  fun json_object_put(obj : JsonObject*) : Int32
  fun json_object_is_type(obj : JsonObject*, type : JsonType) : Int32
  fun json_object_get_type(obj : JsonObject*) : JsonType
  fun json_object_to_json_string(obj : JsonObject*) : UInt8*
  fun json_object_to_json_string_ext(obj : JsonObject*, flags : Int32) : UInt8*
  fun json_object_set_serializer(jso : JsonObject*, to_string_func : JsonObjectToJsonStringFn*, userdata : Void*, user_delete : JsonObjectDeleteFn*) : Void
  fun json_object_free_userdata(arg1 : JsonObject*, arg2 : Void*) : Void
  fun json_object_userdata_to_json_string(arg1 : JsonObject*, arg2 : Printbuf*, arg3 : Int32, arg4 : Int32) : Int32
  fun json_object_new_object : JsonObject*
  fun json_object_get_object(obj : JsonObject*) : LhTable*
  fun json_object_object_length(obj : JsonObject*) : Int32
  fun json_object_object_add(obj : JsonObject*, key : UInt8*, val : JsonObject*) : Void
  fun json_object_object_get(obj : JsonObject*, key : UInt8*) : JsonObject*
  fun json_object_object_get_ex(obj : JsonObject*, key : UInt8*, value : JsonObject**) : JsonBool
  fun json_object_object_del(obj : JsonObject*, key : UInt8*) : Void
  fun json_object_new_array : JsonObject*
  fun json_object_get_array(obj : JsonObject*) : ArrayList*
  fun json_object_array_length(obj : JsonObject*) : Int32
  fun json_object_array_sort(jso : JsonObject*, sort_fn : ((Void*, Void*) -> Int32)) : Void
  fun json_object_array_add(obj : JsonObject*, val : JsonObject*) : Int32
  fun json_object_array_put_idx(obj : JsonObject*, idx : Int32, val : JsonObject*) : Int32
  fun json_object_array_get_idx(obj : JsonObject*, idx : Int32) : JsonObject*
  fun json_object_new_boolean(b : JsonBool) : JsonObject*
  fun json_object_get_boolean(obj : JsonObject*) : JsonBool
  fun json_object_new_int(i : Int32T) : JsonObject*
  fun json_object_new_int64(i : Int64T) : JsonObject*
  fun json_object_get_int(obj : JsonObject*) : Int32T
  fun json_object_get_int64(obj : JsonObject*) : Int64T
  fun json_object_new_double(d : Float64) : JsonObject*
  fun json_object_new_double_s(d : Float64, ds : UInt8*) : JsonObject*
  fun json_object_get_double(obj : JsonObject*) : Float64
  fun json_object_new_string(s : UInt8*) : JsonObject*
  fun json_object_new_string_len(s : UInt8*, len : Int32) : JsonObject*
  fun json_object_get_string(obj : JsonObject*) : UInt8*
  fun json_object_get_string_len(obj : JsonObject*) : Int32
  fun lh_ptr_hash(k : Void*) : UInt64
  fun lh_ptr_equal(k1 : Void*, k2 : Void*) : Int32
  fun lh_char_hash(k : Void*) : UInt64
  fun lh_char_equal(k1 : Void*, k2 : Void*) : Int32
  fun lh_table_new(size : Int32, name : UInt8*, free_fn : LhEntryFreeFn*, hash_fn : LhHashFn*, equal_fn : LhEqualFn*) : LhTable*
  fun lh_kchar_table_new(size : Int32, name : UInt8*, free_fn : LhEntryFreeFn*) : LhTable*
  fun lh_kptr_table_new(size : Int32, name : UInt8*, free_fn : LhEntryFreeFn*) : LhTable*
  fun lh_table_free(t : LhTable*) : Void
  fun lh_table_insert(t : LhTable*, k : Void*, v : Void*) : Int32
  fun lh_table_lookup_entry(t : LhTable*, k : Void*) : LhEntry*
  fun lh_table_lookup(t : LhTable*, k : Void*) : Void*
  fun lh_table_lookup_ex(t : LhTable*, k : Void*, v : Void**) : JsonBool
  fun lh_table_delete_entry(t : LhTable*, e : LhEntry*) : Int32
  fun lh_table_delete(t : LhTable*, k : Void*) : Int32
  fun lh_table_length(t : LhTable*) : Int32
  fun lh_abort(msg : UInt8*) : Void
  fun lh_table_resize(t : LhTable*, new_size : Int32) : Void
  fun array_list_new(free_fn : ArrayListFreeFn*) : ArrayList*
  fun array_list_free(al : ArrayList*) : Void
  fun array_list_get_idx(al : ArrayList*, i : Int32) : Void*
  fun array_list_put_idx(al : ArrayList*, i : Int32, data : Void*) : Int32
  fun array_list_add(al : ArrayList*, data : Void*) : Int32
  fun array_list_length(al : ArrayList*) : Int32
  fun array_list_sort(arr : ArrayList*, compar : ((Void*, Void*) -> Int32)) : Void
  fun json_object_from_file(filename : UInt8*) : JsonObject*
  fun json_object_to_file(filename : UInt8*, obj : JsonObject*) : Int32
  fun json_object_to_file_ext(filename : UInt8*, obj : JsonObject*, flags : Int32) : Int32
  fun json_parse_int64(buf : UInt8*, retval : Int64T*) : Int32
  fun json_parse_double(buf : UInt8*, retval : Float64*) : Int32
  fun json_type_to_name(o_type : JsonType) : UInt8*
  fun json_tokener_error_desc(jerr : JsonTokenerError) : UInt8*
  fun json_tokener_get_error(tok : JsonTokener*) : JsonTokenerError
  fun json_tokener_new : JsonTokener*
  fun json_tokener_new_ex(depth : Int32) : JsonTokener*
  fun json_tokener_free(tok : JsonTokener*) : Void
  fun json_tokener_reset(tok : JsonTokener*) : Void
  fun json_tokener_parse(str : UInt8*) : JsonObject*
  fun json_tokener_parse_verbose(str : UInt8*, error : JsonTokenerError*) : JsonObject*
  fun json_tokener_set_flags(tok : JsonTokener*, flags : Int32) : Void
  fun json_tokener_parse_ex(tok : JsonTokener*, str : UInt8*, len : Int32) : JsonObject*
  fun json_object_iter_init_default : JsonObjectIterator
  fun json_object_iter_begin(obj : JsonObject*) : JsonObjectIterator
  fun json_object_iter_end(obj : JsonObject*) : JsonObjectIterator
  fun json_object_iter_next(iter : JsonObjectIterator*) : Void
  fun json_object_iter_peek_name(iter : JsonObjectIterator*) : UInt8*
  fun json_object_iter_peek_value(iter : JsonObjectIterator*) : JsonObject*
  fun json_object_iter_equal(iter1 : JsonObjectIterator*, iter2 : JsonObjectIterator*) : JsonBool
  fun json_c_version : UInt8*
  fun json_c_version_num : Int32
end

