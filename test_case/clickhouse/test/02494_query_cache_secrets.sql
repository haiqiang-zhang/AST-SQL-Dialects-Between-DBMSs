-- Tag no-fasttest: Depends on OpenSSL
-- Tag no-parallel: Messes with internal cache

SYSTEM DROP QUERY CACHE;
SELECT hex(encrypt('aes-128-ecb', 'plaintext', 'passwordpassword')) SETTINGS use_query_cache = true;
SELECT query FROM system.query_cache;
SYSTEM DROP QUERY CACHE;
