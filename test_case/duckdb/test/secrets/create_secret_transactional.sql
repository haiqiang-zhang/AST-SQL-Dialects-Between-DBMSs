PRAGMA enable_verification;;
set secret_directory='__TEST_DIR__/create_secret_transactional';
PRAGMA threads=1;
BEGIN TRANSACTION;
CREATE ${secret_type} SECRET s1 (TYPE S3);
BEGIN TRANSACTION;
CREATE ${secret_type} SECRET s2 (TYPE S3);
COMMIT;
COMMIT;
BEGIN TRANSACTION;
DROP SECRET s1;;
COMMIT;
DROP SECRET s2;
CREATE PERSISTENT SECRET perm_s1 (TYPE S3);
set secret_directory='__TEST_DIR__/create_secret_transactional';
BEGIN TRANSACTION;
CREATE SECRET tmp_s1 (TYPE S3);
BEGIN TRANSACTION;
CREATE SECRET tmp_s2 (TYPE S3);
DROP SECRET perm_s1;;
COMMIT;
COMMIT;
SELECT name FROM duckdb_secrets();;
SELECT name FROM duckdb_secrets();;
SELECT name FROM duckdb_secrets();;
SELECT name FROM duckdb_secrets();;
SELECT name FROM duckdb_secrets() ORDER BY name;;
SELECT name FROM duckdb_secrets() ORDER BY name;;
SELECT name FROM duckdb_secrets();;
SELECT name FROM duckdb_secrets();;
SELECT name FROM duckdb_secrets() ORDER BY name;;
SELECT name FROM duckdb_secrets() ORDER BY name;;
