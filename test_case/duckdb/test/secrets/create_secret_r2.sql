PRAGMA enable_verification;;
set secret_directory='__TEST_DIR__';
CREATE SECRET (
    TYPE R2,
    ACCOUNT_ID 'some_bogus_account',
    KEY_ID 'my_key',
    SECRET 'my_secret'
);
FROM 's3://test-bucket/test.csv'
error for HTTP HEAD to 'https://some_bogus_account.r2.cloudflarestorage.com/test-bucket/test.csv';
CREATE SECRET (
    TYPE S3,
    ACCOUNT_ID 'some_bogus_account',
    KEY_ID 'my_key',
    SECRET 'my_secret'
);
CREATE SECRET (
    TYPE GCS,
    PROVIDER config,
    ACCOUNT_ID 'some_bogus_account',
    KEY_ID 'my_key',
    SECRET 'my_secret'
);
CREATE SECRET test(
    TYPE R2,
    ACCOUNT_ID 'some_bogus_account',
    KEY_ID 'my_key',
    SECRET 'my_secret'
);
SELECT name, type, provider, scope FROM duckdb_secrets();;
