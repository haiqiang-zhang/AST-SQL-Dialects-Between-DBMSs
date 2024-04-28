PRAGMA enable_verification;
ATTACH '__TEST_DIR__/first.db' (TYPE DUCKDB);;
ATTACH '__TEST_DIR__/error.db' (TYPE DUCKDB, HELLO, OPTION 2);;
ATTACH '__TEST_DIR__/error.db' (HELLO, OPTION 2);;
SELECT database_name FROM duckdb_databases() ORDER BY 1;;
