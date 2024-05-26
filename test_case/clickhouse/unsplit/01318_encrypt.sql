CREATE TABLE encryption_test
(
    input String,
    key String DEFAULT unhex('fb9958e2e897ef3fdb49067b51a24af645b3626eed2f9ea1dc7fd4dd71b7e38f9a68db2a3184f952382c783785f9d77bf923577108a88adaacae5c141b1576b0'),
    iv String DEFAULT unhex('8CA3554377DFF8A369BC50A89780DD85'),
    key32 String DEFAULT substring(key, 1, 32),
    key24 String DEFAULT substring(key, 1, 24),
    key16 String DEFAULT substring(key, 1, 16)
) Engine = Memory;
INSERT INTO encryption_test (input)
VALUES (''), ('text'), ('What Is ClickHouse? ClickHouse is a column-oriented database management system (DBMS) for online analytical processing of queries (OLAP).');
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
