
CREATE TABLE t1(i int);
SET SESSION debug="+d,abort_rename_after_update";

SET SESSION debug="-d,abort_rename_after_update";

SELECT * FROM t1;

DROP TABLE t1;
SET @old_lock_wait_timeout= @@lock_wait_timeout;
SET @old_lock_wait_timeout= @@lock_wait_timeout;
CREATE TABLE t1 (i INT);
CREATE TABLE t2 (j INT);
SELECT * FROM t1;
SET DEBUG_SYNC='open_tables_after_open_and_process_table SIGNAL opened WAIT_FOR go';
SET DEBUG_SYNC='now WAIT_FOR opened';
SET @@lock_wait_timeout= 1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SET @@lock_wait_timeout= 1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SET @@lock_wait_timeout= 1;
SET DEBUG_SYNC='now SIGNAL go';
SET DEBUG_SYNC='RESET';
DROP TABLES t1, t2;
CREATE TABLE t1 (i INT);
CREATE TABLE t2 (j INT);
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM t2;
SET DEBUG_SYNC='open_tables_after_open_and_process_table SIGNAL opened WAIT_FOR go';
SET DEBUG_SYNC='now WAIT_FOR opened';
SET @@lock_wait_timeout= 1;
SET @@lock_wait_timeout= @old_lock_wait_timeout;
SET DEBUG_SYNC='now SIGNAL go';
SET DEBUG_SYNC='RESET';
DROP VIEW v1;
DROP VIEW v2;
DROP TABLES t1, t2;
