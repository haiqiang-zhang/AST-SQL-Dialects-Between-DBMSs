PRAGMA enable_verification;
set secret_directory='__TEST_DIR__/create_secret_persistence_error_handling';
COPY (select 1 as a ) to '__TEST_DIR__/create_secret_persistence_error_handling/s1.duckdb_secret' (FORMAT csv);