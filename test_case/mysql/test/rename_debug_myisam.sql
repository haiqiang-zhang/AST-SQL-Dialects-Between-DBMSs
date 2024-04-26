
-- Some parts of the test require enabled binary log.
--source include/have_log_bin.inc

--echo --
--echo -- Part of test coverage for WL#9826 "Allow RENAME TABLES under
--echo -- LOCK TABLES" which needs debug build and debug_sync facility.
--echo --
--echo -- The main part of coverage for this WL resides in rename.test.
--echo -- This file only contains subtests which require debug/debug_sync
--echo -- facilities, hence their odd numbering.

--enable_connect_log
SET @old_lock_wait_timeout= @@lock_wait_timeout;
SET @old_lock_wait_timeout= @@lock_wait_timeout;
CREATE TABLE t1 (i INT) ENGINE=InnoDB;
CREATE TABLE t2 (j INT) ENGINE=InnoDB;
CREATE TABLE t0 (m INT) ENGINE=MyISAM;
SET @@debug='+d,injecting_fault_writing';
SET @@debug='-d,injecting_fault_writing';
SELECT * FROM t0;
SELECT * FROM t00;
SELECT * FROM t1;
SELECT * FROM t01;
SELECT * FROM t2;
SET @@lock_wait_timeout= 1;
SELECT * FROM t0;
SELECT * FROM t00;
SELECT * FROM t1;
SELECT * FROM t01;
SELECT * FROM t2;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLES t00, t01, t2;
CREATE TABLE t1 (i INT) ENGINE=InnoDB;
CREATE TABLE t0 (l INT) ENGINE=MyISAM;
CREATE DATABASE mysqltest;
SET @@debug='+d,injecting_fault_writing';
SET @@debug='-d,injecting_fault_writing';
SELECT * FROM t0;
SELECT * FROM mysqltest.t0;
SELECT * FROM t1;
SELECT * FROM t01;
SET @@lock_wait_timeout= 1;
SELECT * FROM t0;
SELECT * FROM mysqltest.t0;
SELECT * FROM t1;
SELECT * FROM t01;
ALTER DATABASE mysqltest CHARACTER SET latin1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
DROP TABLES t01;
DROP DATABASE mysqltest;
