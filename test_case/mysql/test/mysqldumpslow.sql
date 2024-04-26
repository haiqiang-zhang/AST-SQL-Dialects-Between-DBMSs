--                DATETIME FORMAT CHANGE
--
--source include/not_windows.inc

-- Disabling the ps-protocol for the test, as enabling it will
-- give result content mismatch due to logging of some additional
-- statements in the slow-query-log.
--disable_ps_protocol

-- Save the old values of these variables to be restored at the end
SET @old_log_output=          @@global.log_output;
SET @old_slow_query_log=      @@global.slow_query_log;
SET @old_slow_query_log_file= @@global.slow_query_log_file;

-- Enable the logging of queries to slow-query-log.
-- For testing purpose, let's log all the queries.
--replace_result $MYSQLTEST_VARDIR ...
eval SET GLOBAL slow_query_log_file= '$MYSQLTEST_VARDIR/log/slow_query_temp.log';
SET GLOBAL log_output=       'FILE';
SET GLOBAL slow_query_log=   'ON';
SET SESSION long_query_time=  0;

-- Populating the slow-query-log with more than one identical queries.
let $1= 5;
 dec $1;

let $2= 4;
 SELECT 1;
 dec $2;

-- Run mysqldumpslow
--echo "Running mysqldumpslow on the slow-query-log"
-- Masking out the non-deterministic parameters from the results.
--replace_regex /Time.*\n//
--exec $MYSQLDUMPSLOW '$MYSQLTEST_VARDIR/log/slow_query_temp.log' -a -s c

-- clean-up
--remove_file $MYSQLTEST_VARDIR/log/slow_query_temp.log
SET GLOBAL  log_output=         @old_log_output;
SET GLOBAL  slow_query_log=     @old_slow_query_log;
SET GLOBAL  slow_query_log_file=@old_slow_query_log_file;
