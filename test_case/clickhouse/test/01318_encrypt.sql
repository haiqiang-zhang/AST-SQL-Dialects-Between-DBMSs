SELECT 'MySQL-compatitable mode, with key folding, no length checks, etc.';
SELECT 'aes-128-cbc' as mode, hex(aes_encrypt_mysql(mode, input, key32, iv)) FROM encryption_test;
SELECT 'Strict mode without key folding and proper key and iv lengths checks.';
SELECT 'GCM mode with IV';
SELECT 'GCM mode with IV and AAD';
SELECT 'Nullable and LowCardinality';
WITH CAST(NULL as Nullable(String)) as input, 'aes-256-ofb' as mode SELECT toTypeName(input), hex(aes_encrypt_mysql(mode, input, key32,iv)) FROM encryption_test LIMIT 1;
WITH
    unhex('eebc1f57487f51921c0465665f8ae6d1658bb26de6f8a069a3520293a572078f') as key,
    unhex('67ba0510262ae487d737ee6298f77e0c') as tag,
    unhex('99aa3e68ed8173a0eed06684') as iv,
    unhex('f56e87055bc32d0eeb31b2eacc2bf2a5') as plaintext,
    unhex('4d23c3cec334b49bdb370c437fec78de') as aad,
    unhex('f7264413a84c0e7cd536867eb9f21736') as ciphertext
SELECT
    hex(encrypt('aes-256-gcm', plaintext, key, iv, aad)) as ciphertext_actual,
    ciphertext_actual = concat(hex(ciphertext), hex(tag));
DROP TABLE encryption_test;
