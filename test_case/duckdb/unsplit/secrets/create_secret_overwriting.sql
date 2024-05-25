PRAGMA enable_verification;;
set allow_persistent_secrets=false;;
CREATE SECRET my_secret (
	TYPE S3,
    SCOPE 's3://bucket1'
);
CREATE SECRET my_secret (
	TYPE S3,
    KEY_ID 'my_key',
    SECRET 'my_secret',
    SCOPE 's3://bucket1'
);
CREATE OR REPLACE SECRET my_secret (
	TYPE S3,
    SCOPE 's3://bucket2'
);
CREATE SECRET IF NOT EXISTS my_secret (
	TYPE S3,
    SCOPE 's3://bucket5'
);
DROP SECRET my_secret_does_not_exist;;
DROP SECRET my_secret;;
SELECT name, scope FROM duckdb_secrets();;
SELECT name, scope FROM duckdb_secrets();;
SELECT name, scope FROM duckdb_secrets();;
SELECT name, scope FROM duckdb_secrets();;
