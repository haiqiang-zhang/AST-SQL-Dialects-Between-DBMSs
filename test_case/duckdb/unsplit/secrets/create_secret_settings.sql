PRAGMA enable_verification;
set secret_directory='__TEST_DIR__/create_secret_settings1';
set allow_persistent_secrets=true;
SELECT name, scope from duckdb_secrets();
select count(*) from duckdb_secrets();
SELECT name, scope from duckdb_secrets();
