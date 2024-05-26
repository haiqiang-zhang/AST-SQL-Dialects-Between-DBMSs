PRAGMA enable_verification;
set allow_persistent_secrets=false;
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
