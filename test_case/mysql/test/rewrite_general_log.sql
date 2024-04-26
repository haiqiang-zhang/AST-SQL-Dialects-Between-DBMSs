--

-- make sure we start with a clean slate. log_tables.test says this is OK.
TRUNCATE TABLE mysql.general_log;

LET old_log_output=          `select @@global.log_output`;
LET old_general_log=         `select @@global.general_log`;
LET old_general_log_file=    `select @@global.general_log_file`;
SET GLOBAL log_output =       'FILE,TABLE';
SET GLOBAL general_log=       'ON';

-- SET NAMES / SET CHARSET
-- keep these in lower case so we can tell them from the upper case rewrites!
set character set 'hebrew';
set charset default,@dummy='A';
set names 'latin1',@dummy='B';
set names 'latin1' collate 'latin1_german2_ci';
set names default,@dummy='c';

-- 1.1.1.1

CREATE TABLE     t1(f1 INT, f2 INT, f3 INT, f4 INT);
CREATE PROCEDURE proc_rewrite_1() INSERT INTO test.t1 VALUES ("hocus pocus");
CREATE FUNCTION  func_rewrite_1(i INT) RETURNS INT DETERMINISTIC RETURN i+1;

CREATE USER test_user1 IDENTIFIED WITH mysql_native_password BY 'azundris1';
      test.t1 TO test_user1;

CREATE USER test_user3@localhost IDENTIFIED WITH mysql_native_password BY 'meow' REQUIRE SSL;
ALTER USER test_user3@localhost IDENTIFIED BY 'meow'
      REQUIRE X509 WITH
      MAX_QUERIES_PER_HOUR 1 MAX_UPDATES_PER_HOUR 2
      MAX_CONNECTIONS_PER_HOUR 3 MAX_USER_CONNECTIONS 4;
ALTER USER test_user3@localhost REQUIRE NONE;


DROP PROCEDURE proc_rewrite_1;
DROP FUNCTION  func_rewrite_1;
DROP TABLE     t1;

-- 1.1.1.2
CREATE USER test_user2 IDENTIFIED WITH mysql_native_password BY 'azundris2';

-- 1.1.1.3
--disable_warnings
CHANGE REPLICATION SOURCE TO SOURCE_PASSWORD='azundris3';

-- 1.1.1.4
CREATE USER 'test_user4'@'localhost' IDENTIFIED WITH mysql_native_password;
ALTER USER 'test_user4'@'localhost' IDENTIFIED BY 'azundris4';
CREATE USER test_user5 IDENTIFIED WITH mysql_native_password AS
'*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF', test_user6 IDENTIFIED BY 'test';
ALTER USER IF EXISTS test_user5 IDENTIFIED BY 'test',
 test_user6 IDENTIFIED WITH mysql_native_password AS
 '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF', test_user7 IDENTIFIED BY 'test';
CREATE USER IF NOT EXISTS test_user6 IDENTIFIED BY 'test',
 test_user7 IDENTIFIED BY 'test';
ALTER USER test_user7 IDENTIFIED WITH mysql_native_password AS
 '*67092806AE91BFB6BE72DE6C7BE2B7CCA8CFA9DF';
CREATE USER test_user8 IDENTIFIED BY '';
ALTER USER test_user8 IDENTIFIED BY '';
CREATE USER test_user9 IDENTIFIED WITH 'caching_sha2_password' BY '';
ALTER  USER test_user9 IDENTIFIED WITH 'caching_sha2_password' BY '';
SET PASSWORD FOR test_user9 = "";
CREATE USER u1, u2;
SET PASSWORD = '' REPLACE '';
ALTER USER u1 IDENTIFIED BY '123' REPLACE '', u2 IDENTIFIED BY '456'
              PASSWORD REQUIRE CURRENT OPTIONAL;
ALTER USER u2 IDENTIFIED BY 'xyz', u1 IDENTIFIED BY 'abc' REPLACE '123';

-- clean-up
SET GLOBAL general_log=       'OFF';
DROP USER u1, u2;
DROP USER 'test_user4'@'localhost';
DROP USER 'test_user3'@'localhost';
DROP USER test_user9, test_user8;
DROP USER test_user7, test_user6,  test_user5;
DROP USER test_user2;
DROP USER test_user1;

-- show general-logging to file is correct
CREATE TABLE test_log (argument TEXT);
     INTO TABLE test_log FIELDS TERMINATED BY '\n' LINES TERMINATED BY '\n';

-- all passwords ('azundris%') must have been obfuscated -> empty result set
--echo This line should be followed by two SELECTs with empty result sets
--replace_regex /.*Query	*//i
SELECT argument FROM test_log WHERE argument LIKE CONCAT('%azun','dris%');

-- same for logging to table
SELECT argument FROM mysql.general_log WHERE argument LIKE CONCAT('%azun','dris%');
SELECT TRIM(LEADING '\t' FROM MID(argument,LOCATE('Query',argument)+5)) FROM
                test_log WHERE (argument LIKE '%BY %' OR argument LIKE '%AS %'
                OR argument LIKE '%PASSWORD %')
                AND argument NOT LIKE '%Prepare%';
SELECT argument FROM mysql.general_log WHERE (argument LIKE '%BY %' OR
                    argument LIKE '%AS %' OR argument LIKE '%PASSWORD %')
                    AND command_type NOT LIKE 'Prepare';
SELECT argument FROM mysql.general_log WHERE argument LIKE CONCAT('set ','character set %');
SELECT argument FROM mysql.general_log WHERE argument LIKE CONCAT('set ','names %');
SELECT argument FROM mysql.general_log WHERE argument LIKE 'GRANT %' AND command_type NOT LIKE 'Prepare';

-- Sanity check -- prove we log the correct hash. Must return one row. In case of ps-protocol mode the query returns 2 rows
SELECT COUNT(*)=1 OR COUNT(*)=2 FROM mysql.general_log WHERE argument LIKE 'CREATE USER%' AND argument LIKE CONCAT('%AS %');
SET GLOBAL general_log='ON';
SET @sql='SELECT command_type, argument FROM mysql.general_log WHERE argument LIKE "%Bug--16953758%"';
SET @sql='DROP TABLE 18616826_does_not_exist';
SELECT command_type, argument FROM mysql.general_log WHERE argument LIKE "DROP TABLE 18616826_does_not_exist";

-- Tests related to WL#11544 : Restart the server with --log-raw
-- and check if password is in plaintext
--echo -- shutdown the server from mtr.
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc

--echo -- restart the server.
--exec echo "restart: --log-raw" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

--replace_result $MYSQLTEST_VARDIR ...
eval SET GLOBAL general_log_file = '$MYSQLTEST_VARDIR/log/rewrite_general.log';
SET GLOBAL log_output =       'FILE,TABLE';
SET GLOBAL general_log=       'ON';

CREATE USER 'plaintext_test' IDENTIFIED BY 'pwd';
ALTER USER plaintext_test IDENTIFIED BY '' REPLACE 'pwd';
SET PASSWORD FOR plaintext_test='456' REPLACE '';
SET PASSWORD='789' REPLACE '456';
DROP USER plaintext_test;

-- Restart the server to original state
--echo -- shutdown the server from mtr.
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc

--echo -- restart the server.
--exec echo "restart:" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

-- Password must be seen in cleartext with --log-raw option. In case of ps-protocol mode the query returns 9 rows
SELECT count(*)=6 or count(*)=9 FROM mysql.general_log WHERE argument LIKE '%plaintext_test%' or argument like '%789%';

-- cleanup
DROP TABLE test_log;
