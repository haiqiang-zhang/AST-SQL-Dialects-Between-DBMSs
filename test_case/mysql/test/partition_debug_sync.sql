--

-- Skipping the test when log-bin is enabled and binlog_format != ROW, due to
-- Bug#22689960.
--source include/not_binlog_format_statement.inc
--source include/not_binlog_format_mixed.inc

--source include/have_debug_sync.inc
--source include/have_debug.inc

--disable_warnings
DROP TABLE IF EXISTS t1, t2;
SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'RESET';
CREATE TABLE t1
(a INTEGER,
 b INTEGER NOT NULL,
 KEY (b))
/*!50100  PARTITION BY RANGE (a)
(PARTITION p0 VALUES LESS THAN (2),
 PARTITION p1 VALUES LESS THAN (20),
 PARTITION p2 VALUES LESS THAN (100),
 PARTITION p3 VALUES LESS THAN MAXVALUE ) */;
SET SESSION debug= "+d,sleep_before_create_table_no_lock";
SET DEBUG_SYNC= 'alter_table_before_create_table_no_lock SIGNAL removing_partitioning WAIT_FOR waiting_for_alter';
SET DEBUG_SYNC= 'mdl_acquire_lock_wait SIGNAL waiting_for_upgrade';
SET DEBUG_SYNC= 'now WAIT_FOR removing_partitioning';
SET DEBUG_SYNC= 'mdl_acquire_lock_wait SIGNAL waiting_for_alter';
SET DEBUG_SYNC= 'rm_table_no_locks_before_delete_table WAIT_FOR waiting_for_upgrade';
DROP TABLE IF EXISTS t1;
SET SESSION debug= "-d,sleep_before_create_table_no_lock";
SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'RESET';
CREATE TABLE t2
(a INTEGER,
 b INTEGER NOT NULL,
 KEY (b))
/*!50100  PARTITION BY RANGE (a)
(PARTITION p0 VALUES LESS THAN (2),
 PARTITION p1 VALUES LESS THAN (20),
 PARTITION p2 VALUES LESS THAN (100),
 PARTITION p3 VALUES LESS THAN MAXVALUE ) */;
SET DEBUG_SYNC= 'alter_table_before_open_tables SIGNAL removing_partitions WAIT_FOR waiting_for_alter';
SET DEBUG_SYNC= 'alter_table_before_rename_result_table WAIT_FOR delete_done';
SET SESSION debug= "+d,sleep_before_no_locks_delete_table";
SET DEBUG_SYNC= 'now WAIT_FOR removing_partitions';
SET DEBUG_SYNC= 'rm_table_no_locks_before_delete_table SIGNAL waiting_for_alter';
SET DEBUG_SYNC= 'rm_table_no_locks_before_binlog SIGNAL delete_done';
DROP TABLE IF EXISTS t2;
SET SESSION debug= "-d,sleep_before_no_locks_delete_table";
SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'RESET';
CREATE TABLE t1 (a SERIAL) ENGINE = InnoDB
PARTITION BY KEY ALGORITHM = 1 () PARTITIONS 3;
INSERT INTO t1 VALUES (10);
SET DEBUG_SYNC="release_auto_increment SIGNAL auto_inc_held WAIT_FOR release";
SET DEBUG_SYNC="now WAIT_FOR auto_inc_held";
INSERT INTO t1 VALUES (5);
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
SET DEBUG_SYNC="now SIGNAL release";
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
INSERT INTO t1 VALUES (10);
SET DEBUG_SYNC="release_auto_increment SIGNAL auto_inc_held WAIT_FOR release";
SET DEBUG_SYNC="now WAIT_FOR auto_inc_held";
INSERT INTO t1 VALUES (NULL);
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
SET DEBUG_SYNC="now SIGNAL release";
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
CREATE TABLE t2 (a INT);
INSERT INTO t1 VALUES (10);
INSERT INTO t2 VALUES (3), (NULL), (4);
SET DEBUG_SYNC="release_auto_increment SIGNAL auto_inc_held WAIT_FOR release";
SET DEBUG_SYNC="now WAIT_FOR auto_inc_held";
INSERT INTO t1 VALUES (5);
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
SET DEBUG_SYNC="now SIGNAL release";
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
INSERT INTO t1 VALUES (10);
SET DEBUG_SYNC="release_auto_increment SIGNAL auto_inc_held WAIT_FOR release";
SET DEBUG_SYNC="now WAIT_FOR auto_inc_held";
INSERT INTO t1 VALUES (NULL);
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
SET DEBUG_SYNC="now SIGNAL release";
SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 't1';
DROP TABLE t1, t2;
