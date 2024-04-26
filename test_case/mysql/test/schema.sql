--

--source include/have_debug_sync.inc

-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc

let $MYSQLD_DATADIR= `SELECT @@datadir`;

-- MDL blocking concurrent drop schema is different with --ps-protocol
let $drop_schema_target_state='Waiting for schema metadata lock';
{
  let $drop_schema_target_state='Waiting for table metadata lock';
drop database if exists mysqltest1;

create schema foo;
drop schema foo;
DROP SCHEMA IF EXISTS schema1;

CREATE SCHEMA schema1;
CREATE TABLE schema1.t1 (a INT);

SET autocommit= FALSE;
INSERT INTO schema1.t1 VALUES (1);

let $wait_condition= SELECT COUNT(*)= 1 FROM information_schema.processlist
                     WHERE state= $drop_schema_target_state
                     AND info='DROP SCHEMA schema1';
ALTER SCHEMA schema1 DEFAULT CHARACTER SET utf8mb3;
SET autocommit= TRUE;
DROP SCHEMA IF EXISTS schema1;
CREATE SCHEMA schema1;
CREATE TABLE schema1.t1 (id INT);
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist 
  WHERE state='Waiting for schema metadata lock' and info='DROP SCHEMA schema1';
CREATE SCHEMA IF NOT EXISTS schema1;

CREATE DATABASE db1;
CREATE TABLE db1.t1 (a INT);
INSERT INTO db1.t1 VALUES (1), (2);
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state='Waiting for table metadata lock' AND info='DROP DATABASE db1';
CREATE DATABASE db2;
ALTER DATABASE db2 DEFAULT CHARACTER SET utf8mb3;
DROP DATABASE db2;
DROP DATABASE IF EXISTS db1;
DROP DATABASE IF EXISTS db2;
CREATE DATABASE db1;
CREATE TABLE db1.t1 (id INT);
INSERT INTO db1.t1 VALUES (1);

let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist 
  WHERE state= $drop_schema_target_state;
CREATE DATABASE db2;
ALTER DATABASE db2 DEFAULT CHARACTER SET utf8mb3;
DROP DATABASE db2;
SET @start_session_value= @@session.lock_wait_timeout;
SET @@session.lock_wait_timeout= 1;
CREATE SCHEMA testdb;
SET DEBUG_SYNC= 'acquired_schema_while_acquiring_table SIGNAL acquired WAIT_FOR cont';
SET DEBUG_SYNC= 'now WAIT_FOR acquired';
DROP SCHEMA testdb;
SET DEBUG_SYNC= 'now SIGNAL cont';
DROP SCHEMA testdb;
SET @@session.lock_wait_timeout= @start_session_value;
SET DEBUG_SYNC= 'RESET';
SET @start_session_value= @@session.lock_wait_timeout;
SET @@session.lock_wait_timeout= 1;
CREATE SCHEMA testdb;
SET DEBUG_SYNC= 'acquired_schema_while_getting_collation SIGNAL acquired WAIT_FOR cont';
SET DEBUG_SYNC= 'now WAIT_FOR acquired';
DROP SCHEMA testdb;
SET DEBUG_SYNC= 'now SIGNAL cont';
SET DEBUG_SYNC= 'RESET';
DROP SCHEMA testdb;
SET @@session.lock_wait_timeout= @start_session_value;

-- Check that all connections opened by test cases in this file are really
-- gone so execution of other tests won't be affected by their presence.
--source include/wait_until_count_sessions.inc

--
-- WL#6378: New data dictionary.
--
-- Replace usage of 'check_db_dir_existence()' by
-- 'dd::schema_exists()'. Error handling will be
-- slightly different in some situations. Below,
-- six test cases check the behavior.

--disable_query_log
CALL mtr.add_suppression("Failed to find tablespace");

-- 1. Create schema, remove directory, then try schema statements.

-- Schema directory path.
--let $MYSQL_DATA_DIR= `select @@datadir`
--let $SCHEMA_DIR= $MYSQL_DATA_DIR/s

-- Create and remove schema directory.
CREATE SCHEMA s;

-- SHOW CREATE SCHEMA accesses meta data only, and succeeds.
SHOW CREATE SCHEMA s;

-- USE SCHEMA checks meta data only, and succeeds
USE s;

-- ALTER SCHEMA is a meta data only operation, and succeeds.
ALTER SCHEMA s DEFAULT COLLATE= utf8_general_ci;

-- SHOW CREATE SCHEMA accesses meta data only, and succeeds.
SHOW CREATE SCHEMA s;

-- DROP SCHEMA verifies directory existence, and fails.
--replace_result $MYSQLD_DATADIR ./ \\ /
--error ER_SCHEMA_DIR_MISSING
DROP SCHEMA s;

-- Re-create the directory, then DROP will work.
--mkdir $SCHEMA_DIR
DROP SCHEMA s;

-- 2. Create schema, remove directory, then try CREATE VIEW.

-- Schema directory path.
--let $MYSQL_DATA_DIR= `select @@datadir`
--let $SCHEMA_DIR= $MYSQL_DATA_DIR/s

-- Create and remove schema directory.
CREATE SCHEMA s;

-- CREATE VIEW does not access the file system, and succeeds.
CREATE VIEW s.v AS SELECT * FROM mysql.time_zone;

-- Re-create the directory, then DROP will work.
--mkdir $SCHEMA_DIR
DROP SCHEMA s;

-- 3. Create schema, remove directory, then try CREATE TABLE.

-- Schema directory path.
--let $MYSQL_DATA_DIR= `select @@datadir`
--let $SCHEMA_DIR= $MYSQL_DATA_DIR/s

-- Create and remove schema directory.
CREATE SCHEMA s;

-- CREATE TABLE for InnoDB creates parent directory, and succeeds.
CREATE TABLE s.t (pk INTEGER PRIMARY KEY) ENGINE= InnoDB;

-- DROP will work here since InnoDB created the directory.
DROP SCHEMA s;

-- 4. Create schema, create tables, remove directory, then try ALTER TABLE.

-- Schema directory path.
--let $MYSQL_DATA_DIR= `select @@datadir`
--let $SCHEMA_DIR= $MYSQL_DATA_DIR/s

-- CREATE SCHEMA.
CREATE SCHEMA s;

-- CREATE TABLE for InnoDB.
CREATE TABLE s.t_innodb (pk INTEGER PRIMARY KEY) ENGINE= InnoDB;

-- Shut server down.
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc

-- Remove schema directory and files.
--remove_files_wildcard $SCHEMA_DIR *
--rmdir $SCHEMA_DIR

-- Restart the server.
--exec echo "restart" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

-- ALTER TABLE for InnoDB fails differently depending on platform.
--error ER_GET_ERRNO, ER_TABLESPACE_MISSING
ALTER TABLE s.t_innodb ADD COLUMN c INTEGER;

-- Re-create the directory, then DROP will work.
--mkdir $SCHEMA_DIR
DROP SCHEMA s;

-- 5. Create schema, create tables, remove directory, then try SHOW CREATE TABLE.

-- Schema directory path.
--let $MYSQL_DATA_DIR= `select @@datadir`
--let $SCHEMA_DIR= $MYSQL_DATA_DIR/s

-- CREATE SCHEMA.
CREATE SCHEMA s;

-- CREATE TABLE for InnoDB.
CREATE TABLE s.t_innodb (pk INTEGER PRIMARY KEY) ENGINE= InnoDB;

-- Shut server down.
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc

-- Remove schema directory and files.
--remove_files_wildcard $SCHEMA_DIR *
--rmdir $SCHEMA_DIR

-- Restart the server.
--exec echo "restart" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

-- SHOW CREATE TABLE for InnoDB succeeds except on Windows.
-- Mute the statement due to platform dependent output.
--disable_query_log
--error 0, ER_TABLESPACE_MISSING
SHOW CREATE TABLE s.t_innodb;

-- Re-create the directory, then DROP will work.
--mkdir $SCHEMA_DIR
DROP SCHEMA s;

-- 6. Create schema, create tables, remove directory, then try DROP TABLE.

-- Schema directory path.
--let $MYSQL_DATA_DIR= `select @@datadir`
--let $SCHEMA_DIR= $MYSQL_DATA_DIR/s

-- CREATE SCHEMA.
CREATE SCHEMA s;

-- CREATE TABLE for InnoDB.
CREATE TABLE s.t_innodb (pk INTEGER PRIMARY KEY) ENGINE= InnoDB;

-- Shut server down.
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc

-- Remove schema directory and files.
--remove_files_wildcard $SCHEMA_DIR *
--rmdir $SCHEMA_DIR

-- Restart the server.
--exec echo "restart" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

-- DROP TABLE for InnoDB succeeds.
DROP TABLE s.t_innodb;

-- Re-create the directory, then DROP will work.
--mkdir $SCHEMA_DIR
DROP SCHEMA s;

-- End of tests for WL#6378: New data dictionary.


--echo --
--echo -- Bug#24732194: "USE DB_NAME" AND "SELECT SCHEMA()"
--echo --               WORK FOR NON-EXISTING DATABASES
--echo --

-- Create the directory manually
--mkdir $SCHEMA_DIR

-- USE should fail, it didn't before.
--error ER_BAD_DB_ERROR
USE s;

-- Cleanup
--rmdir $SCHEMA_DIR


--echo --
--echo -- WL#7743 "New data dictionary: changes to DDL-related parts of SE API"
--echo --
--echo -- Additional test coverage for changes in DROP DATABASE implementation.
--echo -- Check what happens when we fail to remove database directory during
--echo -- the last step of DROP DATABASE, when statement is already committed.

--enable_connect_log
--disable_query_log
CALL mtr.add_suppression("Problem while dropping database. Can't remove database directory .* Please remove it manually.");
let $MYSQLD_DATADIR= `SELECT @@datadir`;
CREATE DATABASE db1;
CREATE FUNCTION db1.f1() RETURNS INT RETURN 0;
SELECT db1.f1();
let $wait_condition= SELECT COUNT(*)= 1 FROM information_schema.processlist
                     WHERE state= 'Waiting for stored function metadata lock'
                     AND info='DROP DATABASE db1';
EOF
--echo -- Unblock DROP DATABASE by releasing S lock.
COMMIT;
let SEARCH_FILE= $MYSQLTEST_VARDIR/log/mysqld.1.err;

CREATE DATABASE db1;
CREATE TABLE db1.t1(id INT, title VARCHAR(100),
                    FULLTEXT fidx(title), PRIMARY KEY(id));
SET DEBUG_SYNC= 'get_share_before_open SIGNAL wait_share WAIT_FOR continue_insert';
SET SESSION lock_wait_timeout= 5;
SET DEBUG_SYNC= 'now WAIT_FOR wait_share';
SET DEBUG_SYNC= 'get_share_before_COND_open_wait SIGNAL wait_cond WAIT_FOR continue_alter';
SET DEBUG_SYNC= 'now WAIT_FOR wait_cond';
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for schema metadata lock" AND
        info = "DROP DATABASE db1";
SET DEBUG_SYNC= 'now SIGNAL continue_insert';
SET DEBUG_SYNC= 'now SIGNAL continue_alter';
DROP SCHEMA s1;
DROP SCHEMA IF EXISTS s1;
CREATE SCHEMA s1;
CREATE SCHEMA s1;
CREATE SCHEMA IF NOT EXISTS s1;
DROP SCHEMA s1;
CREATE SCHEMA bogus__;
CREATE SCHEMA IF NOT EXISTS bogus__;
DROP SCHEMA bogus__;
DROP SCHEMA IF EXISTS bogus__;

CREATE SCHEMA broken;
DROP SCHEMA broken;
DROP SCHEMA IF EXISTS broken;
CREATE SCHEMA broken;
DROP SCHEMA broken;

CREATE SCHEMA s CHARACTER SET ascii;
USE s;

ALTER SCHEMA s ENCRYPTION = 'n';

DROP SCHEMA s;

CREATE SCHEMA s1;
USE s1;
CREATE TABLE t1(a INT);
ALTER SCHEMA s1 READ ONLY DEFAULT;
DROP table t1;
DROP SCHEMA s1;

CREATE DATABASE test1 COLLATE utf8mb4_bin CHARACTER SET utf8mb4;
DROP DATABASE test1;
