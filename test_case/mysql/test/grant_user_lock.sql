--

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

connection default;
CREATE USER unlocked_user@localhost IDENTIFIED BY 'pas';
SELECT account_locked FROM mysql.user
  WHERE user='unlocked_user' and host = 'localhost';
SELECT CURRENT_USER();
UPDATE mysql.user SET account_locked='Y'
  WHERE user='unlocked_user' and host = 'localhost';
SELECT CURRENT_USER();
SELECT CURRENT_USER();
UPDATE mysql.user SET account_locked='y'
  WHERE user='unlocked_user' and host = 'localhost';
ALTER USER unlocked_user@localhost ACCOUNT UNLOCK;
SELECT account_locked FROM mysql.user
  WHERE user = 'unlocked_user' and host = 'localhost';
SELECT CURRENT_USER();
ALTER USER unlocked_user@localhost ACCOUNT LOCK;
SELECT account_locked FROM mysql.user
  WHERE user = 'unlocked_user' and host = 'localhost';
CREATE USER unlocked_user2@localhost IDENTIFIED BY 'pas';
SELECT CURRENT_USER();
ALTER USER unlocked_user@localhost,
           unlocked_user2@localhost ACCOUNT UNLOCK;
SELECT user, account_locked FROM mysql.user
  WHERE (user = 'unlocked_user' and host = 'localhost') or
        (user = 'unlocked_user2' and host = 'localhost') ORDER BY user;
SELECT CURRENT_USER();
SELECT CURRENT_USER();
ALTER USER unlocked_user@localhost ACCOUNT LOCK;
DROP USER unlocked_user@localhost;
DROP USER unlocked_user2@localhost;
CREATE USER ''@localhost IDENTIFIED BY 'pass';
SELECT CURRENT_USER();
DROP USER ''@localhost;
CREATE USER ''@localhost IDENTIFIED BY 'pass' ACCOUNT UNLOCK;
SELECT CURRENT_USER();
DROP USER ''@localhost;
CREATE USER ''@localhost IDENTIFIED BY 'pass' ACCOUNT LOCK;
DROP USER ''@localhost;
CREATE USER ''@localhost IDENTIFIED BY 'pass';
ALTER USER ''@localhost ACCOUNT LOCK;
DROP USER ''@localhost;
CREATE USER ''@localhost IDENTIFIED BY 'pass' ACCOUNT LOCK;
ALTER USER ''@localhost ACCOUNT UNLOCK;
SELECT CURRENT_USER();
DROP USER ''@localhost;
CREATE USER ''@localhost IDENTIFIED BY 'pass';
ALTER USER ''@localhost PASSWORD EXPIRE ACCOUNT LOCK;
DROP USER ''@localhost;
CREATE user ''@localhost IDENTIFIED BY 'pass';
CREATE USER 'unlocked_user'@localhost IDENTIFIED BY 'pass';
UPDATE mysql.user SET account_locked='Y'
  WHERE user='unlocked_user' and host = 'localhost';
ALTER USER unlocked_user@localhost ACCOUNT LOCK;

-- Perform cleanup
connection default;
DROP USER unlocked_user@localhost;
DROP USER ''@localhost;
CREATE USER u1@localhost IDENTIFIED BY 'pass';
CREATE USER u2@localhost IDENTIFIED BY 'pass';
CREATE TABLE mysql.t1(counter INT)|
INSERT INTO mysql.t1 VALUES(0)|
CREATE DEFINER = u1@localhost PROCEDURE mysql.p1()
BEGIN
  UPDATE mysql.t1 SET counter = counter + 1;
  SELECT counter FROM mysql.t1;
ALTER USER u1@localhost ACCOUNT LOCK;
SELECT CURRENT_USER();
CREATE USER 'u3'@'localhost' IDENTIFIED BY 'pass' ACCOUNT LOCK;
let $1 = 10;
  ALTER USER u3@localhost ACCOUNT UNLOCK;
  ALTER USER u3@localhost ACCOUNT LOCK;
  dec $1;
CREATE USER u1@localhost REQUIRE NONE ACCOUNT LOCK WITH MAX_QUERIES_PER_HOUR 100;
DROP USER u1@localhost;
CREATE USER u1@localhost REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 100 ACCOUNT LOCK;
ALTER USER u1@localhost PASSWORD EXPIRE ACCOUNT UNLOCK;
ALTER USER u1@localhost ACCOUNT LOCK PASSWORD EXPIRE;
ALTER USER u1@localhost REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 99 ACCOUNT UNLOCK PASSWORD EXPIRE NEVER;
ALTER USER u1@localhost REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 98 PASSWORD EXPIRE INTERVAL 5 DAY ACCOUNT LOCK;
ALTER USER u1@localhost ACCOUNT UNLOCK WITH MAX_QUERIES_PER_HOUR 97 PASSWORD EXPIRE;
DROP USER u1@localhost;
CREATE USER u1@localhost IDENTIFIED BY 'PASS' ACCOUNT LOCK ACCOUNT UNLOCK;
DROP USER u1@localhost;
CREATE USER u1@localhost ACCOUNT UNLOCK ACCOUNT LOCK;
DROP USER u1@localhost;
CREATE USER u1@localhost ACCOUNT LOCK PASSWORD EXPIRE ACCOUNT LOCK;
ALTER USER u1@localhost IDENTIFIED BY 'PASS' ACCOUNT LOCK ACCOUNT UNLOCK;
ALTER USER u1@localhost ACCOUNT UNLOCK ACCOUNT LOCK;
ALTER USER u1@localhost ACCOUNT LOCK PASSWORD EXPIRE ACCOUNT LOCK;
ALTER USER u1@localhost PASSWORD EXPIRE ACCOUNT LOCK PASSWORD EXPIRE NEVER;
ALTER USER u1@localhost PASSWORD EXPIRE NEVER ACCOUNT LOCK PASSWORD EXPIRE INTERVAL 5 DAY ACCOUNT LOCK;
                         "Expected .*, found .*. "
                         "The table is probably corrupted");
