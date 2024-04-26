--    to 'ANONYMOUS' after the partially failed statement
--    consumed its 'ANONYMOUS' gtid.
-- 3) Execute above three steps for all different types of statements
--
-- ==== References ====
--
-- Bug#21686749  PARTIALLY FAILED DROP OR ACL STMT FAILS TO CONSUME GTID ON BINLOGLESS SLAVE
-- See mysql-test/suite/binlog/t/binlog_gtid_next_partially_failed_stmts.test
-- See mysql-test/suite/binlog/t/binlog_gtid_next_partially_failed_grant.test
-- See mysql-test/t/no_binlog_gtid_next_partially_failed_stmts.test
-- See mysql-test/t/no_binlog_gtid_next_partially_failed_stmts_error.test
--

-- Test requires MyISAM as storage engine
--source include/force_myisam_default.inc
--source include/have_myisam.inc

-- Should be tested against "binlog disabled" server
--source include/not_log_bin.inc
-- Requires debug server to simulate failure to drop table in SE
--source include/have_debug.inc

-- Make sure the test is repeatable
RESET BINARY LOGS AND GTIDS;
SET GTID_NEXT = 'ANONYMOUS';
CREATE TABLE t1 (a int) ENGINE=MyISAM;
SET GTID_NEXT = 'ANONYMOUS';
CREATE TABLE t2 (a int) ENGINE=InnoDB;

-- Check-1: DROP TABLE
SET GTID_NEXT = 'ANONYMOUS';
SET @@debug="+d,rm_table_no_locks_abort_before_atomic_tables";
DROP TABLE t1, t2;
SET @@debug="-d,rm_table_no_locks_abort_before_atomic_tables";
SET GTID_NEXT = 'ANONYMOUS';

CREATE USER u1@h;

-- Check-2: DROP USER
SET GTID_NEXT = 'ANONYMOUS';
DROP USER u1@h, u2@h;
SET GTID_NEXT = 'ANONYMOUS';

DROP USER u1@h;
SET GTID_NEXT = 'ANONYMOUS';
DROP TABLE t2;
