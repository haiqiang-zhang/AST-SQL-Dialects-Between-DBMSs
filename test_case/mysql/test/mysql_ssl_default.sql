
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--source include/allowed_ciphers.inc

--echo --
--echo -- WL#7712 Support SSL by default in libmysql
--echo --


--echo -- verify that mysql default connect with ssl channel when using TCP/IP
--echo -- connection
--replace_regex $ALLOWED_CIPHERS_REGEX
--exec $MYSQL --host=127.0.0.1 -P $MASTER_MYPORT -e "SHOW STATUS like 'Ssl_cipher'"

--echo -- verify that mysql --ssl=0 connect with unencrypted channel
--replace_regex $ALLOWED_CIPHERS_REGEX
--exec $MYSQL --host=127.0.0.1 -P $MASTER_MYPORT -e "SHOW STATUS like 'Ssl_cipher'" --ssl-mode=DISABLED

--echo -- verify that mysql --ssl=1 connect with ssl channel
--replace_regex $ALLOWED_CIPHERS_REGEX
--exec $MYSQL --host=127.0.0.1 -P $MASTER_MYPORT -e "SHOW STATUS like 'Ssl_cipher'" --ssl-mode=REQUIRED

CREATE USER u1@localhost IDENTIFIED BY 'secret' REQUIRE SSL;

DROP USER u1@localhost;
