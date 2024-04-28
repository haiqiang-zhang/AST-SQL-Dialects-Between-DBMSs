PRAGMA enable_verification;;
set secret_directory='__TEST_DIR__/create_secret_settings1';
set allow_persistent_secrets=true;;
CREATE PERSISTENT SECRET my_perm_secret (
	TYPE S3,
    SCOPE 's3://bucket1'
);
set secret_directory='__TEST_DIR__/create_secret_settings2';
set allow_persistent_secrets=false;;
set allow_persistent_secrets=false;
set allow_persistent_secrets=true;
set secret_directory='__TEST_DIR__/create_secret_settings1';
SELECT name, scope from duckdb_secrets();;
select count(*) from duckdb_secrets();;
SELECT name, scope from duckdb_secrets();;
