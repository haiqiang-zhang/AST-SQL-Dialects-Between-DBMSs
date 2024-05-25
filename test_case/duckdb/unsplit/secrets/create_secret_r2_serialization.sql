PRAGMA enable_verification;
set secret_directory='__TEST_DIR__/create_secret_r2_serialization';
CREATE OR REPLACE PERSISTENT SECRET s1 (
    TYPE S3,
    PROVIDER config,
    SCOPE 's3://my_scope',
    KEY_ID 'mekey',
    SECRET 'mesecret',
    REGION 'meregion',
    SESSION_TOKEN 'mesesh',
    ENDPOINT 'meendpoint',
    URL_STYLE 'mahstyle',
    USE_SSL true,
    URL_COMPATIBILITY_MODE true
);
select name, type, provider, scope FROM duckdb_secrets();
select * from duckdb_secrets();
select count(*) FROM duckdb_secrets();
select name, type, provider, scope FROM duckdb_secrets();
select * from duckdb_secrets();
