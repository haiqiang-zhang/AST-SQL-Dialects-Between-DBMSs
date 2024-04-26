--

--source include/have_debug_sync.inc

--source include/force_myisam_default.inc
--source include/have_myisam.inc

--echo --
--echo -- Bug#24571427 MYSQLDUMP & MYSQLPUMP MAY FAIL WHEN
--echo --              DDL STATEMENTS ARE RUNNING
--echo --

--disable_warnings
SET DEBUG_SYNC= 'RESET';
DROP SCHEMA IF EXISTS test_i_s;

CREATE SCHEMA test_i_s;
USE test_i_s;
CREATE TABLE t1(a INT) ENGINE=MyISAM;
SET DEBUG_SYNC='alter_table_before_rename_result_table SIGNAL blocked WAIT_FOR i_s_select';
SET DEBUG_SYNC= 'now WAIT_FOR blocked';
SELECT COUNT(TABLE_NAME) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='test_i_s' AND TABLE_NAME like '--sql%';
SET DEBUG_SYNC= 'now SIGNAL i_s_select';
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='test_i_s';
ALTER TABLE t1 add column (c2 int);
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='test_i_s';
SET DEBUG_SYNC= 'RESET';
SET GLOBAL DEBUG='';
DROP SCHEMA test_i_s;
