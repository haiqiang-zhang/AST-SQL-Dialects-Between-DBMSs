PRAGMA enable_verification;
set secret_directory='__TEST_DIR__/create_secret_persistence';
CREATE SECRET my_tmp_secret (
	TYPE S3,
    SCOPE 's3://bucket1'
);
CREATE TEMPORARY SECRET my_tmp_secret_2 (
	TYPE S3,
    SCOPE 's3://bucket2'
);
CREATE OR REPLACE PERSISTENT SECRET my_tmp_secret_3 (
	TYPE S3,
    SCOPE 's3://bucket3'
);
CREATE SECRET IF NOT EXISTS my_tmp_secret_3 (
    TYPE S3,
    SCOPE 's3://bucket3_not_used'
);
CREATE PERSISTENT SECRET IF NOT EXISTS my_tmp_secret_3 (
    TYPE S3,
    SCOPE 's3://bucket3_not_used'
);
CREATE PERSISTENT SECRET IF NOT EXISTS my_tmp_secret_3 (
    TYPE S3,
    SCOPE 's3://bucket3_not_used'
);
CREATE OR REPLACE PERSISTENT SECRET my_tmp_secret_3 (
	TYPE S3,
    SCOPE 's3://bucket3_updated'
);
CREATE PERSISTENT SECRET IF NOT EXISTS my_tmp_secret_4 (
    TYPE S3,
    SCOPE 's3://another_secret'
);
SELECT name, storage, scope FROM duckdb_secrets() where storage='memory' order by name;
SELECT name, scope FROM duckdb_secrets() where storage != 'memory';
SELECT name, scope FROM duckdb_secrets();
SELECT name, storage, scope FROM duckdb_secrets() where name='my_tmp_secret_3' order by storage;
SELECT name, scope FROM duckdb_secrets();
SELECT name, scope FROM duckdb_secrets();
SELECT name, scope FROM duckdb_secrets();
SELECT name, scope FROM duckdb_secrets();
SELECT name, scope FROM duckdb_secrets() order by name;
SELECT name, scope FROM duckdb_secrets();
SELECT name, storage, scope FROM duckdb_secrets() order by name;
