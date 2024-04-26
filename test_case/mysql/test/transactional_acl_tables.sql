                         "Expected .*, found .*. "
                         "The table is probably corrupted");

SET autocommit= 0;
SET innodb_lock_wait_timeout= 1;

-- Check that the users we're going to use in this test don't exist.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Create an auxiliary connection.
--echo
--echo -- Connection: con1
--connect (con1, localhost, root,,)
SET autocommit= 0;
SET innodb_lock_wait_timeout= 1;

let $con1_id= `SELECT CONNECTION_ID()`;

-- Test plan:
-- A. Check that ACL statements are not vulnerable to the lock-wait-timeout.
--    NOTE: In case of getting rid of the table-level MDL-locks for the ACL
--    statements, the deadlock error should also be checked.
-- B. Check that SET PASSWORD commits a transaction.
-- C. Check the ACL statement behavior in case when multiple user accounts are
--    given.
-- D. Check the ACL statement behavior in case of SE failures.
-- E. Check it's not possible to change the privilege table storage engine
--    via ALTER TABLE. Also check that harmless ALTER TABLE (change SE to InnoDB
--    when it's already InnoDB) is allowed.
-- F. Upgrade/downgrade tests.

--echo
--echo --#######################################################################
--echo -- A.1. Checking lock-wait-timeout with CREATE USER.
--echo --#######################################################################

-- Start a transaction and insert a new row into mysql.user.

START TRANSACTION;

INSERT INTO mysql.user(user, host, ssl_cipher, x509_issuer, x509_subject)
VALUES ('u2', 'h', '', '', '');

-- CREATE USER with existing user in the middle.
-- CREATE USER is expected to wait for the transaction in the other connection
-- to finish.

--send CREATE USER u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Drop the created users (cleanup).
DROP USER u1@h, u2@h, u3@h;

CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host, password_lifetime FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- ALTER USER, the row corresponding to the second user is locked.
-- ALTER USER is expected to wait for the transaction in the other connection
-- to finish.
send ALTER USER u1@h, u2@h, u3@h PASSWORD EXPIRE INTERVAL 250 DAY;

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check the ALTER USER was successful.
SELECT user, host, password_lifetime FROM mysql.user WHERE host = 'h';

-- Drop the created users (cleanup).
DROP USER u1@h, u2@h, u3@h;

CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- RENAME USER, the row corresponding to the second user is locked.
-- RENAME USER is expected to wait for the transaction in the other connection
-- to finish.
--send RENAME USER u1@h TO u1a@h, u2@h TO u2a@h, u3@h TO u3a@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check the ALTER USER was successful.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Drop the created users (cleanup).
DROP USER u1a@h, u2a@h, u3a@h;

CREATE USER u1@h IDENTIFIED WITH 'mysql_native_password';

-- Check that the user has been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u1' AND host = 'h' FOR UPDATE;

-- SET PASSWORD, the row corresponding to the user is locked.
-- SET PASSWORD is expected to wait for the transaction in the other connection
-- to finish.
--send SET PASSWORD FOR u1@h = 'xxx'

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check the SET PASSWORD was successful.
SELECT user, host, authentication_string = '*3D56A309CD04FA2EEF181462E59011F075C89548' FROM mysql.user WHERE host = 'h';

-- Drop the created users (cleanup).
DROP USER u1@h;

CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- DROP USER, the row corresponding to the second user is locked.
-- DROP USER is expected to wait for the transaction in the other connection
-- to finish.
--send DROP USER u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check the DROP USER was successful.
SELECT user, host FROM mysql.user WHERE host = 'h';

CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- GRANT, the row corresponding to the second user is locked.
-- GRANT is expected to wait for the transaction in the other connection
-- to finish.
--send GRANT SELECT ON *.* TO u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the GRANT was successful.
SELECT user, select_priv FROM mysql.user WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;

CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- GRANT, the row corresponding to the second user is locked.
-- GRANT is expected to wait for the transaction in the other connection
-- to finish.
--send GRANT SELECT ON test.* TO u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the GRANT was successful.
SELECT * FROM mysql.db WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;

CREATE USER u1@h, u2@h, u3@h;
CREATE TABLE t1(a INT);

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- GRANT, the row corresponding to the second user is locked.
-- GRANT is expected to wait for the transaction in the other connection
-- to finish.
--send GRANT SELECT ON t1 TO u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the GRANT was successful.
SELECT user, table_name, table_priv FROM mysql.tables_priv WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;
DROP TABLE t1;

CREATE USER u1@h, u2@h, u3@h;
CREATE TABLE t1(a INT);

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- GRANT, the row corresponding to the second user is locked.
-- GRANT is expected to wait for the transaction in the other connection
-- to finish.
--send GRANT SELECT(a) ON t1 TO u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the GRANT was successful.
SELECT user, column_name, column_priv FROM mysql.columns_priv WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;
DROP TABLE t1;

CREATE USER u1@h, u2@h, u3@h;
CREATE PROCEDURE p1() SELECT 1;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- GRANT, the row corresponding to the second user is locked.
-- GRANT is expected to wait for the transaction in the other connection
-- to finish.
--send GRANT EXECUTE ON PROCEDURE p1 TO u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the GRANT was successful.
SELECT user, routine_name, proc_priv FROM mysql.procs_priv WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;
DROP PROCEDURE p1;

CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- REVOKE, the row corresponding to the second user is locked.
-- REVOKE is expected to wait for the transaction in the other connection
-- to finish.
--send REVOKE SELECT ON *.* FROM u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the REVOKE was successful.
SELECT user, select_priv FROM mysql.user WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;

CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- REVOKE, the row corresponding to the second user is locked.
-- REVOKE is expected to wait for the transaction in the other connection
-- to finish.
--send REVOKE SELECT ON test.* FROM u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the REVOKE was successful.
SELECT user FROM mysql.user WHERE host = 'h';
SELECT * FROM mysql.db WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;

CREATE TABLE t1(a INT);
CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- REVOKE, the row corresponding to the second user is locked.
-- REVOKE is expected to wait for the transaction in the other connection
-- to finish.
--send REVOKE SELECT ON t1 FROM u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the REVOKE was successful.
SELECT user FROM mysql.user WHERE host = 'h';
SELECT user, table_name, table_priv FROM mysql.tables_priv WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;
DROP TABLE t1;

CREATE TABLE t1(a INT);
CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- REVOKE, the row corresponding to the second user is locked.
-- REVOKE is expected to wait for the transaction in the other connection
-- to finish.
--send REVOKE SELECT(a) ON t1 FROM u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the REVOKE was successful.
SELECT user FROM mysql.user WHERE host = 'h';
SELECT user, column_name, column_priv FROM mysql.columns_priv WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;
DROP TABLE t1;

CREATE PROCEDURE p1() SELECT 1;
CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- REVOKE, the row corresponding to the second user is locked.
-- REVOKE is expected to wait for the transaction in the other connection
-- to finish.
--send REVOKE EXECUTE ON PROCEDURE p1 FROM u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the REVOKE was successful.
SELECT user FROM mysql.user WHERE host = 'h';
SELECT user, routine_name, proc_priv FROM mysql.procs_priv WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;
DROP PROCEDURE p1;

CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- REVOKE, the row corresponding to the second user is locked.
-- REVOKE is expected to wait for the transaction in the other connection
-- to finish.
--send REVOKE ALL PRIVILEGES, GRANT OPTION FROM u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the REVOKE was successful.
SELECT user, select_priv FROM mysql.user WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;

CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- REVOKE, the row corresponding to the second user is locked.
-- REVOKE is expected to wait for the transaction in the other connection
-- to finish.
--send REVOKE ALL PRIVILEGES, GRANT OPTION FROM u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the REVOKE was successful.
SELECT user FROM mysql.user WHERE host = 'h';
SELECT * FROM mysql.db WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;

CREATE TABLE t1(a INT);
CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- REVOKE, the row corresponding to the second user is locked.
-- REVOKE is expected to wait for the transaction in the other connection
-- to finish.
--send REVOKE ALL PRIVILEGES, GRANT OPTION FROM u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the REVOKE was successful.
SELECT user FROM mysql.user WHERE host = 'h';
SELECT user, table_name, table_priv FROM mysql.tables_priv WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;
DROP TABLE t1;

CREATE TABLE t1(a INT);
CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- REVOKE, the row corresponding to the second user is locked.
-- REVOKE is expected to wait for the transaction in the other connection
-- to finish.
--send REVOKE ALL PRIVILEGES, GRANT OPTION FROM u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the REVOKE was successful.
SELECT user FROM mysql.user WHERE host = 'h';
SELECT user, column_name, column_priv FROM mysql.columns_priv WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;
DROP TABLE t1;

CREATE PROCEDURE p1() SELECT 1;
CREATE USER u1@h, u2@h, u3@h;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Lock a row.
SELECT user, host FROM mysql.user WHERE user = 'u2' AND host = 'h' FOR UPDATE;

-- REVOKE, the row corresponding to the second user is locked.
-- REVOKE is expected to wait for the transaction in the other connection
-- to finish.
--send REVOKE ALL PRIVILEGES, GRANT OPTION FROM u1@h, u2@h, u3@h

--echo
--echo -- Connection: default
--connection default

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that the REVOKE was successful.
SELECT user FROM mysql.user WHERE host = 'h';
SELECT user, routine_name, proc_priv FROM mysql.procs_priv WHERE host = 'h';

-- Cleanup.
DROP USER u1@h, u2@h, u3@h;
DROP PROCEDURE p1;

-- Start a transaction and insert a new row into mysql.user.

START TRANSACTION;

INSERT INTO mysql.user(user, host, ssl_cipher, x509_issuer, x509_subject)
VALUES ('u2', 'h', '', '', '');

-- FLUSH PRIVILEGES is expected to wait for the transaction in the other
-- connection to finish.

--send FLUSH PRIVILEGES;

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for table metadata lock" AND id = $con1_id;

-- Check that all three users have been created.
SELECT user, host FROM mysql.user WHERE host = 'h';

-- Drop the created user (cleanup).
DROP USER u2@h;

CREATE TABLE t1(a INT);
CREATE USER u1@h;

INSERT INTO t1 VALUES (1), (2), (3);

SELECT * FROM t1;

SET PASSWORD FOR u1@h = '';

SELECT * FROM t1;

DROP TABLE t1;

CREATE PROCEDURE p1() SET PASSWORD FOR u1@h = '12345';
CREATE FUNCTION f1() RETURNS INT
BEGIN
  SET PASSWORD FOR u1@h = '12345';

CREATE FUNCTION f2()  RETURNS INT
BEGIN
  CALL p1();
SELECT f2();

DROP FUNCTION f2;
DROP PROCEDURE p1;

DROP USER u1@h;

-- 1. Positive Test cases

SELECT user, host FROM mysql.user where user like 'user%';
CREATE USER user2@localhost;
SELECT user, host FROM mysql.user where user like 'user%';
DROP USER user2@localhost;
SELECT user, host FROM mysql.user where user like 'user%';

-- 2. Negative Test cases

--error ER_CANNOT_USER
DROP USER no_user@localhost;

-- 3. Mixed test cases
-- For DROP USER statement, the current behavior is to ignore the failed
-- component and continue the statement execution. In the end, the statement
-- will report a list of failed components.

CREATE USER user2@localhost, user3@localhost;
DROP USER no_user@localhost, user3@localhost,
          no_user1@localhost, user2@localhost,
          no_user2@localhost;

DROP USER user2@localhost, user3@localhost;

SELECT user, host FROM mysql.user where user like 'user%';

-- 1. Positive Test cases

SELECT user, host FROM mysql.user where user like 'user%';
CREATE USER user2@localhost;
SELECT user, host FROM mysql.user where user like 'user%';
SELECT user, host FROM mysql.user where user like 'user%';

-- 2. Negative Test cases

--error ER_CANNOT_USER
RENAME USER no_user@localhost to user6@localhost;

-- 3. Mixed test cases
-- For RENAME USER statement, the current behavior is to ignore the failed
-- component and continue the statement execution. In the end, the statement
-- will report a list of failed components.

--error ER_CANNOT_USER
RENAME USER user3@localhost TO user6@localhost,
            no_user@localhost TO user3@localhost;

SELECT user, host FROM mysql.user where user like 'user%';

CREATE user user7@localhost;
            user7@localhost TO user4@localhost,
            no_user@localhost TO no_user1@localhost,
            temp_user@localhost to user7@localhost;

SELECT user, host FROM mysql.user where user like 'user%';
            user7@localhost TO user8@localhost,
            no_user1@localhost TO user11@localhost,
            user4@localhost TO user7@localhost,
            no_user2@localhost TO user12@localhost;

SELECT user, host FROM mysql.user where user like 'user%';

SET debug="+d,wl7158_handle_grant_table_1";
SET debug="-d,wl7158_handle_grant_table_1";

DROP USER user7@localhost;

-- 1. Positive Test cases
CREATE USER user2@localhost;

-- 2. Negative Test cases
-- Trying to CREATE DUPLICATE USER
--error ER_CANNOT_USER
CREATE USER user2@localhost;

-- 3. Mixed test cases

--error ER_CANNOT_USER
CREATE USER user3@localhost, user2@localhost, user4@localhost;

SELECT user, host FROM mysql.user where user like 'user%';

DROP USER user2@localhost, user3@localhost;

-- 1. Positive Test cases
CREATE USER u2@l;
ALTER USER u2@l PASSWORD EXPIRE INTERVAL 5 day;
SELECT user, password_lifetime FROM mysql.user where USER like 'u_';

-- 2. Negative Test cases
-- Trying to ALTER non existing user.
--error ER_CANNOT_USER
ALTER USER u3@l PASSWORD EXPIRE INTERVAL 5 DAY;

-- 3. Mixed test cases
-- For ALTER USER statement, the current behavior is to ignore the failed
-- component and continue the statement execution. In the end, the statement
-- will report a list of failed components.

--error ER_CANNOT_USER
ALTER USER u3@l, u2@l, u4@l PASSWORD EXPIRE INTERVAL 7 DAY;

SELECT user, password_lifetime FROM mysql.user WHERE user LIKE 'u_';

DROP USER u2@l;

-- Suppress server log like "Did not write failed 'GRANT SELECT ON ...' into
-- binary log while granting/revoking privileges in databases.
call mtr.add_suppression("Did not write failed .*");

-- It is not possible to execute a GRANT statement only for some users
-- (unlike 'DROP USER' which drops only existing users from the lists).
-- It is possible however, to make the GRANT statement fail by specifying
-- non-existing table or column.
--
-- This is no the case for the REVOKE statement -- it will report an error for
-- every non-existing user from the list and skip it.
--
-- There are plenty of test cases for GRANT and REVOKE already in grant.test.
-- This test file contains cases where statement is partially executed with
-- error.

CREATE TABLE t1(a INT, b INT);
CREATE USER u1@h, u3@h;
SELECT user, column_name, column_priv FROM mysql.columns_priv;
SELECT user, column_name, column_priv FROM mysql.columns_priv;
SELECT user, column_name, column_priv FROM mysql.columns_priv;
SELECT user, column_name, column_priv FROM mysql.columns_priv;
SELECT user, column_name, column_priv FROM mysql.columns_priv;
SELECT user, column_name, column_priv FROM mysql.columns_priv;
SELECT user, column_name, column_priv FROM mysql.columns_priv;
SELECT user, column_name, column_priv FROM mysql.columns_priv;
SELECT user, column_name, column_priv FROM mysql.columns_priv;
DROP USER u1@h, u3@h;
DROP TABLE t1;

CREATE USER u1@h;
CREATE USER u2@h;
CREATE SCHEMA test1;
CREATE TABLE test1.t1 (a INT);

-- Delete explicitely a row for the u1@h. User u1@h still exists in the acl-cache
-- but doesn't in the database. For such case REVOKE has to revoke grant for other user
-- and return an error for the whole statement.
DELETE FROM mysql.db WHERE host = 'h' AND user = 'u1';

DROP SCHEMA test1;
DROP USER u1@h, u2@h;
CREATE USER u1@h;
CREATE USER u2@h;
CREATE PROCEDURE p1() SET @a :=1;
DELETE FROM mysql.procs_priv WHERE routine_name='p1';
DROP PROCEDURE p1;
DROP USER u1@h, u2@h;

CREATE TABLE t1(a INT);
CREATE USER user1@;

SET debug='+d,wl7158_grant_table_1';
SET debug='-d,wl7158_grant_table_1';

SET debug='+d,wl7158_grant_table_2';
SET debug='-d,wl7158_grant_table_2';

SET debug='+d,wl7158_grant_table_3';
SET debug='-d,wl7158_grant_table_3';

DROP USER user1@;
DROP TABLE t1;

CREATE USER u1@h;

CREATE PROCEDURE p() SET @x = 1;
CREATE PROCEDURE p1() SET @y = 1;

SET debug='+d,wl7158_grant_load_1';
SET debug='-d,wl7158_grant_load_1';

SET debug='+d,wl7158_grant_load_proc_1';
SET debug='-d,wl7158_grant_load_proc_1';

SET debug='+d,wl7158_grant_load_2';
SET debug='-d,wl7158_grant_load_2';

SET debug="+d,wl7158_grant_load_proc_2";
SET debug="-d,wl7158_grant_load_proc_2";
SET debug="+d,wl7158_grant_load_proc_3";
SET debug="-d,wl7158_grant_load_proc_3";

CREATE TABLE t1(a INT);
SET debug='+d,wl7158_grant_load_3';
SET debug='-d,wl7158_grant_load_3';
DROP TABLE t1;

DROP USER u1@h;
DROP PROCEDURE p;
DROP PROCEDURE p1;

SET debug="+d,wl7158_replace_user_table_1";
CREATE USER u1@h;
SET debug="-d,wl7158_replace_user_table_1";
CREATE USER u1@h;

SET debug="+d,wl7158_replace_user_table_1";
SET PASSWORD FOR u1@h = 'systpass';
SET debug="-d,wl7158_replace_user_table_1";

SET debug="+d,wl7158_replace_user_table_2";
SET PASSWORD FOR u1@h = 'systpass';
SET debug="-d,wl7158_replace_user_table_2";
DROP USER u1@h;

CREATE USER u1@h;
SET debug="+d,wl7158_replace_user_table_1";
ALTER USER u1@h REQUIRE CIPHER "EDH-RSA-DES-CBC3-SHA";
SET debug="-d,wl7158_replace_user_table_1";

ALTER USER u1@h REQUIRE CIPHER "EDH-RSA-DES-CBC3-SHA";
SET debug="+d,wl7158_replace_user_table_2";
ALTER USER u1@h REQUIRE CIPHER "EDH-RSA-DES-CBC3-SHA"
  AND SUBJECT "testsubject" ISSUER "MySQL";
SET debug="-d,wl7158_replace_user_table_2";
DROP USER u1@h;

SET debug="+d,wl7158_replace_user_table_1";
CREATE USER u1@h;
SET debug="-d,wl7158_replace_user_table_1";

CREATE USER u1@h;
CREATE TABLE t1(a INT);
SET debug="+d,mysql_table_grant_out_of_memory";
SET debug="-d,mysql_table_grant_out_of_memory";
DROP TABLE t1;
DROP USER u1@h;

SET debug="+d,wl7158_replace_user_table_3";
CREATE USER u1@h;
SET debug="-d,wl7158_replace_user_table_3";

-- Tests for change grants in the mysql.db table
--

CREATE USER u1@h;
SET debug="+d,wl7158_replace_db_table_1";
SET debug="-d,wl7158_replace_db_table_1";
SET debug="+d,wl7158_replace_db_table_2";
SET debug="-d,wl7158_replace_db_table_2";

SET debug="+d,wl7158_replace_db_table_3";
SET debug="-d,wl7158_replace_db_table_3";
DROP USER u1@h;

CREATE USER u1@h;
SET debug="+d,wl7158_replace_db_table_4";
SET debug="-d,wl7158_replace_db_table_4";
DROP USER u1@h;

SET debug="+d,mysql_handle_grant_data_fail_on_routine_table";
CREATE USER u1@h;
SET debug="-d,mysql_handle_grant_data_fail_on_routine_table";

SET debug="+d,mysql_handle_grant_data_fail_on_tables_table";
CREATE USER u1@h;
SET debug="-d,mysql_handle_grant_data_fail_on_tables_table";

SET debug="+d,mysql_handle_grant_data_fail_on_columns_table";
CREATE USER u1@h;
SET debug="-d,mysql_handle_grant_data_fail_on_columns_table";

SET debug="+d,mysql_handle_grant_data_fail_on_proxies_priv_table";
CREATE USER u1@h;
SET debug="-d,mysql_handle_grant_data_fail_on_proxies_priv_table";

--
-- Test for privilege table
--

SET debug="+d,wl7158_handle_grant_table_1";
CREATE USER u1@h;
SET debug="-d,wl7158_handle_grant_table_1";

CREATE USER u1@h;
SET debug="+d,wl7158_modify_grant_table_1";
SET debug="-d,wl7158_modify_grant_table_1";

DROP USER u1@h;

CREATE USER u1@h;
SET debug="+d,wl7158_modify_grant_table_2";
DROP USER u1@h;
SET debug="-d,wl7158_modify_grant_table_2";
DROP USER u1@h;

--
-- Test for proxies priv
--

CREATE USER u1@h;
SET debug="+d,wl7158_replace_proxies_priv_table_1";
SET debug="-d,wl7158_replace_proxies_priv_table_1";

SET debug="+d,wl7158_replace_proxies_priv_table_2";
SET debug="-d,wl7158_replace_proxies_priv_table_2";

SET debug="+d,wl7158_replace_proxies_priv_table_5";
SET debug="-d,wl7158_replace_proxies_priv_table_5";
SET debug="+d,wl7158_replace_proxies_priv_table_3";
SET debug="-d,wl7158_replace_proxies_priv_table_3";

SET debug="+d,wl7158_replace_proxies_priv_table_4";
SET debug="-d,wl7158_replace_proxies_priv_table_4";

DROP USER u1@h;

--
-- Test for Column priv
--

CREATE TABLE t1 (a INT);
CREATE USER u1@h;

SET debug="+d,wl7158_replace_column_table_1";
SET debug="-d,wl7158_replace_column_table_1";

SET debug="+d,wl7158_replace_column_table_2";
SET debug="-d,wl7158_replace_column_table_2";

SET debug="+d,wl7158_replace_column_table_5";
SET debug="-d,wl7158_replace_column_table_5";
SET debug="+d,wl7158_replace_column_table_3";
SET debug="-d,wl7158_replace_column_table_3";

SET debug="+d,wl7158_replace_column_table_4";
SET debug="-d,wl7158_replace_column_table_4";

-- CHECK if even after error, above REVOKE worked.
GRANT SELECT(a), UPDATE(a), INSERT(a), REFERENCES(a) ON t1 TO u1@h;
SET debug="+d,wl7158_replace_column_table_6";
SET debug="-d,wl7158_replace_column_table_6";
SET debug="+d,wl7158_replace_column_table_7";
SET debug="-d,wl7158_replace_column_table_7";
SET debug="+d,wl7158_replace_column_table_8";
SET debug="-d,wl7158_replace_column_table_8";

-- CHECK that REVOKE ALL works correctly in case when a row from
-- columns_priv had been deleted for some user before REVOKE ALL
-- has been run.
CREATE TABLE t2 (a INT);
SELECT host, db, user, table_name, column_name, column_priv FROM mysql.columns_priv;
SELECT host, db, user, table_name, grantor, table_priv, column_priv FROM mysql.tables_priv;
DELETE FROM mysql.columns_priv WHERE host = 'h' AND user = 'u1'
AND table_name = 't1';

SELECT host, db, user, table_name, column_name, column_priv FROM mysql.columns_priv;
SELECT host, db, user, table_name, grantor, table_priv, column_priv FROM mysql.tables_priv;

-- Check whether on FLUSH PRIVILEGES the GRANT_TABLE::init handles OUT OF MEMORY
-- condition correctly

GRANT UPDATE (a) ON t1 TO u1@h;
SET debug='+d,mysql_grant_table_init_out_of_memory';
SET debug='-d,mysql_grant_table_init_out_of_memory';

DROP TABLE t1;
DROP TABLE t2;
DROP USER u1@h;
CREATE USER u1@h;
CREATE TABLE t1 (a INT);
SET debug="+d,wl7158_replace_column_table_5";
SELECT * FROM mysql.columns_priv WHERE host = 'h' AND user = 'u1';
SELECT * FROM mysql.tables_priv WHERE host = 'h' AND user = 'u1';

SET debug="-d,wl7158_replace_column_table_5";

DROP TABLE t1;
DROP USER u1@h;
--

CREATE TABLE t1 (a INT);
CREATE USER u1@h;

SET debug="+d,wl7158_replace_table_table_1";
SET debug="-d,wl7158_replace_table_table_1";

SET debug="+d,wl7158_replace_table_table_3";
SET debug="-d,wl7158_replace_table_table_3";
SET debug="+d,wl7158_replace_table_table_2";
SET debug="-d,wl7158_replace_table_table_2";

DROP TABLE t1;
DROP USER u1@h;

--
-- Tests for routines priv
--

CREATE TABLE t1 (a INT);
CREATE USER u1@h;
CREATE PROCEDURE p() SET @x = 1;

SET debug="+d,wl7158_replace_routine_table_1";
SET debug="-d,wl7158_replace_routine_table_1";

SET debug="+d,wl7158_replace_routine_table_4";
SET debug="-d,wl7158_replace_routine_table_4";
SET debug="+d,wl7158_replace_routine_table_2";
SET debug="-d,wl7158_replace_routine_table_2";

SET debug="+d,wl7158_replace_routine_table_3";
DROP PROCEDURE p;
SET debug="-d,wl7158_replace_routine_table_3";

DROP TABLE t1;
DROP USER u1@h;

CREATE TABLE mysql.db ENGINE=MyISAM SELECT * FROM mysql.db_bak;

CREATE TABLE mysql.user ENGINE=MyISAM SELECT * FROM mysql.user_bak;

CREATE TABLE mysql.columns_priv ENGINE=MyISAM SELECT * FROM mysql.columns_priv_bak;

CREATE TABLE mysql.procs_priv ENGINE=MyISAM SELECT * FROM mysql.procs_priv_bak;

CREATE TABLE mysql.proxies_priv ENGINE=MyISAM SELECT * FROM mysql.proxies_priv_bak;

CREATE TABLE mysql.tables_priv ENGINE=MyISAM SELECT * FROM mysql.tables_priv_bak;

DROP TABLE mysql.user, mysql.db, mysql.columns_priv,
           mysql.procs_priv, mysql.proxies_priv, mysql.tables_priv;

-- Create the user u1@h before server upgrade.

CREATE USER u1@h;
let $date_to_restore=`SELECT password_last_changed from mysql.user where user='mysql.session'`;
let $sess_user_account_priv=`SELECT timestamp from mysql.tables_priv where user='mysql.session'`;
DELETE FROM mysql.tables_priv WHERE user='mysql.session';
DELETE FROM mysql.user WHERE user='mysql.session';
DELETE FROM mysql.db WHERE user='mysql.session';

CREATE TABLE IF NOT EXISTS mysql.db (   Host char(60) binary DEFAULT '' NOT NULL,
 Db char(64) binary DEFAULT '' NOT NULL, User char(16) binary DEFAULT '' NOT NULL,
 Select_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Insert_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Update_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Delete_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Create_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Drop_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Grant_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 References_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Index_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Alter_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Create_tmp_table_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Lock_tables_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Create_view_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Show_view_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Create_routine_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Alter_routine_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Execute_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Event_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Trigger_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 PRIMARY KEY Host (Host,Db,User), KEY User (User) ) engine=MyISAM
 CHARACTER SET utf8mb3 COLLATE utf8mb3_bin comment='Database privileges';

CREATE TABLE IF NOT EXISTS mysql.user (   Host char(60) binary DEFAULT '' NOT NULL,
 User char(16) binary DEFAULT '' NOT NULL, Password char(41) character set latin1
 collate latin1_bin DEFAULT '' NOT NULL, Select_priv enum('N','Y') COLLATE utf8mb3_general_ci
 DEFAULT 'N' NOT NULL, Insert_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Update_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Delete_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Create_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Drop_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Reload_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Shutdown_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Process_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 File_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Grant_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 References_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Index_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Alter_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Show_db_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Super_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Create_tmp_table_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Lock_tables_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Execute_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Repl_slave_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Repl_client_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Create_view_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Show_view_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Create_routine_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Alter_routine_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Create_user_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Event_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Trigger_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 Create_tablespace_priv enum('N','Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 ssl_type enum('','ANY','X509', 'SPECIFIED') COLLATE utf8mb3_general_ci DEFAULT '' NOT NULL,
 ssl_cipher BLOB NOT NULL, x509_issuer BLOB NOT NULL, x509_subject BLOB NOT NULL,
 max_questions int(11) unsigned DEFAULT 0  NOT NULL,
 max_updates int(11) unsigned DEFAULT 0  NOT NULL,
 max_connections int(11) unsigned DEFAULT 0  NOT NULL,
 max_user_connections int(11) unsigned DEFAULT 0  NOT NULL,
 plugin char(64) DEFAULT 'caching_sha2_password', authentication_string TEXT,
 password_expired ENUM('N', 'Y') COLLATE utf8mb3_general_ci DEFAULT 'N' NOT NULL,
 PRIMARY KEY Host (Host,User) ) engine=MyISAM CHARACTER SET utf8mb3 COLLATE utf8mb3_bin
 comment='Users and global privileges';

CREATE TABLE IF NOT EXISTS mysql.tables_priv ( Host char(60) binary DEFAULT '' NOT NULL,
 Db char(64) binary DEFAULT '' NOT NULL, User char(16) binary DEFAULT '' NOT NULL,
 Table_name char(64) binary DEFAULT '' NOT NULL, Grantor char(77) DEFAULT '' NOT NULL,
 Timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 Table_priv set('Select','Insert','Update','Delete','Create','Drop','Grant','References',
 'Index','Alter','Create View','Show view','Trigger') COLLATE utf8mb3_general_ci DEFAULT '' NOT NULL,
 Column_priv set('Select','Insert','Update','References') COLLATE utf8mb3_general_ci DEFAULT ''
 NOT NULL, PRIMARY KEY (Host,Db,User,Table_name), KEY Grantor (Grantor) )
 engine=MyISAM CHARACTER SET utf8mb3 COLLATE utf8mb3_bin   comment='Table privileges';

CREATE TABLE IF NOT EXISTS mysql.columns_priv ( Host char(60) binary DEFAULT '' NOT NULL,
 Db char(64) binary DEFAULT '' NOT NULL, User char(16) binary DEFAULT '' NOT NULL,
 Table_name char(64) binary DEFAULT '' NOT NULL, Column_name char(64) binary DEFAULT '' NOT NULL,
 Timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 Column_priv set('Select','Insert','Update','References') COLLATE utf8mb3_general_ci
 DEFAULT '' NOT NULL, PRIMARY KEY (Host,Db,User,Table_name,Column_name) )
 engine=MyISAM CHARACTER SET utf8mb3 COLLATE utf8mb3_bin   comment='Column privileges';

CREATE TABLE IF NOT EXISTS mysql.procs_priv ( Host char(60) binary DEFAULT '' NOT NULL,
 Db char(64) binary DEFAULT '' NOT NULL, User char(16) binary DEFAULT '' NOT NULL,
 Routine_name char(64) COLLATE utf8mb3_general_ci DEFAULT '' NOT NULL,
 Routine_type enum('FUNCTION','PROCEDURE') NOT NULL, Grantor char(77) DEFAULT '' NOT NULL,
 Proc_priv set('Execute','Alter Routine','Grant') COLLATE utf8mb3_general_ci DEFAULT '' NOT NULL,
 Timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (Host,Db,User,Routine_name,Routine_type), KEY Grantor (Grantor) )
 engine=MyISAM CHARACTER SET utf8mb3 COLLATE utf8mb3_bin   comment='Procedure privileges';

CREATE TABLE IF NOT EXISTS mysql.proxies_priv (Host char(60) binary DEFAULT '' NOT NULL,
 User char(16) binary DEFAULT '' NOT NULL, Proxied_host char(60) binary DEFAULT '' NOT NULL,
 Proxied_user char(16) binary DEFAULT '' NOT NULL, With_grant BOOL DEFAULT 0 NOT NULL,
 Grantor char(77) DEFAULT '' NOT NULL, Timestamp timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
 ON UPDATE CURRENT_TIMESTAMP, PRIMARY KEY Host (Host,User,Proxied_host,Proxied_user),
 KEY Grantor (Grantor) ) engine=MyISAM CHARACTER SET utf8mb3 COLLATE utf8mb3_bin
 comment='User proxy privileges';

INSERT INTO mysql.user(Host, User, Select_priv, Insert_priv, Update_priv, Delete_priv,
 Create_priv, Drop_priv, Reload_priv, Shutdown_priv, Process_priv, File_priv, Grant_priv,
 References_priv, Index_priv, Alter_priv, Show_db_priv, Super_priv, Create_tmp_table_priv,
 Lock_tables_priv, Execute_priv, Repl_slave_priv, Repl_client_priv, Create_view_priv,
 Show_view_priv, Create_routine_priv, Alter_routine_priv, Create_user_priv, Event_priv,
 Trigger_priv, Create_tablespace_priv, ssl_type, ssl_cipher, x509_issuer, x509_subject,
 max_questions, max_updates, max_connections, max_user_connections, plugin,
 authentication_string, password_expired) SELECT Host, User, Select_priv, Insert_priv,
 Update_priv, Delete_priv, Create_priv, Drop_priv, Reload_priv, Shutdown_priv, Process_priv,
 File_priv, Grant_priv, References_priv, Index_priv, Alter_priv, Show_db_priv, Super_priv,
 Create_tmp_table_priv, Lock_tables_priv, Execute_priv, Repl_slave_priv, Repl_client_priv,
 Create_view_priv, Show_view_priv, Create_routine_priv, Alter_routine_priv, Create_user_priv,
 Event_priv, Trigger_priv, Create_tablespace_priv, ssl_type, ssl_cipher, x509_issuer,
 x509_subject, max_questions, max_updates, max_connections, max_user_connections, plugin,
 authentication_string, password_expired FROM mysql.user_bak;

INSERT INTO mysql.db(Host, Db, User, Select_priv, Insert_priv, Update_priv, Delete_priv,
 Create_priv, Drop_priv, Grant_priv, References_priv, Index_priv, Alter_priv,
 Create_tmp_table_priv, Lock_tables_priv, Create_view_priv, Show_view_priv, Create_routine_priv,
 Alter_routine_priv, Execute_priv, Event_priv, Trigger_priv) SELECT Host, Db, User, Select_priv,
 Insert_priv, Update_priv, Delete_priv, Create_priv, Drop_priv, Grant_priv, References_priv,
 Index_priv, Alter_priv, Create_tmp_table_priv, Lock_tables_priv, Create_view_priv,
 Show_view_priv, Create_routine_priv, Alter_routine_priv, Execute_priv, Event_priv,
 Trigger_priv FROM mysql.db_bak;

INSERT INTO mysql.columns_priv(Host, Db, User, Table_name, Column_name, Timestamp, Column_priv)
 SELECT Host, Db, User, Table_name, Column_name, Timestamp, Column_priv
 FROM mysql.columns_priv_bak;

INSERT INTO mysql.procs_priv(Host, Db, User, Routine_name, Routine_type, Grantor, Proc_priv,
 Timestamp) SELECT Host, Db, User, Routine_name, Routine_type, Grantor, Proc_priv, Timestamp
 FROM mysql.procs_priv_bak;

INSERT INTO mysql.proxies_priv(Host, User, Proxied_host, Proxied_user, With_grant, Grantor,
 Timestamp) SELECT Host, User, Proxied_host, Proxied_user, With_grant, Grantor, Timestamp
 FROM mysql.proxies_priv_bak;

INSERT INTO mysql.tables_priv(Host, Db, User, Table_name, Grantor, Timestamp, Table_priv,
 Column_priv) SELECT Host, Db, User, Table_name, Grantor, Timestamp, Table_priv, Column_priv
 FROM mysql.tables_priv_bak;

CREATE TABLE t1 (a INT);

-- Since the definition of mysql.user was changed by the WL#6409 (the column
-- 'password' was removed) the number of column Event_priv was changed by 1.
-- It resulted in output of error message that the column Event_priv is not
-- located in expected position. It is expected behaviour and the error message
-- will disappear after the database upgrade is done.
call mtr.add_suppression("mysql.user has no `Event_priv` column at position 28");
CREATE USER u2@h;
ALTER USER u1@h PASSWORD EXPIRE;
SET PASSWORD FOR u1@h = '123';
DROP USER u1@h;

SELECT table_name, engine FROM INFORMATION_SCHEMA.TABLES
WHERE table_schema = 'mysql' AND
      table_name IN ('user', 'db', 'columns_priv', 'procs_priv',
                     'proxies_priv', 'tables_priv')
ORDER BY table_name;
SELECT table_name, engine FROM INFORMATION_SCHEMA.TABLES
WHERE table_schema = 'mysql' AND
      table_name IN ('user', 'db', 'columns_priv', 'procs_priv',
                     'proxies_priv', 'tables_priv')
ORDER BY table_name;

DROP TABLES mysql.user, mysql.db, mysql.columns_priv, mysql.procs_priv,
 mysql.proxies_priv, mysql.tables_priv;


-- Remove user mysql.session and re-created as defined in
-- scripts/mysql_system_users.sql

DROP USER 'mysql.session'@localhost;

CREATE USER 'mysql.session'@localhost IDENTIFIED WITH caching_sha2_password AS '$A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED' ACCOUNT LOCK;

DROP USER u1@h;
DROP TABLE t1;

CREATE TABLE t1 (a INT);
CREATE USER u1;

-- Add record into mysql.tables_priv
GRANT ALL ON test.t1 TO 'u1' ;
SET autocommit = 0;
SET autocommit = 0;

DELETE FROM mysql . tables_priv WHERE user = 'u1' LIMIT 1;

-- Without a patch the following statement would leave MDL lock unreleased
-- on mysql.tables_priv. This lock has been acquired when DELETE being executed.
-- It would led to the DBUG_ASSERT(error != HA_ERR_LOCK_WAIT_TIMEOUT) later
-- when GRANT ALL be handled.
ROLLBACK WORK TO SAVEPOINT A;

SET innodb_lock_wait_timeout= 1;
let $wait_timeout= 2;
let $wait_condition= SELECT 1 FROM INFORMATION_SCHEMA.PROCESSLIST
WHERE state = 'Waiting for table metadata lock' AND
      info = 'GRANT ALL ON t1 TO \'u1\'';

DROP USER u1;
DROP TABLE t1;
