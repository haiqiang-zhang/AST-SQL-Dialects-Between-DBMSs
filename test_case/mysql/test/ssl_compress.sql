

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

connect (ssl_compress_con,localhost,root,,,,,SSL COMPRESS);

-- Check ssl turned on
--replace_regex $ALLOWED_CIPHERS_REGEX
SHOW STATUS LIKE 'Ssl_cipher';

-- Check compression turned on
SHOW STATUS LIKE 'Compression';

-- Source select test case
-- source include/common-tests.inc

-- Check ssl turned on
--replace_regex $ALLOWED_CIPHERS_REGEX
SHOW STATUS LIKE 'Ssl_cipher';

-- Check compression turned on
SHOW STATUS LIKE 'Compression';
