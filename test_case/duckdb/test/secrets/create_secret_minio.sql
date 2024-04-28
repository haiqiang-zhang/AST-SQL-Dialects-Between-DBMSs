PRAGMA enable_verification;;
set secret_directory='__TEST_DIR__/create_secret_minio';
set s3_access_key_id='';;
set s3_secret_access_key='';;
copy select 1 as a to 's3://test- /test-file.parquet';
CREATE PERSISTENT SECRET (
    TYPE S3,
    PROVIDER config,
    SCOPE 's3://test-bucket/only-this-file-gets-auth.parquet',
    KEY_ID '${AWS_ACCESS_KEY_ID}',
    SECRET '${AWS_SECRET_ACCESS_KEY}',
    REGION '${AWS_DEFAULT_REGION}',
    ENDPOINT '${DUCKDB_S3_ENDPOINT}',
    USE_SSL '${DUCKDB_S3_USE_SSL}'
);
copy (select 1 as a) to 's3://test-bucket/test-file.parquet';
copy (select 1 as a) to 's3://test-bucket/only-this-file-gets-auth.parquet';
set secret_directory='__TEST_DIR__/create_secret_minio';
copy (select 1 as a) to 's3://test-bucket/only-this-file-gets-auth.parquet';
copy (select 1 as a) to 's3://test-bucket/no-auth-here.parquet';
