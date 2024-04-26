
-- Turn on ssl between the client and server
-- and run a number of tests

--echo --
--echo -- BUG#11760210 - SSL_CIPHER_LIST NOT SET OR RETURNED FOR "SHOW STATUS LIKE 'SSL_CIPHER_LIST'"
--echo --


-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--echo -- must return ECDHE-RSA-AES128-GCM-SHA256
-- need to use mysql since mysqltest doesn't support --ssl-cipher
--exec $MYSQL --host=localhost -e "SHOW STATUS LIKE 'Ssl_cipher';
