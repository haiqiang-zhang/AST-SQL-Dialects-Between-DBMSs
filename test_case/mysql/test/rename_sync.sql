--

--source include/have_debug_sync.inc

--##########################################################################

--source include/count_sessions.inc

--##########################################################################

--echo --
--echo -- Bug#21442630: FAILING TO STORE AN UPDATED DD OBJECT DOES NOT REVERT
--echo --               IN-MEMORY CHANGES
--echo --

--enable_connect_log

--echo -- Create a new connection.
connect (con1, localhost, root,,);
CREATE TABLE t1 (pk INTEGER PRIMARY KEY);
SET DEBUG_SYNC= 'before_storing_dd_object SIGNAL before_store WAIT_FOR cont';
SET DEBUG_SYNC= 'now WAIT_FOR before_store';
SELECT ID FROM INFORMATION_SCHEMA.PROCESSLIST WHERE INFO LIKE "RENAME TABLE%" INTO @thread_id;
SET DEBUG_SYNC= 'now SIGNAL cont';
DROP TABLE t2;
SET DEBUG_SYNC= 'RESET';
