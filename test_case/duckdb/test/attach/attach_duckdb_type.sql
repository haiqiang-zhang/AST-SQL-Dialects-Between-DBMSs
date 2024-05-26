ATTACH '__TEST_DIR__/first.db' (TYPE DUCKDB);
SELECT database_name FROM duckdb_databases() ORDER BY 1;
