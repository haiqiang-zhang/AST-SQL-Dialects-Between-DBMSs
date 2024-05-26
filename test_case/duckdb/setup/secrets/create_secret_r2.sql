PRAGMA enable_verification;
set secret_directory='__TEST_DIR__';
CREATE SECRET (
    TYPE R2,
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
