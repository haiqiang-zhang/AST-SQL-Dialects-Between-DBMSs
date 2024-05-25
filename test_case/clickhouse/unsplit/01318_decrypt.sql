SELECT ignore(decrypt('aes-128-ofb', 'hello there', '1111111111111111'));
SELECT ignore(decrypt('aes-128-ctr', 'hello there', '1111111111111111'));
SELECT decrypt('aes-128-ctr', '', '1111111111111111') == '';

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
SELECT 'aes-128-cbc' as mode, aes_decrypt_mysql(mode, aes_encrypt_mysql(mode, input, key, iv), key, iv) == input FROM encryption_test;
SELECT 'aes-192-cbc' as mode, aes_decrypt_mysql(mode, aes_encrypt_mysql(mode, input, key, iv), key, iv) == input FROM encryption_test;
SELECT 'aes-256-cbc' as mode, aes_decrypt_mysql(mode, aes_encrypt_mysql(mode, input, key, iv), key, iv) == input FROM encryption_test;
SELECT 'aes-128-ecb' as mode, aes_decrypt_mysql(mode, aes_encrypt_mysql(mode, input, key, iv), key, iv) == input FROM encryption_test;
SELECT 'aes-192-ecb' as mode, aes_decrypt_mysql(mode, aes_encrypt_mysql(mode, input, key, iv), key, iv) == input FROM encryption_test;
SELECT 'aes-256-ecb' as mode, aes_decrypt_mysql(mode, aes_encrypt_mysql(mode, input, key, iv), key, iv) == input FROM encryption_test;
SELECT 'aes-128-ofb' as mode, aes_decrypt_mysql(mode, aes_encrypt_mysql(mode, input, key, iv), key, iv) == input FROM encryption_test;
SELECT 'aes-192-ofb' as mode, aes_decrypt_mysql(mode, aes_encrypt_mysql(mode, input, key, iv), key, iv) == input FROM encryption_test;
SELECT 'aes-256-ofb' as mode, aes_decrypt_mysql(mode, aes_encrypt_mysql(mode, input, key, iv), key, iv) == input FROM encryption_test;
SELECT 'Strict mode without key folding and proper key and iv lengths checks.';
SELECT 'aes-128-cbc' as mode, decrypt(mode, encrypt(mode, input, key16, iv), key16, iv) == input FROM encryption_test;
SELECT 'aes-192-cbc' as mode, decrypt(mode, encrypt(mode, input, key24, iv), key24, iv) == input FROM encryption_test;
SELECT 'aes-256-cbc' as mode, decrypt(mode, encrypt(mode, input, key32, iv), key32, iv) == input FROM encryption_test;
SELECT 'aes-128-ctr' as mode, decrypt(mode, encrypt(mode, input, key16, iv), key16, iv) == input FROM encryption_test;
SELECT 'aes-192-ctr' as mode, decrypt(mode, encrypt(mode, input, key24, iv), key24, iv) == input FROM encryption_test;
SELECT 'aes-256-ctr' as mode, decrypt(mode, encrypt(mode, input, key32, iv), key32, iv) == input FROM encryption_test;
SELECT 'aes-128-ecb' as mode, decrypt(mode, encrypt(mode, input, key16), key16) == input FROM encryption_test;
SELECT 'aes-192-ecb' as mode, decrypt(mode, encrypt(mode, input, key24), key24) == input FROM encryption_test;
SELECT 'aes-256-ecb' as mode, decrypt(mode, encrypt(mode, input, key32), key32) == input FROM encryption_test;
SELECT 'aes-128-ofb' as mode, decrypt(mode, encrypt(mode, input, key16, iv), key16, iv) == input FROM encryption_test;
SELECT 'aes-192-ofb' as mode, decrypt(mode, encrypt(mode, input, key24, iv), key24, iv) == input FROM encryption_test;
SELECT 'aes-256-ofb' as mode, decrypt(mode, encrypt(mode, input, key32, iv), key32, iv) == input FROM encryption_test;
SELECT 'GCM mode with IV';
SELECT 'aes-128-gcm' as mode, decrypt(mode, encrypt(mode, input, key16, iv), key16, iv) == input FROM encryption_test;
SELECT 'aes-192-gcm' as mode, decrypt(mode, encrypt(mode, input, key24, iv), key24, iv) == input FROM encryption_test;
SELECT 'aes-256-gcm' as mode, decrypt(mode, encrypt(mode, input, key32, iv), key32, iv) == input FROM encryption_test;
SELECT 'GCM mode with IV and AAD';
SELECT 'aes-128-gcm' as mode, decrypt(mode, encrypt(mode, input, key16, iv, 'AAD'), key16, iv, 'AAD') == input FROM encryption_test;
SELECT 'aes-192-gcm' as mode, decrypt(mode, encrypt(mode, input, key24, iv, 'AAD'), key24, iv, 'AAD') == input FROM encryption_test;
SELECT 'aes-256-gcm' as mode, decrypt(mode, encrypt(mode, input, key32, iv, 'AAD'), key32, iv, 'AAD') == input FROM encryption_test;
WITH
    unhex('eebc1f57487f51921c0465665f8ae6d1658bb26de6f8a069a3520293a572078f') as key,
    unhex('67ba0510262ae487d737ee6298f77e0c') as tag,
    unhex('99aa3e68ed8173a0eed06684') as iv,
    unhex('f56e87055bc32d0eeb31b2eacc2bf2a5') as plaintext,
    unhex('4d23c3cec334b49bdb370c437fec78de') as aad,
    unhex('f7264413a84c0e7cd536867eb9f21736') as ciphertext
SELECT
    hex(decrypt('aes-256-gcm', concat(ciphertext, tag), key, iv, aad)) as plaintext_actual,
    plaintext_actual = hex(plaintext);
CREATE TABLE decrypt_null (
  dt DateTime,
  user_id UInt32,
  encrypted String,
  iv String
) ENGINE = Memory;
INSERT INTO decrypt_null VALUES ('2022-08-02 00:00:00', 1, encrypt('aes-256-gcm', 'value1', 'keykeykeykeykeykeykeykeykeykey01', 'iv1'), 'iv1'), ('2022-09-02 00:00:00', 2, encrypt('aes-256-gcm', 'value2', 'keykeykeykeykeykeykeykeykeykey02', 'iv2'), 'iv2'), ('2022-09-02 00:00:01', 3, encrypt('aes-256-gcm', 'value3', 'keykeykeykeykeykeykeykeykeykey03', 'iv3'), 'iv3');
SELECT dt, user_id FROM decrypt_null WHERE (user_id > 0) AND (tryDecrypt('aes-256-gcm', encrypted, 'keykeykeykeykeykeykeykeykeykey02', iv) = 'value2');
SELECT dt, user_id, (tryDecrypt('aes-256-gcm', encrypted, 'keykeykeykeykeykeykeykeykeykey02', iv)) as value FROM decrypt_null ORDER BY user_id;
DROP TABLE encryption_test;
