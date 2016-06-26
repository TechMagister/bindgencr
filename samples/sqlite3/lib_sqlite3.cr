#
# Generated file
#

@[Link("sqlite3")]
lib LibSqlite3

  struct Sqlite3
    __data : UInt8[0]
  end
  struct Sqlite3File
    pMethods : Sqlite3IoMethods*
  end
  struct Sqlite3IoMethods
    iVersion : Int32
    xClose : (Sqlite3File* -> Int32)
    xRead : ((Sqlite3File*, Void*, Int32, Sqlite3Int64) -> Int32)
    xWrite : ((Sqlite3File*, Void*, Int32, Sqlite3Int64) -> Int32)
    xTruncate : ((Sqlite3File*, Sqlite3Int64) -> Int32)
    xSync : ((Sqlite3File*, Int32) -> Int32)
    xFileSize : ((Sqlite3File*, Sqlite3Int64*) -> Int32)
    xLock : ((Sqlite3File*, Int32) -> Int32)
    xUnlock : ((Sqlite3File*, Int32) -> Int32)
    xCheckReservedLock : ((Sqlite3File*, Int32*) -> Int32)
    xFileControl : ((Sqlite3File*, Int32, Void*) -> Int32)
    xSectorSize : (Sqlite3File* -> Int32)
    xDeviceCharacteristics : (Sqlite3File* -> Int32)
    xShmMap : ((Sqlite3File*, Int32, Int32, Int32, Void**) -> Int32)
    xShmLock : ((Sqlite3File*, Int32, Int32, Int32) -> Int32)
    xShmBarrier : (Sqlite3File* -> Void)
    xShmUnmap : ((Sqlite3File*, Int32) -> Int32)
    xFetch : ((Sqlite3File*, Sqlite3Int64, Int32, Void**) -> Int32)
    xUnfetch : ((Sqlite3File*, Sqlite3Int64, Void*) -> Int32)
  end
  struct Sqlite3Mutex
    __data : UInt8[0]
  end
  struct Sqlite3Vfs
    iVersion : Int32
    szOsFile : Int32
    mxPathname : Int32
    pNext : Sqlite3Vfs*
    zName : Int8*
    pAppData : Void*
    xOpen : ((Sqlite3Vfs*, Int8*, Sqlite3File*, Int32, Int32*) -> Int32)
    xDelete : ((Sqlite3Vfs*, Int8*, Int32) -> Int32)
    xAccess : ((Sqlite3Vfs*, Int8*, Int32, Int32*) -> Int32)
    xFullPathname : ((Sqlite3Vfs*, Int8*, Int32, Int8*) -> Int32)
    xDlOpen : ((Sqlite3Vfs*, Int8*) -> Void*)
    xDlError : ((Sqlite3Vfs*, Int32, Int8*) -> Void)
    xDlSym : ((Sqlite3Vfs*, Void*, Int8*) -> (( -> Void)))
    xDlClose : ((Sqlite3Vfs*, Void*) -> Void)
    xRandomness : ((Sqlite3Vfs*, Int32, Int8*) -> Int32)
    xSleep : ((Sqlite3Vfs*, Int32) -> Int32)
    xCurrentTime : ((Sqlite3Vfs*, Float64*) -> Int32)
    xGetLastError : ((Sqlite3Vfs*, Int32, Int8*) -> Int32)
    xCurrentTimeInt64 : ((Sqlite3Vfs*, Sqlite3Int64*) -> Int32)
    xSetSystemCall : ((Sqlite3Vfs*, Int8*, Sqlite3SyscallPtr) -> Int32)
    xGetSystemCall : ((Sqlite3Vfs*, Int8*) -> Sqlite3SyscallPtr)
    xNextSystemCall : ((Sqlite3Vfs*, Int8*) -> Int8*)
  end
  struct Sqlite3MemMethods
    xMalloc : (Int32 -> Void*)
    xFree : (Void* -> Void)
    xRealloc : ((Void*, Int32) -> Void*)
    xSize : (Void* -> Int32)
    xRoundup : (Int32 -> Int32)
    xInit : (Void* -> Int32)
    xShutdown : (Void* -> Void)
    pAppData : Void*
  end
  struct Sqlite3Stmt
    __data : UInt8[0]
  end
  struct Mem
    __data : UInt8[0]
  end
  struct Sqlite3Context
    __data : UInt8[0]
  end
  struct Sqlite3Vtab
    pModule : Sqlite3Module*
    nRef : Int32
    zErrMsg : Int8*
  end
  struct Sqlite3IndexInfo
    nConstraint : Int32
    aConstraint : Sqlite3IndexConstraint*
    nOrderBy : Int32
    aOrderBy : Sqlite3IndexOrderby*
    aConstraintUsage : Sqlite3IndexConstraintUsage*
    idxNum : Int32
    idxStr : Int8*
    needToFreeIdxStr : Int32
    orderByConsumed : Int32
    estimatedCost : Float64
    estimatedRows : Sqlite3Int64
    idxFlags : Int32
    colUsed : Sqlite3Uint64
  end
  struct Sqlite3VtabCursor
    pVtab : Sqlite3Vtab*
  end
  struct Sqlite3Module
    iVersion : Int32
    xCreate : ((Sqlite3*, Void*, Int32, Int8**, Sqlite3Vtab**, Int8**) -> Int32)
    xConnect : ((Sqlite3*, Void*, Int32, Int8**, Sqlite3Vtab**, Int8**) -> Int32)
    xBestIndex : ((Sqlite3Vtab*, Sqlite3IndexInfo*) -> Int32)
    xDisconnect : (Sqlite3Vtab* -> Int32)
    xDestroy : (Sqlite3Vtab* -> Int32)
    xOpen : ((Sqlite3Vtab*, Sqlite3VtabCursor**) -> Int32)
    xClose : (Sqlite3VtabCursor* -> Int32)
    xFilter : ((Sqlite3VtabCursor*, Int32, Int8*, Int32, Sqlite3Value**) -> Int32)
    xNext : (Sqlite3VtabCursor* -> Int32)
    xEof : (Sqlite3VtabCursor* -> Int32)
    xColumn : ((Sqlite3VtabCursor*, Sqlite3Context*, Int32) -> Int32)
    xRowid : ((Sqlite3VtabCursor*, Sqlite3Int64*) -> Int32)
    xUpdate : ((Sqlite3Vtab*, Int32, Sqlite3Value**, Sqlite3Int64*) -> Int32)
    xBegin : (Sqlite3Vtab* -> Int32)
    xSync : (Sqlite3Vtab* -> Int32)
    xCommit : (Sqlite3Vtab* -> Int32)
    xRollback : (Sqlite3Vtab* -> Int32)
    xFindFunction : ((Sqlite3Vtab*, Int32, Int8*, ((Sqlite3Context*, Int32, Sqlite3Value**) -> Void)*, Void**) -> Int32)
    xRename : ((Sqlite3Vtab*, Int8*) -> Int32)
    xSavepoint : ((Sqlite3Vtab*, Int32) -> Int32)
    xRelease : ((Sqlite3Vtab*, Int32) -> Int32)
    xRollbackTo : ((Sqlite3Vtab*, Int32) -> Int32)
  end
  struct Sqlite3Blob
    __data : UInt8[0]
  end
  struct Sqlite3MutexMethods
    xMutexInit : ( -> Int32)
    xMutexEnd : ( -> Int32)
    xMutexAlloc : (Int32 -> Sqlite3Mutex*)
    xMutexFree : (Sqlite3Mutex* -> Void)
    xMutexEnter : (Sqlite3Mutex* -> Void)
    xMutexTry : (Sqlite3Mutex* -> Int32)
    xMutexLeave : (Sqlite3Mutex* -> Void)
    xMutexHeld : (Sqlite3Mutex* -> Int32)
    xMutexNotheld : (Sqlite3Mutex* -> Int32)
  end
  struct Sqlite3Pcache
    __data : UInt8[0]
  end
  struct Sqlite3PcachePage
    pBuf : Void*
    pExtra : Void*
  end
  struct Sqlite3PcacheMethods2
    iVersion : Int32
    pArg : Void*
    xInit : (Void* -> Int32)
    xShutdown : (Void* -> Void)
    xCreate : ((Int32, Int32, Int32) -> Sqlite3Pcache*)
    xCachesize : ((Sqlite3Pcache*, Int32) -> Void)
    xPagecount : (Sqlite3Pcache* -> Int32)
    xFetch : ((Sqlite3Pcache*, UInt32, Int32) -> Sqlite3PcachePage*)
    xUnpin : ((Sqlite3Pcache*, Sqlite3PcachePage*, Int32) -> Void)
    xRekey : ((Sqlite3Pcache*, Sqlite3PcachePage*, UInt32, UInt32) -> Void)
    xTruncate : ((Sqlite3Pcache*, UInt32) -> Void)
    xDestroy : (Sqlite3Pcache* -> Void)
    xShrink : (Sqlite3Pcache* -> Void)
  end
  struct Sqlite3PcacheMethods
    pArg : Void*
    xInit : (Void* -> Int32)
    xShutdown : (Void* -> Void)
    xCreate : ((Int32, Int32) -> Sqlite3Pcache*)
    xCachesize : ((Sqlite3Pcache*, Int32) -> Void)
    xPagecount : (Sqlite3Pcache* -> Int32)
    xFetch : ((Sqlite3Pcache*, UInt32, Int32) -> Void*)
    xUnpin : ((Sqlite3Pcache*, Void*, Int32) -> Void)
    xRekey : ((Sqlite3Pcache*, Void*, UInt32, UInt32) -> Void)
    xTruncate : ((Sqlite3Pcache*, UInt32) -> Void)
    xDestroy : (Sqlite3Pcache* -> Void)
  end
  struct Sqlite3Backup
    __data : UInt8[0]
  end
  struct Sqlite3Snapshot
    __data : UInt8[0]
  end
  struct Sqlite3RtreeGeometry
    pContext : Void*
    nParam : Int32
    aParam : Sqlite3RtreeDbl*
    pUser : Void*
    xDelUser : (Void* -> Void)
  end
  struct Sqlite3RtreeQueryInfo
    pContext : Void*
    nParam : Int32
    aParam : Sqlite3RtreeDbl*
    pUser : Void*
    xDelUser : (Void* -> Void)
    aCoord : Sqlite3RtreeDbl*
    anQueue : UInt32*
    nCoord : Int32
    iLevel : Int32
    mxLevel : Int32
    iRowid : Sqlite3Int64
    rParentScore : Sqlite3RtreeDbl
    eParentWithin : Int32
    eWithin : Int32
    rScore : Sqlite3RtreeDbl
    apSqlParam : Sqlite3Value**
  end
  struct Fts5ExtensionApi
    iVersion : Int32
    xUserData : (Fts5Context* -> Void*)
    xColumnCount : (Fts5Context* -> Int32)
    xRowCount : ((Fts5Context*, Sqlite3Int64*) -> Int32)
    xColumnTotalSize : ((Fts5Context*, Int32, Sqlite3Int64*) -> Int32)
    xTokenize : ((Fts5Context*, Int8*, Int32, Void*, ((Void*, Int32, Int8*, Int32, Int32, Int32) -> Int32)) -> Int32)
    xPhraseCount : (Fts5Context* -> Int32)
    xPhraseSize : ((Fts5Context*, Int32) -> Int32)
    xInstCount : ((Fts5Context*, Int32*) -> Int32)
    xInst : ((Fts5Context*, Int32, Int32*, Int32*, Int32*) -> Int32)
    xRowid : (Fts5Context* -> Sqlite3Int64)
    xColumnText : ((Fts5Context*, Int32, Int8**, Int32*) -> Int32)
    xColumnSize : ((Fts5Context*, Int32, Int32*) -> Int32)
    xQueryPhrase : ((Fts5Context*, Int32, Void*, ((Fts5ExtensionApi*, Fts5Context*, Void*) -> Int32)) -> Int32)
    xSetAuxdata : ((Fts5Context*, Void*, (Void* -> Void)) -> Int32)
    xGetAuxdata : ((Fts5Context*, Int32) -> Void*)
    xPhraseFirst : ((Fts5Context*, Int32, Fts5PhraseIter*, Int32*, Int32*) -> Int32)
    xPhraseNext : ((Fts5Context*, Fts5PhraseIter*, Int32*, Int32*) -> Void)
    xPhraseFirstColumn : ((Fts5Context*, Int32, Fts5PhraseIter*, Int32*) -> Int32)
    xPhraseNextColumn : ((Fts5Context*, Fts5PhraseIter*, Int32*) -> Void)
  end
  struct Fts5Context
    __data : UInt8[0]
  end
  struct Fts5PhraseIter
    a : UInt8*
    b : UInt8*
  end
  struct Fts5Tokenizer
    xCreate : ((Void*, Int8**, Int32, Fts5Tokenizer**) -> Int32)
    xDelete : (Fts5Tokenizer* -> Void)
    xTokenize : ((Fts5Tokenizer*, Void*, Int32, Int8*, Int32, ((Void*, Int32, Int8*, Int32, Int32, Int32) -> Int32)) -> Int32)
  end
  struct Fts5Api
    iVersion : Int32
    xCreateTokenizer : ((Fts5Api*, Int8*, Void*, Fts5Tokenizer*, (Void* -> Void)) -> Int32)
    xFindTokenizer : ((Fts5Api*, Int8*, Void**, Fts5Tokenizer*) -> Int32)
    xCreateFunction : ((Fts5Api*, Int8*, Void*, Fts5ExtensionFunction, (Void* -> Void)) -> Int32)
  end
  struct X__va_list_tag
    gp_offset : UInt32
    fp_offset : UInt32
    overflow_arg_area : Void*
    reg_save_area : Void*
  end
  struct Sqlite3IndexConstraint
    __data : UInt8[0]
  end
  struct Sqlite3IndexOrderby
    __data : UInt8[0]
  end
  struct Sqlite3IndexConstraintUsage
    __data : UInt8[0]
  end
  alias X__int128_t = Int64
  alias X__uint128_t = UInt64
  alias X__builtin_ms_va_list = Int8*
  alias X__builtin_va_list = X__va_list_tag*
  alias VaList = X__builtin_va_list
  alias X__gnuc_va_list = X__builtin_va_list
  alias SqliteInt64 = Int64
  alias SqliteUint64 = UInt64
  alias Sqlite3Int64 = SqliteInt64
  alias Sqlite3Uint64 = SqliteUint64
  alias Sqlite3Callback = ((Void*, Int32, Int8**, Int8**) -> Int32)
  alias Sqlite3SyscallPtr = ( -> Void)
  alias Sqlite3Value = Mem
  alias Sqlite3DestructorType = (Void* -> Void)
  alias Sqlite3RtreeDbl = Float64
  alias Fts5ExtensionFunction = ((Fts5ExtensionApi*, Fts5Context*, Sqlite3Context*, Int32, Sqlite3Value**) -> Void)
  fun sqlite3_libversion : Int8*
  fun sqlite3_sourceid : Int8*
  fun sqlite3_libversion_number : Int32
  fun sqlite3_compileoption_used(z_opt_name : Int8*) : Int32
  fun sqlite3_compileoption_get(n : Int32) : Int8*
  fun sqlite3_threadsafe : Int32
  fun sqlite3_close : Int32
  fun sqlite3_close_v2 : Int32
  fun sqlite3_exec(sql : Int8*, callback : ((Void*, Int32, Int8**, Int8**) -> Int32), errmsg : Int8**) : Int32
  fun sqlite3_initialize : Int32
  fun sqlite3_shutdown : Int32
  fun sqlite3_os_init : Int32
  fun sqlite3_os_end : Int32
  fun sqlite3_config : Int32
  fun sqlite3_db_config(op : Int32) : Int32
  fun sqlite3_extended_result_codes(onoff : Int32) : Int32
  fun sqlite3_last_insert_rowid : Sqlite3Int64
  fun sqlite3_changes : Int32
  fun sqlite3_total_changes : Int32
  fun sqlite3_interrupt : Void
  fun sqlite3_complete(sql : Int8*) : Int32
  fun sqlite3_complete16(sql : Void*) : Int32
  fun sqlite3_busy_handler : Int32
  fun sqlite3_busy_timeout(ms : Int32) : Int32
  fun sqlite3_get_table(db : Sqlite3*, z_sql : Int8*, paz_result : Int8***, pn_row : Int32*, pn_column : Int32*, pz_errmsg : Int8**) : Int32
  fun sqlite3_free_table(result : Int8**) : Void
  fun sqlite3_mprintf : Int8*
  fun sqlite3_vmprintf : Int8*
  fun sqlite3_snprintf : Int8*
  fun sqlite3_vsnprintf : Int8*
  fun sqlite3_malloc : Void*
  fun sqlite3_malloc64 : Void*
  fun sqlite3_realloc : Void*
  fun sqlite3_realloc64 : Void*
  fun sqlite3_free : Void
  fun sqlite3_msize : Sqlite3Uint64
  fun sqlite3_memory_used : Sqlite3Int64
  fun sqlite3_memory_highwater(reset_flag : Int32) : Sqlite3Int64
  fun sqlite3_randomness(n : Int32, p : Void*) : Void
  fun sqlite3_set_authorizer(x_auth : ((Void*, Int32, Int8*, Int8*, Int8*, Int8*) -> Int32), p_user_data : Void*) : Int32
  fun sqlite3_trace(x_trace : ((Void*, Int8*) -> Void)) : Void*
  fun sqlite3_profile(x_profile : ((Void*, Int8*, Sqlite3Uint64) -> Void)) : Void*
  fun sqlite3_progress_handler : Void
  fun sqlite3_open(filename : Int8*, pp_db : Sqlite3**) : Int32
  fun sqlite3_open16(filename : Void*, pp_db : Sqlite3**) : Int32
  fun sqlite3_open_v2(filename : Int8*, pp_db : Sqlite3**, flags : Int32, z_vfs : Int8*) : Int32
  fun sqlite3_uri_parameter(z_filename : Int8*, z_param : Int8*) : Int8*
  fun sqlite3_uri_boolean(z_file : Int8*, z_param : Int8*, b_default : Int32) : Int32
  fun sqlite3_uri_int64 : Sqlite3Int64
  fun sqlite3_errcode(db : Sqlite3*) : Int32
  fun sqlite3_extended_errcode(db : Sqlite3*) : Int32
  fun sqlite3_errmsg : Int8*
  fun sqlite3_errmsg16 : Void*
  fun sqlite3_errstr : Int8*
  fun sqlite3_limit(id : Int32, new_val : Int32) : Int32
  fun sqlite3_prepare(db : Sqlite3*, z_sql : Int8*, n_byte : Int32, pp_stmt : Sqlite3Stmt**, pz_tail : Int8**) : Int32
  fun sqlite3_prepare_v2(db : Sqlite3*, z_sql : Int8*, n_byte : Int32, pp_stmt : Sqlite3Stmt**, pz_tail : Int8**) : Int32
  fun sqlite3_prepare16(db : Sqlite3*, z_sql : Void*, n_byte : Int32, pp_stmt : Sqlite3Stmt**, pz_tail : Void**) : Int32
  fun sqlite3_prepare16_v2(db : Sqlite3*, z_sql : Void*, n_byte : Int32, pp_stmt : Sqlite3Stmt**, pz_tail : Void**) : Int32
  fun sqlite3_sql(p_stmt : Sqlite3Stmt*) : Int8*
  fun sqlite3_stmt_readonly(p_stmt : Sqlite3Stmt*) : Int32
  fun sqlite3_stmt_busy : Int32
  fun sqlite3_bind_blob(n : Int32) : Int32
  fun sqlite3_bind_blob64 : Int32
  fun sqlite3_bind_double : Int32
  fun sqlite3_bind_int : Int32
  fun sqlite3_bind_int64 : Int32
  fun sqlite3_bind_null : Int32
  fun sqlite3_bind_text : Int32
  fun sqlite3_bind_text16 : Int32
  fun sqlite3_bind_text64(encoding : UInt8) : Int32
  fun sqlite3_bind_value : Int32
  fun sqlite3_bind_zeroblob(n : Int32) : Int32
  fun sqlite3_bind_zeroblob64 : Int32
  fun sqlite3_bind_parameter_count : Int32
  fun sqlite3_bind_parameter_name : Int8*
  fun sqlite3_bind_parameter_index(z_name : Int8*) : Int32
  fun sqlite3_clear_bindings : Int32
  fun sqlite3_column_count(p_stmt : Sqlite3Stmt*) : Int32
  fun sqlite3_column_name(n : Int32) : Int8*
  fun sqlite3_column_name16(n : Int32) : Void*
  fun sqlite3_column_database_name : Int8*
  fun sqlite3_column_database_name16 : Void*
  fun sqlite3_column_table_name : Int8*
  fun sqlite3_column_table_name16 : Void*
  fun sqlite3_column_origin_name : Int8*
  fun sqlite3_column_origin_name16 : Void*
  fun sqlite3_column_decltype : Int8*
  fun sqlite3_column_decltype16 : Void*
  fun sqlite3_step : Int32
  fun sqlite3_data_count(p_stmt : Sqlite3Stmt*) : Int32
  fun sqlite3_column_blob(i_col : Int32) : Void*
  fun sqlite3_column_bytes(i_col : Int32) : Int32
  fun sqlite3_column_bytes16(i_col : Int32) : Int32
  fun sqlite3_column_double(i_col : Int32) : Float64
  fun sqlite3_column_int(i_col : Int32) : Int32
  fun sqlite3_column_int64(i_col : Int32) : Sqlite3Int64
  fun sqlite3_column_text(i_col : Int32) : UInt8*
  fun sqlite3_column_text16(i_col : Int32) : Void*
  fun sqlite3_column_type(i_col : Int32) : Int32
  fun sqlite3_column_value(i_col : Int32) : Sqlite3Value*
  fun sqlite3_finalize(p_stmt : Sqlite3Stmt*) : Int32
  fun sqlite3_reset(p_stmt : Sqlite3Stmt*) : Int32
  fun sqlite3_create_function(db : Sqlite3*, z_function_name : Int8*, n_arg : Int32, e_text_rep : Int32, p_app : Void*, x_func : ((Sqlite3Context*, Int32, Sqlite3Value**) -> Void), x_step : ((Sqlite3Context*, Int32, Sqlite3Value**) -> Void), x_final : (Sqlite3Context* -> Void)) : Int32
  fun sqlite3_create_function16(db : Sqlite3*, z_function_name : Void*, n_arg : Int32, e_text_rep : Int32, p_app : Void*, x_func : ((Sqlite3Context*, Int32, Sqlite3Value**) -> Void), x_step : ((Sqlite3Context*, Int32, Sqlite3Value**) -> Void), x_final : (Sqlite3Context* -> Void)) : Int32
  fun sqlite3_create_function_v2(db : Sqlite3*, z_function_name : Int8*, n_arg : Int32, e_text_rep : Int32, p_app : Void*, x_func : ((Sqlite3Context*, Int32, Sqlite3Value**) -> Void), x_step : ((Sqlite3Context*, Int32, Sqlite3Value**) -> Void), x_final : (Sqlite3Context* -> Void), x_destroy : (Void* -> Void)) : Int32
  fun sqlite3_aggregate_count : Int32
  fun sqlite3_expired : Int32
  fun sqlite3_transfer_bindings : Int32
  fun sqlite3_global_recover : Int32
  fun sqlite3_thread_cleanup : Void
  fun sqlite3_memory_alarm : Int32
  fun sqlite3_value_blob : Void*
  fun sqlite3_value_bytes : Int32
  fun sqlite3_value_bytes16 : Int32
  fun sqlite3_value_double : Float64
  fun sqlite3_value_int : Int32
  fun sqlite3_value_int64 : Sqlite3Int64
  fun sqlite3_value_text : UInt8*
  fun sqlite3_value_text16 : Void*
  fun sqlite3_value_text16le : Void*
  fun sqlite3_value_text16be : Void*
  fun sqlite3_value_type : Int32
  fun sqlite3_value_numeric_type : Int32
  fun sqlite3_value_subtype : UInt32
  fun sqlite3_value_dup : Sqlite3Value*
  fun sqlite3_value_free : Void
  fun sqlite3_aggregate_context(n_bytes : Int32) : Void*
  fun sqlite3_user_data : Void*
  fun sqlite3_context_db_handle : Sqlite3*
  fun sqlite3_get_auxdata(n : Int32) : Void*
  fun sqlite3_set_auxdata(n : Int32) : Void
  fun sqlite3_result_blob : Void
  fun sqlite3_result_blob64 : Void
  fun sqlite3_result_double : Void
  fun sqlite3_result_error : Void
  fun sqlite3_result_error16 : Void
  fun sqlite3_result_error_toobig : Void
  fun sqlite3_result_error_nomem : Void
  fun sqlite3_result_error_code : Void
  fun sqlite3_result_int : Void
  fun sqlite3_result_int64 : Void
  fun sqlite3_result_null : Void
  fun sqlite3_result_text : Void
  fun sqlite3_result_text64(encoding : UInt8) : Void
  fun sqlite3_result_text16 : Void
  fun sqlite3_result_text16le : Void
  fun sqlite3_result_text16be : Void
  fun sqlite3_result_value : Void
  fun sqlite3_result_zeroblob(n : Int32) : Void
  fun sqlite3_result_zeroblob64(n : Sqlite3Uint64) : Int32
  fun sqlite3_result_subtype : Void
  fun sqlite3_create_collation(z_name : Int8*, e_text_rep : Int32, p_arg : Void*, x_compare : ((Void*, Int32, Void*, Int32, Void*) -> Int32)) : Int32
  fun sqlite3_create_collation_v2(z_name : Int8*, e_text_rep : Int32, p_arg : Void*, x_compare : ((Void*, Int32, Void*, Int32, Void*) -> Int32), x_destroy : (Void* -> Void)) : Int32
  fun sqlite3_create_collation16(z_name : Void*, e_text_rep : Int32, p_arg : Void*, x_compare : ((Void*, Int32, Void*, Int32, Void*) -> Int32)) : Int32
  fun sqlite3_collation_needed : Int32
  fun sqlite3_collation_needed16 : Int32
  fun sqlite3_sleep : Int32
  fun sqlite3_get_autocommit : Int32
  fun sqlite3_db_handle : Sqlite3*
  fun sqlite3_db_filename(db : Sqlite3*, z_db_name : Int8*) : Int8*
  fun sqlite3_db_readonly(db : Sqlite3*, z_db_name : Int8*) : Int32
  fun sqlite3_next_stmt(p_db : Sqlite3*, p_stmt : Sqlite3Stmt*) : Sqlite3Stmt*
  fun sqlite3_commit_hook : Void*
  fun sqlite3_rollback_hook : Void*
  fun sqlite3_update_hook : Void*
  fun sqlite3_enable_shared_cache : Int32
  fun sqlite3_release_memory : Int32
  fun sqlite3_db_release_memory : Int32
  fun sqlite3_soft_heap_limit64(n : Sqlite3Int64) : Sqlite3Int64
  fun sqlite3_soft_heap_limit(n : Int32) : Void
  fun sqlite3_table_column_metadata(db : Sqlite3*, z_db_name : Int8*, z_table_name : Int8*, z_column_name : Int8*, pz_data_type : Int8**, pz_coll_seq : Int8**, p_not_null : Int32*, p_primary_key : Int32*, p_autoinc : Int32*) : Int32
  fun sqlite3_load_extension(db : Sqlite3*, z_file : Int8*, z_proc : Int8*, pz_err_msg : Int8**) : Int32
  fun sqlite3_enable_load_extension(db : Sqlite3*, onoff : Int32) : Int32
  fun sqlite3_auto_extension(x_entry_point : ( -> Void)) : Int32
  fun sqlite3_cancel_auto_extension(x_entry_point : ( -> Void)) : Int32
  fun sqlite3_reset_auto_extension : Void
  fun sqlite3_create_module(db : Sqlite3*, z_name : Int8*, p : Sqlite3Module*, p_client_data : Void*) : Int32
  fun sqlite3_create_module_v2(db : Sqlite3*, z_name : Int8*, p : Sqlite3Module*, p_client_data : Void*, x_destroy : (Void* -> Void)) : Int32
  fun sqlite3_declare_vtab(z_sql : Int8*) : Int32
  fun sqlite3_overload_function(z_func_name : Int8*, n_arg : Int32) : Int32
  fun sqlite3_blob_open(z_db : Int8*, z_table : Int8*, z_column : Int8*, i_row : Sqlite3Int64, flags : Int32, pp_blob : Sqlite3Blob**) : Int32
  fun sqlite3_blob_reopen : Int32
  fun sqlite3_blob_close : Int32
  fun sqlite3_blob_bytes : Int32
  fun sqlite3_blob_read(z : Void*, n : Int32, i_offset : Int32) : Int32
  fun sqlite3_blob_write(z : Void*, n : Int32, i_offset : Int32) : Int32
  fun sqlite3_vfs_find(z_vfs_name : Int8*) : Sqlite3Vfs*
  fun sqlite3_vfs_register(make_dflt : Int32) : Int32
  fun sqlite3_vfs_unregister : Int32
  fun sqlite3_mutex_alloc : Sqlite3Mutex*
  fun sqlite3_mutex_free : Void
  fun sqlite3_mutex_enter : Void
  fun sqlite3_mutex_try : Int32
  fun sqlite3_mutex_leave : Void
  fun sqlite3_mutex_held : Int32
  fun sqlite3_mutex_notheld : Int32
  fun sqlite3_db_mutex : Sqlite3Mutex*
  fun sqlite3_file_control(z_db_name : Int8*, op : Int32) : Int32
  fun sqlite3_test_control(op : Int32) : Int32
  fun sqlite3_status(op : Int32, p_current : Int32*, p_highwater : Int32*, reset_flag : Int32) : Int32
  fun sqlite3_status64(op : Int32, p_current : Sqlite3Int64*, p_highwater : Sqlite3Int64*, reset_flag : Int32) : Int32
  fun sqlite3_db_status(op : Int32, p_cur : Int32*, p_hiwtr : Int32*, reset_flg : Int32) : Int32
  fun sqlite3_stmt_status(op : Int32, reset_flg : Int32) : Int32
  fun sqlite3_backup_init(p_dest : Sqlite3*, z_dest_name : Int8*, p_source : Sqlite3*, z_source_name : Int8*) : Sqlite3Backup*
  fun sqlite3_backup_step(p : Sqlite3Backup*, n_page : Int32) : Int32
  fun sqlite3_backup_finish(p : Sqlite3Backup*) : Int32
  fun sqlite3_backup_remaining(p : Sqlite3Backup*) : Int32
  fun sqlite3_backup_pagecount(p : Sqlite3Backup*) : Int32
  fun sqlite3_unlock_notify(p_blocked : Sqlite3*, x_notify : ((Void**, Int32) -> Void), p_notify_arg : Void*) : Int32
  fun sqlite3_stricmp : Int32
  fun sqlite3_strnicmp : Int32
  fun sqlite3_strglob(z_glob : Int8*, z_str : Int8*) : Int32
  fun sqlite3_strlike(z_glob : Int8*, z_str : Int8*, c_esc : UInt32) : Int32
  fun sqlite3_log(i_err_code : Int32, z_format : Int8*) : Void
  fun sqlite3_wal_hook : Void*
  fun sqlite3_wal_autocheckpoint(db : Sqlite3*, n : Int32) : Int32
  fun sqlite3_wal_checkpoint(db : Sqlite3*, z_db : Int8*) : Int32
  fun sqlite3_wal_checkpoint_v2(db : Sqlite3*, z_db : Int8*, e_mode : Int32, pn_log : Int32*, pn_ckpt : Int32*) : Int32
  fun sqlite3_vtab_config(op : Int32) : Int32
  fun sqlite3_vtab_on_conflict : Int32
  fun sqlite3_stmt_scanstatus(p_stmt : Sqlite3Stmt*, idx : Int32, i_scan_status_op : Int32, p_out : Void*) : Int32
  fun sqlite3_stmt_scanstatus_reset : Void
  fun sqlite3_db_cacheflush : Int32
  fun sqlite3_preupdate_hook(db : Sqlite3*, x_pre_update : ((Void*, Sqlite3*, Int32, Int8*, Int8*, Sqlite3Int64, Sqlite3Int64) -> Void)) : Void*
  fun sqlite3_preupdate_old : Int32
  fun sqlite3_preupdate_count : Int32
  fun sqlite3_preupdate_depth : Int32
  fun sqlite3_preupdate_new : Int32
  fun sqlite3_system_errno : Int32
  fun sqlite3_snapshot_get(db : Sqlite3*, z_schema : Int8*, pp_snapshot : Sqlite3Snapshot**) : Int32
  fun sqlite3_snapshot_open(db : Sqlite3*, z_schema : Int8*, p_snapshot : Sqlite3Snapshot*) : Int32
  fun sqlite3_snapshot_free : Void
  fun sqlite3_snapshot_cmp(p1 : Sqlite3Snapshot*, p2 : Sqlite3Snapshot*) : Int32
  fun sqlite3_rtree_geometry_callback(db : Sqlite3*, z_geom : Int8*, x_geom : ((Sqlite3RtreeGeometry*, Int32, Sqlite3RtreeDbl*, Int32*) -> Int32), p_context : Void*) : Int32
  fun sqlite3_rtree_query_callback(db : Sqlite3*, z_query_func : Int8*, x_query_func : (Sqlite3RtreeQueryInfo* -> Int32), p_context : Void*, x_destructor : (Void* -> Void)) : Int32
end

