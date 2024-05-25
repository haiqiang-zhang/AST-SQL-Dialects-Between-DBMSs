PRAGMA enable_verification;
SELECT a+1 FROM tbl;;
SELECT table_name, index_count FROM duckdb_tables() ORDER BY table_name;;
SELECT a+2 FROM tbl;;
