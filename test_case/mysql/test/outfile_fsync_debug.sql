
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

SET SESSION select_into_buffer_size=262144;

-- Table is used to check if exported data are the same as
-- in original table(t2).
CREATE TABLE t1 (a TEXT, b TEXT) ENGINE=INNODB;

-- Create a table and populate it with some data
CREATE TABLE t2 (a TEXT, b TEXT) ENGINE=INNODB;

-- Here we end up with 32768 rows in the table
--disable_query_log
INSERT INTO t2 (a, b) VALUES (REPEAT('a', 512), REPEAT('b', 512));
INSERT INTO t2 (a, b) VALUES (REPEAT('A', 512), REPEAT('B', 512));
let $i=14;
  INSERT INTO t2 (a, b) SELECT a, b FROM t2;
  dec $i;

-- Query1, check SELECT INTO OUTFILE, number of flushes is expected to be 129.
SET GLOBAL debug = '+d,print_select_into_flush_stats';
SET GLOBAL debug = '-d,print_select_into_flush_stats';
SET GLOBAL debug = '+d,print_select_into_flush_stats';

-- Query2, check SELECT INTO OUTFILE with delay, number of flushes is expected to be 1.
--error ER_QUERY_TIMEOUT
--eval SELECT /*+ MAX_EXECUTION_TIME(1000) SET_VAR(select_into_disk_sync_delay = 5000) SET_VAR(select_into_disk_sync = ON) */ * INTO OUTFILE "$MYSQLTEST_VARDIR/tmp/t2.txt" FROM t2;

-- Query3, check SELECT INTO DUMPFILE, number of flushes is expected to be 2.
DELETE FROM t2;
INSERT INTO t2 (a, b) VALUES (REPEAT('a', 10000), REPEAT('b', 10000));

-- Verify query2
--let $assert_select = \[select_to_file\]\[flush_count\] 001
--source include/assert_grep.inc

-- Verify query3
--let $assert_select = \[select_to_file\]\[flush_count\] 002
--source include/assert_grep.inc

-- Wait till we reached the initial number of concurrent sessions
--source include/wait_until_count_sessions.inc

SET GLOBAL debug = '-d,print_select_into_flush_stats';

-- Check if system variable select_into_buffer_size, select_into_disk_sync,
-- select_into_disk_sync_delay are hint-updatable.
SELECT /*+ SET_VAR(select_into_disk_sync_delay = 5000) 
           SET_VAR(select_into_disk_sync = ON)
           SET_VAR(select_into_buffer_size = 16384) */
  @@select_into_disk_sync_delay, @@select_into_disk_sync, @@select_into_buffer_size;

SET SESSION select_into_buffer_size=default;
DROP TABLE t1, t2;
