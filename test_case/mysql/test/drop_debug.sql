-- 
-- DROP-related tests which execution requires debug server.
--
--source include/have_debug.inc

-- Valgrind would complain about memory leaks when we crash on purpose.
--source include/not_valgrind.inc
-- Avoid CrashReporter popup on Mac
--source include/not_crashrep.inc

--echo --
--echo -- Bug#21625393 : Assert condition (e->usage() == 1) failure in
--echo --                dd::cache::Shared_multi_map<T>::remove()
--echo --

--enable_connect_log

--echo --
--echo -- Create MyISAM table, and drop it, but make drop fail
--echo -- before the object is deleted from the dd tables. Now,
--echo -- the object exists in the global data dictionary, but
--echo -- not in the SE.

CREATE TABLE t1 (i INT) ENGINE=MyISAM;
SET SESSION DEBUG='+d,fail_while_dropping_dd_object';
DROP TABLE t1;
SET SESSION DEBUG='-d,fail_while_dropping_dd_object';
DROP TABLE IF EXISTS t1;
CREATE TABLE t_m (t_m INT) ENGINE=MyISAM;
CREATE TABLE t_i (t_i INT) ENGINE=InnoDB;
CREATE TEMPORARY TABLE tt_m (tt_m INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tt_i (tt_i INT) ENGINE=InnoDB;
DROP TABLES t_m, t_i, tt_m, tt_i, t_no_such_table, t_no_such_table_either;
SELECT * FROM t_m, t_i, tt_m, tt_i;
DROP TEMPORARY TABLES tt_m, tt_i, tt_no_such_table, tt_no_such_table_either;
SELECT * FROM tt_m, tt_i;
DROP TABLES IF EXISTS t_m, t_i, tt_m, tt_i, t_no_such_table, t_no_such_table_either;
SELECT * FROM t_m;
SELECT * FROM t_i;
CREATE TEMPORARY TABLE tt_m (tt_m INT) ENGINE=MyISAM;
CREATE TEMPORARY TABLE tt_i (tt_i INT) ENGINE=InnoDB;
DROP TEMPORARY TABLES IF EXISTS tt_m, tt_i, tt_no_such_table, tt_no_such_table_either;
SELECT * FROM tt_m;
SELECT * FROM tt_i;
CREATE TABLE t_m (t_m INT) ENGINE=MyISAM;
CREATE TABLE t_i_1 (t_i_1 INT) ENGINE=InnoDB;
CREATE TABLE t_i_2 (t_i_2 INT PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE t_i_3 (t_i_3 INT, FOREIGN KEY(t_i_3) REFERENCES t_i_2(t_i_2)) ENGINE=InnoDB;
DROP TABLES t_m, t_i_1, t_i_2;
SELECT * FROM t_m;
SELECT * FROM t_i_1;
SELECT * FROM t_i_2;
SET SESSION DEBUG='+d,rm_table_no_locks_abort_after_atomic_tables';
DROP TABLES t_m, t_i_1;
SET SESSION DEBUG='-d,rm_table_no_locks_abort_after_atomic_tables';
SELECT * FROM t_m;
SELECT * FROM t_i_1;
SET SESSION DEBUG='+d,rm_table_no_locks_abort_after_atomic_tables';
DROP TABLES t_i_1, t_i_3;
SET SESSION DEBUG='-d,rm_table_no_locks_abort_after_atomic_tables';
SELECT * FROM t_i_1;
SELECT * FROM t_i_3;
DROP TABLES t_i_1, t_i_3, t_i_2;
LET $MYSQLD_DATADIR = `SELECT @@datadir`;
CREATE TABLE t1 (a INT) ENGINE=MyISAM;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
CREATE DATABASE mysqltest;
CREATE TABLE mysqltest.t_m (t_m INT) ENGINE=MyISAM;
CREATE TABLE mysqltest.t_i_1 (t_i_1 INT) ENGINE= InnoDB;
CREATE TABLE mysqltest.t_i_2 (t_i_2 INT PRIMARY KEY) ENGINE= InnoDB;
CREATE FUNCTION mysqltest.f1() RETURNS INT RETURN 0;
CREATE TABLE t1 (fk INT,
                 FOREIGN KEY (fk) REFERENCES mysqltest.t_i_2(t_i_2))
                 ENGINE=InnoDB;
DROP DATABASE mysqltest;
SELECT * FROM mysqltest.t_m;
SELECT * FROM mysqltest.t_i_1;
SELECT * FROM mysqltest.t_i_2;
SELECT mysqltest.f1();
DROP TABLE t1;
SET SESSION DEBUG='+d,rm_db_fail_after_dropping_tables';
DROP DATABASE mysqltest;
SET SESSION DEBUG='-d,rm_db_fail_after_dropping_tables';
SELECT * FROM mysqltest.t_m;
SELECT * FROM mysqltest.t_i_1;
SELECT * FROM mysqltest.t_i_2;
SELECT mysqltest.f1();
SET SESSION DEBUG='+d,rm_db_fail_after_dropping_tables';
DROP DATABASE mysqltest;
SET SESSION DEBUG='-d,rm_db_fail_after_dropping_tables';
SELECT * FROM mysqltest.t_i_1;
SELECT * FROM mysqltest.t_i_2;
SELECT mysqltest.f1();
CREATE TABLE mysqltest.t_m (t_m INT) ENGINE=MyISAM;
SET SESSION DEBUG='+d,fail_drop_db_routines';
DROP DATABASE mysqltest;
SET SESSION DEBUG='-d,fail_drop_db_routines';
SELECT * FROM mysqltest.t_m;
SELECT * FROM mysqltest.t_i_1;
SELECT * FROM mysqltest.t_i_2;
SELECT mysqltest.f1();

DROP DATABASE mysqltest;

CREATE DATABASE mysqltest;
CREATE TABLE mysqltest.t1 (i INT) ENGINE=MYISAM;
SET DEBUG='+d,crash_copy_before_commit';
ALTER TABLE mysqltest.t1 ADD COLUMN j INT;
let $MYSQLD_DATADIR= `SELECT @@global.datadir`;
DROP DATABASE mysqltest;

CREATE TABLE t(i INT);
SET debug = '+d,simulate_failure_in_before_commit_hook';
{
  -- Before the patch, this would fail with an assert due to an inconsistency
  -- between the state of the DD cache and the contents of the DD tables.
  --error ER_RUN_HOOK_ERROR
  DROP TABLE t;

SET debug = '-d,simulate_failure_in_before_commit_hook';
DROP TABLE t;
