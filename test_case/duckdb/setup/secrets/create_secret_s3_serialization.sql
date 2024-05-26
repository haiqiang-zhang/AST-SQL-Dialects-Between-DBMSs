PRAGMA enable_verification;
set secret_directory='__TEST_DIR__/create_secret_s3_serialization';
CREATE OR REPLACE PERSISTENT SECRET s1 (
    TYPE S3,
    PROVIDER config,
    SCOPE 's3://my_s3_scope',
    KEY_ID 'mekey',
    SECRET 'mesecret',
    REGION 'meregion',
    SESSION_TOKEN 'mesesh',
    ENDPOINT 'meendpoint',
    URL_STYLE 'mahstyle',
    USE_SSL true,
    URL_COMPATIBILITY_MODE true
);
CREATE OR REPLACE PERSISTENT SECRET s2 (
    TYPE R2,
    PROVIDER config,
    SCOPE 's3://my_r2_scope',
    ACCOUNT_ID 'some_bogus_account',
    KEY_ID 'mekey',
    SECRET 'mesecret',
    SESSION_TOKEN 'mesesh',
    URL_STYLE 'mahstyle',
    USE_SSL 1,
    URL_COMPATIBILITY_MODE 1
);
CREATE OR REPLACE PERSISTENT SECRET s3 (
    TYPE GCS,
    PROVIDER config,
    SCOPE 's3://my_gcs_scope',
    KEY_ID 'mekey',
    SECRET 'mesecret',
    SESSION_TOKEN 'mesesh',
    URL_STYLE 'mahstyle',
    USE_SSL true,
    URL_COMPATIBILITY_MODE true
);
