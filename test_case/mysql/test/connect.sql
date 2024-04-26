
-- This test is to check various cases of connections
-- with right and wrong password, with and without database
-- Unfortunately the check is incomplete as we can't connect without database

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc


--disable_warnings
drop table if exists t1,t2;

create user test@localhost identified by "gambling";
create user test@127.0.0.1 identified by "gambling";

-- Now check this user with different databases
--connect (con1,localhost,test,gambling,"");


-- remove user 'test' so that other tests which may use 'test'
-- do not depend on this test.
drop user test@localhost;
drop user test@127.0.0.1;

--
-- Bug#12517 Clear user variables and replication events before
--           closing temp tables in thread cleanup.
connect (con7,localhost,root,,test);
let $connection_id= `select connection_id()`;
create table t1 (id integer not null auto_increment primary key);
create temporary table t2(id integer not null auto_increment primary key);
set @id := 1;
delete from t1 where id like @id;

-- Wait till the session con7 is disconnected
let $wait_condition =
  SELECT COUNT(*) = 0
  FROM information_schema.processlist
  WHERE  id = '$connection_id';
drop table t1;
CREATE USER mysqltest_u1@localhost;

-- NOTE: if the test case fails sporadically due to spurious connections,
-- consider disabling all users.

--echo
let $saved_max_connections = `SELECT @@global.max_connections`;
SET GLOBAL max_connections = 3;

-- Make Sure Event scheduler is ON (by default)
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE user = 'event_scheduler' AND command = 'Daemon';
let $con_name = con_1;
let $con_user_name = mysqltest_u1;
let $con_name = con_2;
let $con_user_name = mysqltest_u1;
let $con_name = con_3;
let $con_user_name = mysqltest_u1;
let $con_name = con_4;
let $con_user_name = mysqltest_u1;
let $wait_timeout = 5;
let $con_name = con_super_1;
let $con_user_name = root;
let $con_name = con_super_2;
let $con_user_name = root;
let $wait_timeout = 5;
SELECT user FROM information_schema.processlist ORDER BY id;
let $wait_condition =
  SELECT COUNT(*) = 1
  FROM information_schema.processlist
  WHERE db = 'test';
DROP USER mysqltest_u1@localhost;

-- NOTE: We should use a new connection here instead of reconnect in order to
-- avoid races (we can not for sure when the connection being disconnected is
-- actually disconnected on the server).

--echo
--echo -- -- Opening a new connection to check max_used_connections...
--connect (con_1,localhost,root)

--echo
--echo -- -- Check that max_used_connections hasn't changed.
SHOW STATUS LIKE 'max_used_connections';

-- Make Sure Event scheduler is ON (by default)
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE user = 'event_scheduler' AND command = 'Daemon';

CREATE USER must_change@localhost IDENTIFIED BY 'aha';
SELECT password_expired FROM mysql.user 
  WHERE user='must_change' and host = 'localhost';
SELECT USER();
CREATE TABLE t1 (A INT);
CREATE PROCEDURE TEST_t1(new_a INT) INSERT INTO t1 VALUES (new_a);
CREATE FUNCTION last_t1() RETURNS INT RETURN (SELECT MAX(A) FROM t1);
UPDATE mysql.user SET password_expired='Y'
  WHERE user='must_change' and host = 'localhost';
SELECT USER();
SELECT last_t1();
SELECT USER();
SELECT last_t1();
SELECT USER();
SELECT last_t1();
ALTER USER must_change@localhost IDENTIFIED BY 'aha2';
SELECT USER();
SELECT last_t1();
SELECT password_expired FROM mysql.user
  WHERE user='must_change' and host = 'localhost';

UPDATE mysql.user SET password_expired='Y'
  WHERE user='must_change' and host = 'localhost';
SELECT USER();
SELECT last_t1();
ALTER USER must_change@localhost IDENTIFIED BY 'aha3';
SELECT USER();
SELECT last_t1();
ALTER USER must_change@localhost IDENTIFIED BY 'aha3';
SELECT USER();
SELECT last_t1();
ALTER USER must_change@localhost PASSWORD EXPIRE;

SELECT password_expired FROM mysql.user
  WHERE user='must_change' and host = 'localhost';
SELECT USER();
ALTER USER must_change@localhost IDENTIFIED BY 'aha4';
ALTER USER
  invalid_user@localhost,
  must_change@localhost PASSWORD EXPIRE;

SELECT password_expired FROM mysql.user
  WHERE user='must_change' and host = 'localhost';
SELECT USER();

ALTER USER must_change@localhost PASSWORD EXPIRE;

SELECT password_expired FROM mysql.user
  WHERE user='must_change' and host = 'localhost';
SELECT USER();
ALTER USER must_change@localhost IDENTIFIED BY 'aha5';
SELECT USER();
SELECT USER();
DROP PROCEDURE test_t1;
DROP FUNCTION last_t1;
DROP TABLE t1;
DROP USER must_change@localhost;

CREATE USER wl6587@localhost IDENTIFIED BY 'wl6587';
ALTER USER wl6587@localhost PASSWORD EXPIRE;

DROP USER wl6587@localhost;

-- Creating a dummy database and an user with no privileges to access that database
--connection default
CREATE DATABASE test1;
CREATE USER 'new1'@'localhost';

-- Cleanup
DROP USER 'new1'@'localhost';
DROP DATABASE test1;
