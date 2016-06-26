#sqlite3 *db;
#char *zErrMsg = 0;
#int rc;

require "./lib_sqlite3"


orig = LibSqlite3::Sqlite3.new
db =  pointerof(orig)  
rc = LibSqlite3.sqlite3_open("test.db".to_unsafe as Pointer(Int8), pointerof(db))

callback = Proc(Pointer(Void), Int32, Int8**, Pointer(Pointer(Int8)), Int32).new { |not_used, argc, argv, dontrememberwhat| 0 }

# /* Open database */
if( rc != 0 )
  puts "Can't open database: %s\n" + String.new(LibSqlite3.sqlite3_errmsg(db) as Pointer(UInt8))
else
  puts "Opened database successfully\n"
end

# /* Create SQL statement */
sql = "CREATE TABLE COMPANY("  \
      "ID INT PRIMARY KEY     NOT NULL," \
      "NAME           TEXT    NOT NULL," \
      "AGE            INT     NOT NULL," \
      "ADDRESS        CHAR(50)," \
      "SALARY         REAL );";

# /* Execute SQL statement */
rc = LibSqlite3.sqlite3_exec(db, sql.to_unsafe as Pointer(Int8), callback, nil, nil);
if( rc != 0 )
  puts "SQL error: " + String.new(LibSqlite3.sqlite3_errmsg(db) as UInt8*)
else
  puts "Table created successfully\n"
end
LibSqlite3.sqlite3_close(db);
