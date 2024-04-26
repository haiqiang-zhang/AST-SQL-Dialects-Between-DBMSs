
-- ==== Purpose ====
--
-- Verify that a partially failed statement can consume
-- its gtid and save the gtid into @@GLOBAL.GTID_EXECUTED
-- and mysql.gtid_executed table when binlog is disabled
-- if it did the same when binlog is enabled.
--
-- Also provides coverage for changes to GTID handling for failed
-- DROP TABLES, which were implemented as part of WL#7743 "New data
-- dictionary: changes to DDL-related parts of SE API".
--
-- ==== Implementation ====
--
-- 1) SET SESSION GTID_NEXT='UUID:GNO'.
-- 2) Execute a partially failed statement.
-- 3) Verify that the partially failed statement can consume
--    its gtid and save the gtid into @@GLOBAL.GTID_EXECUTED
--    and mysql.gtid_executed table when binlog is disabled
--    if it did the same when binlog is enabled.
-- 4) Execute above three steps for all different types of statements
--
-- ==== References ====
--
-- Bug#21686749  PARTIALLY FAILED DROP OR ACL STMT FAILS TO CONSUME GTID ON BINLOGLESS SLAVE
-- See mysql-test/suite/binlog/t/binlog_gtid_next_partially_failed_stmts.test
-- See mysql-test/suite/binlog/t/binlog_gtid_next_partially_failed_grant.test
-- See mysql-test/t/no_binlog_gtid_next_partially_failed_stmts_error.test
--

-- The test involves MyISAM sorage engine
--source include/force_myisam_default.inc
--source include/have_myisam.inc

-- Should be tested against "binlog disabled" server
--source include/not_log_bin.inc
-- Requires debug server to simulate failure to drop table in SE
--source include/have_debug.inc

-- Make sure the test is repeatable
RESET BINARY LOGS AND GTIDS;
CREATE TABLE t1 (a int) ENGINE=MyISAM;
CREATE TABLE t5 (a int) ENGINE=InnoDB;

-- Check-1: DROP TABLE

--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:3'
--echo --
--echo -- Original test case.
--echo --
--echo -- The below DROP TABLE has partially failed before WL#7743.
--echo -- Now if fails without side-effects and thus should not consume gitd.
--echo --
--error ER_BAD_TABLE_ERROR
DROP TABLE t1, t3;
SET @@debug="+d,rm_table_no_locks_abort_before_atomic_tables";
DROP TABLE t1, t5;
SET @@debug="-d,rm_table_no_locks_abort_before_atomic_tables";
CREATE TEMPORARY TABLE tmp1 (a int);

-- Check-2: DROP TEMPORARY TABLE
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:5'
--echo --
--echo -- The below DROP TEMPORARY TABLE has partially failed before WL#7743.
--echo -- Now if fails without side-effects and thus should not consume gitd.
--echo --
--echo -- There is no way for DROP TEMPORARY TABLE to partially fail now,
--echo -- so unlike for DROP TABLE, there is no way to test scenario with
--echo -- partial failure for it.
--error ER_BAD_TABLE_ERROR
DROP TEMPORARY TABLE tmp1, t2;
CREATE TABLE t1(a INT, b INT);
CREATE USER u1@h;
SELECT user FROM mysql.user where user='u1';

-- Check-3: GRANT a non-available privilege
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:7'
--error ER_BAD_FIELD_ERROR
GRANT SELECT(a), SELECT(c) ON t1 TO u1@h;
SELECT user, column_name, column_priv FROM mysql.columns_priv;

-- Check-4: GRANT a privilege to a non-existent user
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:7'
--error ER_CANT_CREATE_USER_WITH_GRANT
GRANT SELECT(a) ON t1 TO u1@h, u2@h;
SELECT user, column_name, column_priv FROM mysql.columns_priv;

-- Check-5: REVOKE
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:7'
--error ER_NONEXISTING_TABLE_GRANT
REVOKE SELECT(a), SELECT(b) ON t1 FROM u1@h;
SELECT user, column_name, column_priv FROM mysql.columns_priv;

-- Check-6: DROP USER
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:7'
--error ER_CANNOT_USER
DROP USER u1@h, u2@h;
SELECT user FROM mysql.user where user='u1';

-- Check-7: RENAME TABLE
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:7'
--error ER_NO_SUCH_TABLE
RENAME TABLE t1 TO t2, t3 TO t4;

-- Check-8: OPTIMIZE TABLE
--echo --
--echo -- The OPTIMIZE TABLE statement can be failed partially when optimizing
--echo -- multiple tables, which contain a non-existent table.
--echo --
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:7'
OPTIMIZE TABLE t1, t_non_existent;

-- Check-9: ANALYZE TABLE
--echo --
--echo -- The ANALYZE TABLE statement can be failed partially when analyzingu
--echo -- multiple tables, which contain a non-existent table.
--echo --
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:8'
ANALYZE TABLE t1, t_non_existent;

-- Check-10: REPAIR TABLE
--echo --
--echo -- The REPAIR TABLE statement can be failed partially when repairing
--echo -- multiple tables, which contain a non-existent table.
--echo --
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:9'
REPAIR TABLE t1, t_non_existent;

-- Check-11: CHECKSUM TABLE
--echo --
--echo -- The CHECKSUM TABLE statement can be failed partially when checksuming
--echo -- multiple tables, which contain a non-existent table.
--echo --
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:10'
CHECKSUM TABLE t1, t_non_existent;

-- Check-12: RENAME USER
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:11'
--error ER_CANNOT_USER
RENAME USER u1@h TO u11@h, u3@h TO u33@h;
SELECT user FROM mysql.user where user='u1';

-- Check-14: ALTER USER
SELECT password_expired FROM mysql.user where user='u1';
ALTER USER u1@h, u3@h PASSWORD EXPIRE;
SELECT password_expired FROM mysql.user where user='u1';

-- Clean up
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:14'
DROP TABLE t1;
DROP TABLE t5;
DROP USER u1@h;