CREATE TABLE mysql.temp_user LIKE mysql.user;
INSERT INTO mysql.temp_user SELECT * FROM mysql.user;
ALTER TABLE mysql.user DROP COLUMN account_locked;
ALTER TABLE mysql.user DROP COLUMN create_role_priv;
ALTER TABLE mysql.user DROP COLUMN drop_role_priv;
CREATE USER backuser@localhost IDENTIFIED BY 'pass' ACCOUNT LOCK;
SELECT COUNT(*) FROM mysql.user WHERE (user = 'backuser' and host = 'localhost');
CREATE USER backuser@localhost IDENTIFIED BY 'pass' ACCOUNT UNLOCK;
SELECT COUNT(*) FROM mysql.user WHERE (user = 'backuser' and host = 'localhost');
CREATE USER backuser@localhost IDENTIFIED BY 'pass';
SELECT COUNT(*) FROM mysql.user WHERE (user = 'backuser' and host = 'localhost');
SELECT user, account_locked FROM mysql.user WHERE (user = 'backuser' and host = 'localhost');
ALTER USER backuser@localhost ACCOUNT LOCK;
ALTER USER backuser@localhost ACCOUNT UNLOCK;
DROP USER backuser@localhost;
DROP TABLE mysql.user;
ALTER TABLE mysql.temp_user RENAME mysql.user;
CREATE DATABASE account;
CREATE TABLE account.`account` (account text(20));
INSERT INTO `account`.account VALUES("account");
SELECT account FROM account.account WHERE account = 'account';
SET @account = "account_before";
CREATE PROCEDURE account.account(OUT ac CHAR(20))
BEGIN
  SELECT account.`account`.account INTO ac FROM account.account;
SELECT @account;
DROP DATABASE account;
CREATE USER ACCOUNT@localhost ACCOUNT LOCK;
DROP USER ACCOUNT@localhost;

-- Perform cleanup
connection default;
DROP PROCEDURE mysql.p1;
DROP TABLE mysql.t1;
DROP USER u1@localhost;
DROP USER u2@localhost;
DROP USER u3@localhost;

CREATE USER u1 IDENTIFIED BY 'pass';
ALTER USER u1 ACCOUNT LOCK;
DROP USER u1;

-- Write file to make mysql-test-run.pl wait for the server to stop
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

-- Request shutdown
-- send_shutdown

-- Call script that will poll the server waiting for it to disapear
-- source include/wait_until_disconnected.inc

--echo -- Restart server.
--exec echo "restart:" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

-- Turn on reconnect
--enable_reconnect

-- Call script that will poll the server waiting for it to be back online again
--source include/wait_until_connected_again.inc

-- make sure we start with a clean slate. log_tables.test says this is OK.
TRUNCATE TABLE mysql.general_log;

SET @old_log_output=          @@global.log_output;
SET @old_general_log=         @@global.general_log;
SET @old_general_log_file=    @@global.general_log_file;
SET GLOBAL log_output =       'FILE,TABLE';
SET GLOBAL general_log=       'ON';

CREATE USER u1 IDENTIFIED BY 'pass';
CREATE USER u2 IDENTIFIED BY 'pass' ACCOUNT LOCK;
CREATE USER u3 IDENTIFIED BY 'pass' ACCOUNT UNLOCK;
ALTER USER u1 IDENTIFIED BY 'pass';
ALTER USER u1 IDENTIFIED BY 'pass' ACCOUNT LOCK;
ALTER USER u1 IDENTIFIED BY 'pass' ACCOUNT UNLOCK;

ALTER USER u2 IDENTIFIED BY 'pass';
SELECT argument FROM mysql.general_log WHERE argument LIKE 'CREATE USER %' AND
                                             command_type NOT LIKE 'Prepare';
SELECT argument FROM mysql.general_log WHERE argument LIKE 'ALTER USER %'AND
                                             command_type NOT LIKE 'Prepare';

-- cleanup
DROP USER u1, u2, u3;

SET GLOBAL general_log_file=  @old_general_log_file;
SET GLOBAL general_log=       @old_general_log;
SET GLOBAL log_output=        @old_log_output;
