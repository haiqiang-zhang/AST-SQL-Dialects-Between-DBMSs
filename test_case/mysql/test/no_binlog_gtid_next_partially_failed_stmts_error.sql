--    executing a partially failed statement.
-- 3) When binlog is disabled, verify that a partially failed
--    statement do not commit its gtid into both
--    @@GLOBAL.GTID_EXECUTED and mysql.GTID_EXECUTED table if
--    it encounters an error when saving its gtid into
--    mysql.GTID_EXECUTED table.
-- 4) Execute above three steps for all different types of statements
--
-- ==== References ====
--
-- Bug#21686749  PARTIALLY FAILED DROP OR ACL STMT FAILS TO CONSUME GTID ON BINLOGLESS SLAVE
-- See mysql-test/suite/binlog/t/binlog_gtid_next_partially_failed_stmts.test
-- See mysql-test/suite/binlog/t/binlog_gtid_next_partially_failed_grant.test
-- See mysql-test/t/no_binlog_gtid_next_partially_failed_stmts.test
-- See mysql-test/t/no_binlog_gtid_next_partially_failed_stmts_anonymous.test
--

-- Test needs MyISAM storage engine
--source include/force_myisam_default.inc
--source include/have_myisam.inc
-- Restrict the test runs to only debug builds, since we set DEBUG point in the test.
--source include/have_debug.inc
-- Should be tested against "binlog disabled" server
--source include/not_log_bin.inc

-- Make sure the test is repeatable
RESET BINARY LOGS AND GTIDS;
CREATE TABLE t1 (a int) ENGINE=MyISAM;
CREATE TABLE t2 (a int) ENGINE=InnoDB;

-- Check-1: DROP TABLE
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:3'
--echo --
--echo -- Execute a partially failed DROP TABLE statement.
--echo --
SET SESSION debug="+d,simulate_err_on_write_gtid_into_table";
SET SESSION debug="+d,rm_table_no_locks_abort_before_atomic_tables";
DROP TABLE t1, t2;
SET SESSION debug="-d,rm_table_no_locks_abort_before_atomic_tables";
SET SESSION debug="-d,simulate_err_on_write_gtid_into_table";
CREATE USER u1@h;

-- Check-2: DROP USER
SET SESSION debug="+d,simulate_err_on_write_gtid_into_table";
DROP USER u1@h, u2@h;
SET SESSION debug="-d,simulate_err_on_write_gtid_into_table";

-- Cleanup
--replace_result $master_uuid MASTER_UUID
--eval SET SESSION GTID_NEXT='$master_uuid:5'
DROP USER u1@h;
DROP TABLE t2;
