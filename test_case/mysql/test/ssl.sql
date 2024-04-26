
-- Turn on ssl between the client and server
-- and run a number of tests


-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

connect (ssl_con,localhost,root,,,,,SSL);

-- Check ssl turned on
--replace_regex $ALLOWED_CIPHERS_REGEX
SHOW STATUS LIKE 'Ssl_cipher';

-- Check ssl expiration
SHOW STATUS LIKE 'Ssl_server_not_before';

-- Source select test case
-- source include/common-tests.inc

-- Check ssl turned on
--replace_regex $ALLOWED_CIPHERS_REGEX
SHOW STATUS LIKE 'Ssl_cipher';

LET $ID= `SELECT connection_id()`;
SET @@SESSION.wait_timeout = 2;
let $wait_condition=
  SELECT COUNT(*) = 0 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE ID = $ID;
SELECT 1;
