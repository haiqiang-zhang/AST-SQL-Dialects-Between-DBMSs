--

--source include/have_debug_sync.inc

--##########################################################################

--source include/count_sessions.inc

--##########################################################################

--echo --
--echo -- Bug#21966802: MAKE OPERATIONS ON DD TABLES IMMUNE TO KILL
--echo --

--enable_connect_log

--echo -- Create a new connection.
connect (con1, localhost, root,,);
CREATE TABLE t1 (pk INTEGER PRIMARY KEY);
SET DEBUG_SYNC= 'before_storing_dd_object SIGNAL before_store WAIT_FOR cont';
SET DEBUG_SYNC= 'now WAIT_FOR before_store';
SELECT ID FROM INFORMATION_SCHEMA.PROCESSLIST WHERE INFO LIKE "ALTER TABLE%" INTO @thread_id;
SET DEBUG_SYNC= 'now SIGNAL cont';
DROP TABLE t1;
SET DEBUG_SYNC= 'RESET';
