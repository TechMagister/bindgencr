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
  alias Int32T = Int32
  alias Int64T = Int64
  alias JsonBool = Int32
  alias JsonObjectDeleteFn = ((JsonObject*, Void*) -> Void)
  alias JsonObjectToJsonStringFn = ((JsonObject*, Printbuf*, Int32, Int32) -> Int32)
  alias LhEntryFreeFn = (LhEntry* -> Void)
  alias LhHashFn = (Void* -> UInt64)
  alias LhEqualFn = ((Void*, Void*) -> Int32)
  alias ArrayListFreeFn = (Void* -> Void)
  fun mc_set_debug = mc_set_debug(debug : Int32) : Void
  fun mc_get_debug = mc_get_debug : Int32
  fun mc_set_syslog = mc_set_syslog(syslog : Int32) : Void
  fun mc_debug = mc_debug(msg : UInt8*) : Void
  fun mc_error = mc_error(msg : UInt8*) : Void
  fun mc_info = mc_info(msg : UInt8*) : Void
  fun object_get = json_object_get(obj : JsonObject*) : JsonObject*
  fun object_put = json_object_put(obj : JsonObject*) : Int32
  fun object_is_type = json_object_is_type(obj : JsonObject*, type : JsonType) : Int32
  fun object_get_type = json_object_get_type(obj : JsonObject*) : JsonType
  fun object_to_json_string = json_object_to_json_string(obj : JsonObject*) : UInt8*
  fun object_to_json_string_ext = json_object_to_json_string_ext(obj : JsonObject*, flags : Int32) : UInt8*
  fun object_set_serializer = json_object_set_serializer(jso : JsonObject*, to_string_func : JsonObjectToJsonStringFn*, userdata : Void*, user_delete : JsonObjectDeleteFn*) : Void
  fun object_free_userdata = json_object_free_userdata(arg1 : JsonObject*, arg2 : Void*) : Void
  fun object_userdata_to_json_string = json_object_userdata_to_json_string(arg1 : JsonObject*, arg2 : Printbuf*, arg3 : Int32, arg4 : Int32) : Int32
  fun object_new_object = json_object_new_object : JsonObject*
  fun object_get_object = json_object_get_object(obj : JsonObject*) : LhTable*
  fun object_object_length = json_object_object_length(obj : JsonObject*) : Int32
  fun object_object_add = json_object_object_add(obj : JsonObject*, key : UInt8*, val : JsonObject*) : Void
  fun object_object_get = json_object_object_get(obj : JsonObject*, key : UInt8*) : JsonObject*
  fun object_object_get_ex = json_object_object_get_ex(obj : JsonObject*, key : UInt8*, value : JsonObject**) : JsonBool
  fun object_object_del = json_object_object_del(obj : JsonObject*, key : UInt8*) : Void
  fun object_new_array = json_object_new_array : JsonObject*
  fun object_get_array = json_object_get_array(obj : JsonObject*) : ArrayList*
  fun object_array_length = json_object_array_length(obj : JsonObject*) : Int32
  fun object_array_sort = json_object_array_sort(jso : JsonObject*, sort_fn : ((Void*, Void*) -> Int32)) : Void
  fun object_array_add = json_object_array_add(obj : JsonObject*, val : JsonObject*) : Int32
  fun object_array_put_idx = json_object_array_put_idx(obj : JsonObject*, idx : Int32, val : JsonObject*) : Int32
  fun object_array_get_idx = json_object_array_get_idx(obj : JsonObject*, idx : Int32) : JsonObject*
  fun object_new_boolean = json_object_new_boolean(b : JsonBool) : JsonObject*
  fun object_get_boolean = json_object_get_boolean(obj : JsonObject*) : JsonBool
  fun object_new_int = json_object_new_int(i : Int32T) : JsonObject*
  fun object_new_int64 = json_object_new_int64(i : Int64T) : JsonObject*
  fun object_get_int = json_object_get_int(obj : JsonObject*) : Int32T
  fun object_get_int64 = json_object_get_int64(obj : JsonObject*) : Int64T
  fun object_new_double = json_object_new_double(d : Float64) : JsonObject*
  fun object_new_double_s = json_object_new_double_s(d : Float64, ds : UInt8*) : JsonObject*
  fun object_get_double = json_object_get_double(obj : JsonObject*) : Float64
  fun object_new_string = json_object_new_string(s : UInt8*) : JsonObject*
  fun object_new_string_len = json_object_new_string_len(s : UInt8*, len : Int32) : JsonObject*
  fun object_get_string = json_object_get_string(obj : JsonObject*) : UInt8*
  fun object_get_string_len = json_object_get_string_len(obj : JsonObject*) : Int32
  fun lh_ptr_hash = lh_ptr_hash(k : Void*) : UInt64
  fun lh_ptr_equal = lh_ptr_equal(k1 : Void*, k2 : Void*) : Int32
  fun lh_char_hash = lh_char_hash(k : Void*) : UInt64
  fun lh_char_equal = lh_char_equal(k1 : Void*, k2 : Void*) : Int32
  fun lh_table_new = lh_table_new(size : Int32, name : UInt8*, free_fn : LhEntryFreeFn*, hash_fn : LhHashFn*, equal_fn : LhEqualFn*) : LhTable*
  fun lh_kchar_table_new = lh_kchar_table_new(size : Int32, name : UInt8*, free_fn : LhEntryFreeFn*) : LhTable*
  fun lh_kptr_table_new = lh_kptr_table_new(size : Int32, name : UInt8*, free_fn : LhEntryFreeFn*) : LhTable*
  fun lh_table_free = lh_table_free(t : LhTable*) : Void
  fun lh_table_insert = lh_table_insert(t : LhTable*, k : Void*, v : Void*) : Int32
  fun lh_table_lookup_entry = lh_table_lookup_entry(t : LhTable*, k : Void*) : LhEntry*
  fun lh_table_lookup = lh_table_lookup(t : LhTable*, k : Void*) : Void*
  fun lh_table_lookup_ex = lh_table_lookup_ex(t : LhTable*, k : Void*, v : Void**) : JsonBool
  fun lh_table_delete_entry = lh_table_delete_entry(t : LhTable*, e : LhEntry*) : Int32
  fun lh_table_delete = lh_table_delete(t : LhTable*, k : Void*) : Int32
  fun lh_table_length = lh_table_length(t : LhTable*) : Int32
  fun lh_abort = lh_abort(msg : UInt8*) : Void
  fun lh_table_resize = lh_table_resize(t : LhTable*, new_size : Int32) : Void
  fun array_list_new = array_list_new(free_fn : ArrayListFreeFn*) : ArrayList*
  fun array_list_free = array_list_free(al : ArrayList*) : Void
  fun array_list_get_idx = array_list_get_idx(al : ArrayList*, i : Int32) : Void*
  fun array_list_put_idx = array_list_put_idx(al : ArrayList*, i : Int32, data : Void*) : Int32
  fun array_list_add = array_list_add(al : ArrayList*, data : Void*) : Int32
  fun array_list_length = array_list_length(al : ArrayList*) : Int32
  fun array_list_sort = array_list_sort(arr : ArrayList*, compar : ((Void*, Void*) -> Int32)) : Void
  fun object_from_file = json_object_from_file(filename : UInt8*) : JsonObject*
  fun object_to_file = json_object_to_file(filename : UInt8*, obj : JsonObject*) : Int32
  fun object_to_file_ext = json_object_to_file_ext(filename : UInt8*, obj : JsonObject*, flags : Int32) : Int32
  fun parse_int64 = json_parse_int64(buf : UInt8*, retval : Int64T*) : Int32
  fun parse_double = json_parse_double(buf : UInt8*, retval : Float64*) : Int32
  fun type_to_name = json_type_to_name(o_type : JsonType) : UInt8*
  fun tokener_error_desc = json_tokener_error_desc(jerr : JsonTokenerError) : UInt8*
  fun tokener_get_error = json_tokener_get_error(tok : JsonTokener*) : JsonTokenerError
  fun tokener_new = json_tokener_new : JsonTokener*
  fun tokener_new_ex = json_tokener_new_ex(depth : Int32) : JsonTokener*
  fun tokener_free = json_tokener_free(tok : JsonTokener*) : Void
  fun tokener_reset = json_tokener_reset(tok : JsonTokener*) : Void
  fun tokener_parse = json_tokener_parse(str : UInt8*) : JsonObject*
  fun tokener_parse_verbose = json_tokener_parse_verbose(str : UInt8*, error : JsonTokenerError*) : JsonObject*
  fun tokener_set_flags = json_tokener_set_flags(tok : JsonTokener*, flags : Int32) : Void
  fun tokener_parse_ex = json_tokener_parse_ex(tok : JsonTokener*, str : UInt8*, len : Int32) : JsonObject*
  fun object_iter_init_default = json_object_iter_init_default : JsonObjectIterator
  fun object_iter_begin = json_object_iter_begin(obj : JsonObject*) : JsonObjectIterator
  fun object_iter_end = json_object_iter_end(obj : JsonObject*) : JsonObjectIterator
  fun object_iter_next = json_object_iter_next(iter : JsonObjectIterator*) : Void
  fun object_iter_peek_name = json_object_iter_peek_name(iter : JsonObjectIterator*) : UInt8*
  fun object_iter_peek_value = json_object_iter_peek_value(iter : JsonObjectIterator*) : JsonObject*
  fun object_iter_equal = json_object_iter_equal(iter1 : JsonObjectIterator*, iter2 : JsonObjectIterator*) : JsonBool
  fun c_version = json_c_version : UInt8*
  fun c_version_num = json_c_version_num : Int32
end

