
SELECT 'aes_encrypt_mysql';
SELECT aes_encrypt_mysql('aes-256-ecb', CAST(null as Nullable(String)), 'test_key________________________');
WITH 'aes-256-ecb' as mode, 'Hello World!' as plaintext, 'test_key________________________' as key
SELECT hex(aes_encrypt_mysql(mode, toNullable(plaintext), key));
SELECT 'aes_decrypt_mysql';
SELECT aes_decrypt_mysql('aes-256-ecb', CAST(null as Nullable(String)), 'test_key________________________');
SELECT 'encrypt';
WITH 'aes-256-ecb' as mode, 'test_key________________________' as key
SELECT mode, encrypt(mode, CAST(null as Nullable(String)), key);
SELECT 'decrypt';
WITH 'aes-256-ecb' as mode, 'test_key________________________' as key
SELECT mode, decrypt(mode, CAST(null as Nullable(String)), key);
