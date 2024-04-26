
SET SESSION DEBUG_SYNC= 'RESET';

CREATE TABLE t1 (pk INT, PRIMARY KEY(pk));
SET SESSION sql_mode=TRADITIONAL;
SET SESSION autocommit=1;

INSERT INTO t1 VALUES(1);
SET SESSION debug_sync='write_row_replace SIGNAL go_ahead1 WAIT_FOR comes_never ';

DROP TABLE t1;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT);
INSERT INTO t1 VALUES (0);
INSERT INTO t2 VALUES (0);
DELETE FROM t1;
SET DEBUG_SYNC=
  'lock_wait_suspend_thread_enter SIGNAL blocked WAIT_FOR delete';
SET DEBUG_SYNC= 'now WAIT_FOR blocked';
SET DEBUG_SYNC= 'lock_wait_suspend_thread_enter SIGNAL delete';
DELETE FROM t2;
DROP TABLE t1,t2;
SET DEBUG_SYNC= 'RESET';
