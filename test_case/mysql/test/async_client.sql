
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--echo --
--echo -- WL#11381: Add asynchronous support into the mysql protocol
--echo --

--echo -- case1: default connection with default authentication plugin
CREATE DATABASE wl11381;
CREATE USER caching_sha2@localhost IDENTIFIED BY 'caching';
SELECT USER(), DATABASE();

USE wl11381;
CREATE TABLE t1(i INT, j VARCHAR(2048));
INSERT INTO t1 VALUES(1,repeat('a',1000)),(2,repeat('def',600));
SELECT * FROM t1;
SET GLOBAL max_allowed_packet=4*1024;
SELECT SPACE(@@global.max_allowed_packet);
SET GLOBAL max_allowed_packet=default;
SELECT USER();
SET @@SESSION.wait_timeout = 2;
SELECT SLEEP(10);
SELECT 1;
ALTER USER caching_sha2@localhost ACCOUNT LOCK;
ALTER USER caching_sha2@localhost ACCOUNT UNLOCK;
SELECT "connect succeeded after account is unlocked";
SELECT USER();

-- default connection on windows is a NAMED_PIPE, on this type of connection
-- async operations are not allowed, so disable it.
--disable_async_client
--echo -- change to empty password
ALTER USER caching_sha2@localhost IDENTIFIED BY '';
SELECT USER();
CREATE USER sha256@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';
SELECT USER();
ALTER USER sha256@localhost IDENTIFIED BY '';
SELECT USER();
CREATE USER native_user@localhost IDENTIFIED WITH 'mysql_native_password' BY 'native';
SELECT USER();
ALTER USER native_user@localhost IDENTIFIED BY '';
SELECT USER();
DROP USER sha256@localhost, native_user@localhost, caching_sha2@localhost;
DROP DATABASE wl11381;
