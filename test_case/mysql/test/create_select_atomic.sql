--    being created to be rollbacked.
--
-- R2 CREATE TABLE ... TRANSACTION;
--    commands other than BINLOG INSERT, COMMIT and ROLLBACK.
--
-- R3 Reject use of CREATE TABLE ... TRANSACTION using a prepared statement.
--
-- ==== Implementation ====
--
-- TC1: Crash DDL_CTAS after table is created but before INSERT.
-- 1) Create table t0 with few rows.
-- 2) Set debug point to induce crash before inserting rows during DDL_CTAS.
--    crash_before_create_select_insert
-- 3) Execute DDL_CTAS and cause crash.
-- 4) Wait for server to stop and then restart the server.
-- 5) Verify that we have just t0 and no t1 created.
-- 6) Reset the debug point.
--
-- TC2: Crash DDL_CTAS after table is created and INSERT is completed.
-- Repeat steps from TC1 with debug point crash_after_create_select_insert.
--
-- TC3: Crash DDL_CTAS during commit before flushing binlog.
-- Repeat steps from TC1 with debug point crash_commit_before_log.
--
-- TC4: Crash DDL_CTAS during commit after flushing binlog.
-- Repeat steps from TC1 with debug point crash_after_flush_binlog.
--
-- TC5: Concurrent access to table being created should be blocked.
-- 1) Execute CREATE TABLE ... START TRANSACTION;
--    - Steps 1/2 in TC5.
--    - Steps 1/2 in TC6.
-- 2) Execute the procedure.
-- 3) Verify that table t1 does exist.
--
-- TC9: Reject prepared statement and CREATE TABLE .. START TRANSACTION.
-- 1) Test that we get ER_UNSUPPORTED_PS if CREATE TABLE ... START
--    TRANSACTION is executed using PREPARE command.
--
-- TC10: Reject CREATE TABLE .. START TRANSACTION with non-atomic engine.
-- 1) Test that we get ER_NOT_ALLOWED_WITH_START_TRANSACTION if CREATE
--    TABLE ... START TRANSACTION is executed using SE does not support
--    atomic DDL.
--
-- TC11: Reject DML, DDL and other commands except for COMMIT, ROLLBACK after
--      CREATE TABLE ... START TRANSACTION.
-- 1) Execute CREATE TABLE ... START TRANSACTION;
--    ER_STATEMENT_NOT_ALLOWED_AFTER_START_TRANSACTION
-- 3) Execute UPDATE and see we get
--    ER_STATEMENT_NOT_ALLOWED_AFTER_START_TRANSACTION
-- 4) Execute SET and see we get
--    ER_STATEMENT_NOT_ALLOWED_AFTER_START_TRANSACTION
--
-- TC12: Reject ALTER TABLE with START TRANSACTION.
--
-- TC13: Reject CREATE TEMPORARY TABLE with START TRANSACTION.
--
-- TC14: Reject CREATE TABLE ... AS SELECT with START TRANSACTION.
--
-- ==== References ====
--
-- WL#13355 Make CREATE TABLE...SELECT atomic and crash-safe
--

--source include/have_debug.inc
--source include/not_valgrind.inc
--source include/have_log_bin.inc

-- Skip ps protocol because CREATE TABLE ... START TRANSACTION is not
-- allowed to be run with ps protocol.
--source include/no_ps_protocol.inc

CREATE TABLE t0 (f1 INT PRIMARY KEY);
INSERT INTO t0 VALUES (1),(2),(3),(4);
SET global DEBUG='+d, crash_before_create_select_insert';
CREATE TABLE t1 AS SELECT * FROM t0;
let $WAIT_COUNT=6000;
let $assert_cond= [SELECT count(table_name) COUNT FROM
  INFORMATION_SCHEMA.TABLES WHERE table_schema = \'test\', COUNT, 1] = 1;

SET global DEBUG='-d, crash_before_create_select_insert';
SET global DEBUG='+d, crash_after_create_select_insert';
CREATE TABLE t1 AS SELECT * FROM t0;
let $WAIT_COUNT=6000;

SET global DEBUG='-d, crash_after_create_select_insert';
SET global DEBUG='+d, crash_commit_before_log';
CREATE TABLE t1 AS SELECT * FROM t0;
let $WAIT_COUNT=6000;
let $assert_cond= [SELECT count(table_name) COUNT FROM
  INFORMATION_SCHEMA.TABLES WHERE table_schema = \'test\', COUNT, 1] = 1;

SET global DEBUG='-d, crash_commit_before_log';
SET global DEBUG='+d, crash_after_flush_binlog';
CREATE TABLE t1 AS SELECT * FROM t0;
let $WAIT_COUNT=6000;

SET global DEBUG='-d, crash_after_flush_binlog';
DROP TABLE t1;
SET DEBUG_SYNC='ha_commit_trans_before_acquire_commit_lock SIGNAL cond1 WAIT_FOR cond2';
SET DEBUG_SYNC='now WAIT_FOR cond1';
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "SELECT * FROM t1";
SET DEBUG_SYNC='now SIGNAL cond2';

SET DEBUG_SYNC=RESET;
DROP TABLE t0, t1;
CREATE TABLE t1 (f1 INT) START TRANSACTION;
CREATE TABLE t1 (f1 INT) START TRANSACTION;

DROP TABLE t1;
CREATE PROCEDURE proc1()
BEGIN
  CREATE TABLE t1 (f1 INT) START TRANSACTION;
  CREATE TABLE t1 (f1 INT) START TRANSACTION;
DROP TABLE t1;
DROP PROCEDURE proc1;
CREATE TABLE t1 (f1 INT) ENGINE=MyiSAM START TRANSACTION;
CREATE TABLE t1 (f1 INT) START TRANSACTION;
INSERT INTO t1 VALUES (1);
UPDATE t1 SET f1=932;
CREATE TABLE t2 (f2 INT);
SET sql_mode = default;
CREATE TABLE t1 (f1 INT);
ALTER TABLE t2 ADD f2 INT, START TRANSACTION;
DROP TABLE t1;
CREATE TEMPORARY TABLE t1 (f1 INT) START TRANSACTION;
CREATE TABLE t1 START TRANSACTION as SELECT * FROM t0;
