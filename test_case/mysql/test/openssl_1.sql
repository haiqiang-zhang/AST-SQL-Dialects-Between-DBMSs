
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

set @orig_sql_mode= @@sql_mode;
drop table if exists t1;
create table t1(f1 int);
insert into t1 values (5);
let $cipher= query_get_value("SHOW STATUS like 'Ssl_cipher'", Value, 1);
let $cipher_val= "$cipher";

create user ssl_user1@localhost, ssl_user2@localhost,
            ssl_user3@localhost, ssl_user4@localhost,
            ssl_user5@localhost;
                          ssl_user3@localhost, ssl_user4@localhost,
                          ssl_user5@localhost;
select * from t1;
delete from t1;
select * from t1;
delete from t1;
select * from t1;
delete from t1;
select * from t1;
delete from t1;
drop user ssl_user1@localhost, ssl_user2@localhost,
ssl_user3@localhost, ssl_user4@localhost, ssl_user5@localhost;

drop table t1;

-- End of 4.1 tests

--
-- Test that we can't open connection to server if we are using
-- a different cacert
--
--exec echo "this query should not execute;

--
-- Test that we can't open connection to server if we are using
-- a blank ca
--
--replace_regex /2026 SSL connection error.*\n/2026 SSL connection error: xxxx/
--error 1
--exec $MYSQL_TEST --ssl-mode=VERIFY_CA --ssl-ca= --max-connect-retries=1 < $MYSQLTEST_VARDIR/tmp/test.sql 2>&1
--echo

--
-- Test that we can't open connection to server if we are using
-- a nonexistent ca file
--
--replace_regex /2026 SSL connection error.*\n/2026 SSL connection error: xxxx/
--error 1
--exec $MYSQL_TEST --ssl-mode=VERIFY_CA --ssl-ca=nonexisting_file.pem --max-connect-retries=1 < $MYSQLTEST_VARDIR/tmp/test.sql 2>&1
--echo

--
-- Test that we can't open connection to server if we are using
-- a blank client-key
--
--error 1
--exec $MYSQL_TEST --ssl-mode=REQUIRED --ssl-key= --max-connect-retries=1 < $MYSQLTEST_VARDIR/tmp/test.sql 2>&1

--
-- Test that we can't open connection to server if we are using
-- a blank client-cert
--
--error 1
--exec $MYSQL_TEST --ssl-mode=REQUIRED --ssl-cert= --max-connect-retries=1 < $MYSQLTEST_VARDIR/tmp/test.sql 2>&1

--
-- Bug#21611 Slave can't connect when master-ssl-cipher specified
-- - Apparently selecting a cipher doesn't work at all
-- - Usa a cipher that OpenSSL supports
--
--exec echo "SHOW STATUS LIKE 'Ssl_cipher';

--
-- Bug#25309 SSL connections without CA certificate broken since MySQL 5.0.23
--
-- Test that we can open encrypted connection to server without
-- verification of servers certificate by setting both ca certificate
-- and ca path to NULL
--
--replace_regex $ALLOWED_CIPHERS_REGEX
--exec $MYSQL --ssl-mode=REQUIRED --ssl-key=$MYSQL_TEST_DIR/std_data/client-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem -e "SHOW STATUS LIKE 'ssl_Cipher'" 2>&1
--echo End of 5.0 tests

--
-- Bug#26174 Server Crash: INSERT ... SELECT ... FROM I_S.GLOBAL_STATUS in
-- Event (see also information_schema.test for the other part of test for
-- this bug).
--
--disable_warnings
DROP TABLE IF EXISTS thread_status;
DROP EVENT IF EXISTS event_status;

-- Make Sure Event scheduler is ON (by default)
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE user = 'event_scheduler' AND command = 'Daemon';

CREATE EVENT event_status
 ON SCHEDULE AT NOW()
 ON COMPLETION NOT PRESERVE
 DO
BEGIN
  CREATE TABLE thread_status
  SELECT variable_name, variable_value
  FROM performance_schema.session_status
  WHERE variable_name LIKE 'SSL_ACCEPTS' OR
  variable_name LIKE 'SSL_CALLBACK_CACHE_HITS';

let $wait_condition=select count(*) = 0 from information_schema.events where event_name='event_status';

-- The actual value doesn't matter and can vary based on test ordering and on ssl library.
--replace_column 2 --
SELECT variable_name, variable_value FROM thread_status;

DROP TABLE thread_status;

--
-- Test to connect using a list of ciphers
--
--exec echo "SHOW STATUS LIKE 'Ssl_cipher';

-- Test to connect using a specifi cipher
--
--exec echo "SHOW STATUS LIKE 'Ssl_cipher';

-- Test to connect using an unknown cipher
--
--exec echo "SHOW STATUS LIKE 'Ssl_cipher';

--
-- Bug#27669 mysqldump: SSL connection error when trying to connect
--

CREATE TABLE t1(a int);
INSERT INTO t1 VALUES (1), (2);

-- Run mysqldump
--exec $MYSQL_DUMP --skip-comments --ssl-key=$MYSQL_TEST_DIR/std_data/client-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem test t1

--exec $MYSQL_DUMP --skip-comments --ssl-ca=$MYSQL_TEST_DIR/std_data/cacert.pem --ssl-key=$MYSQL_TEST_DIR/std_data/client-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem test

--exec $MYSQL_DUMP --skip-comments --ssl-mode=VERIFY_CA --ssl-ca=$MYSQL_TEST_DIR/std_data/cacert.pem --ssl-key=$MYSQL_TEST_DIR/std_data/client-key.pem --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem test

-- With wrong parameters
--replace_result $MYSQL_TEST_DIR MYSQL_TEST_DIR
--error 2
--exec $MYSQL_DUMP --skip-create-options --skip-comments --ssl-mode=REQUIRED --ssl-cert=$MYSQL_TEST_DIR/std_data/client-cert.pem test 2>&1

DROP TABLE t1;

--
-- Bug#39172 Asking for DH+non-RSA key with server set to use other key caused
--           YaSSL to crash the server.
--

-- Common ciphers to openssl and yassl
--exec $MYSQL --host=localhost -e "SHOW STATUS LIKE 'Ssl_cipher';

-- Below here caused crashes.  ################
--error 1
--exec $MYSQL --host=localhost -e "SHOW STATUS LIKE 'Ssl-cipher';

-- If this gives a result, then the bug is fixed.
--enable_result_log
--enable_query_log
select 'is still running;

--
-- Bug#42158: leak: SSL_get_peer_certificate() doesn't have matching X509_free()
--

CREATE USER bug42158@localhost REQUIRE X509;
DROP USER bug42158@localhost;

set sql_mode= @orig_sql_mode;
