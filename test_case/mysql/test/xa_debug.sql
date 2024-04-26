
-- This file contains XA-related test cases that requires mysql server
-- built with debug.
--source include/not_valgrind.inc
--source include/have_debug.inc

-- Test requires --xa_detach_on_prepare
--let $option_name = xa_detach_on_prepare
--let $option_value = 1
--source include/only_with_option.inc

--disable_query_log
call mtr.add_suppression("Found 1 prepared XA transactions");

CREATE TABLE t1 (a INT) ENGINE=INNODB;
 
XA START 'xid1';
INSERT INTO t1 VALUES (1);
set session debug="+d,crash_after_xa_recover";

-- Write file to make mysql-test-run.pl wait for the server to stop
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

--error 2013
XA RECOVER;

-- Call script that will poll the server waiting for it to disappear
--source include/wait_until_disconnected.inc

--let $_expect_file_name= $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--source include/start_mysqld.inc

--disable_query_log
set session debug="-d,crash_after_xa_recover";

XA RECOVER;
SELECT * FROM t1;
SELECT * FROM t1;

DROP TABLE t1;

CREATE TABLE t1 (a INT) ENGINE=INNODB;
 
XA START 'xid1';
INSERT INTO t1 VALUES (1);
set session debug="+d,crash_after_xa_recover";

-- Write file to make mysql-test-run.pl wait for the server to stop
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

--error 2013
XA RECOVER;

-- Call script that will poll the server waiting for it to disappear
--source include/wait_until_disconnected.inc

--let $_expect_file_name= $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--source include/start_mysqld.inc

--disable_query_log
set session debug="-d,crash_after_xa_recover";

XA RECOVER;
SELECT * FROM t1;

DROP TABLE t1;

CREATE TABLE t1 (a INT) ENGINE=INNODB;

XA START 'xid1', 'br\'_1';
INSERT INTO t1 VALUES (1);
set session debug="+d,crash_after_xa_recover";

-- Write file to make mysql-test-run.pl wait for the server to stop
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

--error 2013
XA RECOVER;

-- Call script that will poll the server waiting for it to disappear
--source include/wait_until_disconnected.inc

--let $_expect_file_name= $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--source include/start_mysqld.inc

--disable_query_log
set session debug="-d,crash_after_xa_recover";

XA RECOVER;

DROP TABLE t1;

CREATE TABLE t1 (a INT) ENGINE=INNODB;

XA START 'xid1';
INSERT INTO t1 VALUES (1);

set session debug="+d,crash_after_xa_recover";

-- Write file to make mysql-test-run.pl wait for the server to stop
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect

--error 2013
XA RECOVER;

-- Call script that will poll the server waiting for it to disappear
--source include/wait_until_disconnected.inc

--let $_expect_file_name= $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--source include/start_mysqld.inc

set session debug="-d,crash_after_xa_recover";

XA RECOVER;

XA COMMIT 'xid1';
DROP TABLE t1;
CREATE TABLE t1 (a INT);

XA START 'xid1';
INSERT INTO t1 VALUES (1);
SET @@session.debug = '+d,simulate_xa_failure_prepare';
SET @@session.debug = '-d,simulate_xa_failure_prepare';

--
-- The following query failed before patch applied.
--

XA START 'trx_another_one';
SET SESSION xa_detach_on_prepare = OFF;
INSERT INTO t1 VALUES (1);
SET @@session.debug= '+d,simulate_xa_commit_log_failure';
SET @@session.debug= '-d,simulate_xa_commit_log_failure';
INSERT INTO t1 VALUES (2);

DROP TABLE t1;
CREATE TABLE t1 (a INT);

XA START 'xid1';
INSERT INTO t1 VALUES (1);
SET @@session.debug = '+d,simulate_xa_failure_prepare_in_engine';
SET @@session.debug = '-d,simulate_xa_failure_prepare_in_engine';

--
-- Check that subsequent XA transaction can be initiated.
--

XA START 'trx_another_one';

DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1);

set debug_sync='detached_xa_commit_after_acquire_commit_lock SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
set debug_sync='detached_xa_commit_before_acquire_xa_lock SIGNAL go';

DROP TABLE t1;

CREATE TABLE t1(i INT);
INSERT INTO t1 set i=0;
SET DEBUG_SYNC="before_accessing_xid_state SIGNAL proceed_disconnect WAIT_FOR proceed_check_xid_state";
SET DEBUG_SYNC="now WAIT_FOR proceed_disconnect";
SET DEBUG_SYNC="now SIGNAL proceed_check_xid_state";
DROP TABLE t1;

-- Uses DBUG_EVALUATE_IF to simulate errors in various functions called during
-- XA PREPARE, to verify that transaction handling works as expected.

--echo -- Test error handling in XA PREPARE.

CREATE TABLE t1(d VARCHAR(128));

XA START 'xid1';
INSERT INTO t1 VALUES ('I: The first string'), ('I: The second string');

SELECT * FROM t1;
INSERT INTO t1 VALUES ('II: The first string'), ('II: The second string');

SET DEBUG = "+d,xaprep_mdl_fail";
SET DEBUG = "-d,xaprep_mdl_fail";
SELECT * FROM t1;

XA START 'xid3';
INSERT INTO t1 VALUES ('III: The first string'), ('III: The second string');

SET DEBUG = "+d,xaprep_ha_xa_prepare_fail";
SET DEBUG = "-d,xaprep_ha_xa_prepare_fail";
SELECT * FROM t1;

XA START 'xid4';
INSERT INTO t1 VALUES ('IV: The first string'), ('IV: The second string');

SET DEBUG = "+d,xaprep_create_mdl_backup_fail";
SET DEBUG = "-d,xaprep_create_mdl_backup_fail";
SELECT * FROM t1;

XA START 'xid5';
INSERT INTO t1 VALUES ('V: The first string'), ('V: The second string');

SET DEBUG = "+d,xaprep_trans_detach_fail";
SET DEBUG = "-d,xaprep_trans_detach_fail";
SELECT * FROM t1;
DROP TABLE t1;
