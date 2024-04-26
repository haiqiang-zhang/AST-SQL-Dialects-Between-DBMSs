SELECT TO_BASE64(AES_ENCRYPT('my_text', 'my_key_string', '', 'hkdf'));
SELECT LENGTH(AES_ENCRYPT('my_text', 'my_key_string', '', 'hkdf'));
SELECT CHARSET(AES_ENCRYPT('my_text', 'my_key_string', '', 'hkdf'));
SELECT AES_ENCRYPT('my_text', 'my_key_string', '', 'hkdf') = AES_ENCRYPT('my_text', 'my_key_string', '', 'hkdf');
SELECT AES_ENCRYPT('my_text', repeat("x",32), '', 'hkdf') = AES_ENCRYPT('my_text', repeat("y",32), '', 'hkdf');
SELECT AES_ENCRYPT('my_text', repeat("x",32), '', 'hkdf') = AES_ENCRYPT('my_text', '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0', '', 'hkdf');
select TO_BASE64(AES_ENCRYPT('my_text','my_key_string', '', 'hkdf'));
select TO_BASE64(AES_ENCRYPT('my_text','my_key_string', '', 'hkdf', 'salt'));
select TO_BASE64(AES_ENCRYPT('my_text','my_key_string', '', 'hkdf', 'salt', 'info'));
SELECT 'my_text' = AES_DECRYPT(AES_ENCRYPT('my_text', 'my_key_string', '', 'hkdf'), 'my_key_string', '', 'hkdf');
SELECT 'my_text' = AES_DECRYPT(AES_ENCRYPT('my_text','my_key_string', '', 'hkdf', 10001), 'my_key_string', '', 'hkdf', 10001);
SELECT 'my_text' = AES_DECRYPT(AES_ENCRYPT('my_text','my_key_string', '', 'hkdf', 10001, 2000), 'my_key_string', '', 'hkdf', 10001, 2000);
select aes_encrypt("foo",repeat("x",16),NULL,'hKdF');
SET @IV=REPEAT('a', 16);
SELECT @@session.block_encryption_mode INTO @save_block_encryption_mode;
SELECT 'my_text' = AES_DECRYPT(AES_ENCRYPT('my_text', 'my_key_string', @IV, 'hkdf'), 'my_key_string', @IV, 'hkdf');
SELECT 'my_text' = AES_DECRYPT(AES_ENCRYPT('my_text', 'my_key_string', @IV, 'hkdf', 'salt'), 'my_key_string', @IV, 'hkdf', 'salt');
SELECT 'my_text' = AES_DECRYPT(AES_ENCRYPT('my_text', 'my_key_string', @IV, 'hkdf', 'salt', 'info'), 'my_key_string', @IV, 'hkdf', 'salt', 'info');
SET SESSION block_encryption_mode=@save_block_encryption_mode;
