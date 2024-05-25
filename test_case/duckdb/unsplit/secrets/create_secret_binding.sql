PRAGMA enable_verification;;
set allow_persistent_secrets=false;;
CREATE SECRET s1 (
    TYPE R2,
    PROVIDER config,
    SCOPE ('s3://my_r2_scope', 's3://my_r2_scope2'),
    ACCOUNT_ID some_bogus_account,
    KEY_ID '123',
    USE_SSL 1,
    URL_COMPATIBILITY_MODE false
);
DROP SECRET s1;
CREATE SECRET s1 (
    TYPE R2,
    PROVIDER config,
    SCOPE ('s3://my_r2_scope', 's3://my_r2_scope2'),
    account_id 'some_bogus_account',
    key_id 123,
    USE_SSL 'true',
    URL_COMPATIBILITY_MODE '0'
);
CREATE SECRET incorrect_type (
    TYPE R2,
    PROVIDER config,
    USE_SSL 'fliepflap'
);
CREATE SECRET incorrect_type (
    TYPE R2,
    PROVIDER config,
    FLIEPFLAP true
);
CREATE SECRET incorrect_type (
    TYPE S3,
    PROVIDER config,
    ACCOUNT_ID 'my_acount'
);
CREATE SECRET duplicate_param (
    TYPE R2,
        PROVIDER config,
        account_id 'some_bogus_account',
        key_id 123,
        KEY_ID 12098,
        account_id blablabla
);
FROM duckdb_secrets();;
FROM duckdb_secrets();;
