PRAGMA enable_verification;;
set allow_persistent_secrets=false;;
DROP SECRET IF EXISTS s1;;
CREATE SECRET (
    TYPE S3,
    KEY_ID 'my_key',
    SECRET 'my_secret'
);
CREATE SECRET (
    TYPE R2,
    KEY_ID 'my_key',
    SECRET 'my_secret',
    ACCOUNT_ID 'my_account_id'
);
CREATE SECRET (
    TYPE GCS,
    KEY_ID 'my_key',
    SECRET 'my_secret'
);
SELECT name, provider, type, scope FROM duckdb_secrets();;
SELECT name, provider, type, scope FROM duckdb_secrets() ORDER BY name;;
SELECT name, persistent, storage, provider, type, scope FROM duckdb_secrets() ORDER BY name;;
