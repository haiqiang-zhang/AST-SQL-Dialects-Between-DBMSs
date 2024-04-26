--         Test cases to verify MDL on check constraints.                       #
--###############################################################################

--enable_connect_log

--echo --------------------------------------------------------------------------
--echo -- Test case to verify MDL locking on check constraints with same names
--echo -- in the concurrent CREATE TABLE statements.
--echo --------------------------------------------------------------------------
SET DEBUG_SYNC="after_acquiring_lock_on_check_constraints SIGNAL cc_locked WAIT_FOR continue";
SET DEBUG_SYNC="now WAIT_FOR cc_locked";
let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for check constraint metadata lock" AND
        info  = "CREATE TABLE t2 (f1 INT, f2 INT, CONSTRAINT t1_ck CHECK(f2 < 10))";
SET DEBUG_SYNC="now SIGNAL continue";
SET DEBUG_SYNC="after_acquiring_lock_on_check_constraints_for_rename SIGNAL cc_locked WAIT_FOR continue";
SET DEBUG_SYNC="now WAIT_FOR cc_locked";
let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for check constraint metadata lock" AND
        info  = "CREATE TABLE t3 (f1 INT, CONSTRAINT t1_chk_1 CHECK (f1 < 10))";
SET DEBUG_SYNC="now SIGNAL continue";
DROP TABLE t3;
SET DEBUG_SYNC="after_acquiring_lock_on_check_constraints_for_rename SIGNAL cc_locked WAIT_FOR continue";
SET DEBUG_SYNC="now WAIT_FOR cc_locked";
let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for check constraint metadata lock" AND
        info  = "CREATE TABLE t3 (f1 INT, CONSTRAINT t1_chk_1 CHECK (f1 < 10))";
SET DEBUG_SYNC="now SIGNAL continue";
SET DEBUG_SYNC="after_acquiring_lock_on_check_constraints_for_rename SIGNAL cc_locked WAIT_FOR continue";
SET DEBUG_SYNC="now WAIT_FOR cc_locked";
let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for check constraint metadata lock" AND
        info  = "CREATE TABLE t2 (f1 INT, CONSTRAINT t1_chk_1 CHECK (f1 < 10))";
SET DEBUG_SYNC="now SIGNAL continue";
DROP TABLE t2;
SET DEBUG_SYNC="after_acquiring_lock_on_check_constraints_for_rename SIGNAL cc_locked WAIT_FOR continue";
SET DEBUG_SYNC="now WAIT_FOR cc_locked";
let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for check constraint metadata lock" AND
        info  = "CREATE TABLE t2 (f1 INT, CONSTRAINT t1_chk_1 CHECK (f1 < 10))";
SET DEBUG_SYNC="now SIGNAL continue";
SET @binlog_format_saved = @@binlog_format;
SET binlog_format = 'STATEMENT';
CREATE TABLE t2 (f1 INT, f2 INT, f3 INT CONSTRAINT f3_ck CHECK(f3 < 10));
INSERT INTO t2 VALUES (5, 5, 5);
SELECT * FROM t2;
SET DEBUG_SYNC="skip_check_constraints_on_unaffected_columns SIGNAL check_proc_state WAIT_FOR continue";
SET DEBUG_SYNC="now WAIT_FOR check_proc_state";
let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
                      WHERE info = "UPDATE t2 SET f2 = 10 WHERE f1 = 5" AND
                            state LIKE '%skip_check_constraints_on_unaffected_columns%';
SET DEBUG_SYNC="now SIGNAL continue";
SELECT * FROM t2;
SET binlog_format=@binlog_format_saved;
SET DEBUG_SYNC='RESET';
DROP TABLE t1, t2;

-- Without fix, following statements crash in debug mode.
CREATE TABLE t1 (c1 INT, c2 INT CHECK (c2 < 100));
ALTER TABLE t1 DROP COLUMN c2;
DROP TABLE t1;
SET SESSION debug= '-d,info:-O';
