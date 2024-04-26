
-- While log_backtrace.test does not require have_debug and works
-- with stacktraces we prepared earlier, in this test, we actually
-- synthesize a crash and then look at the stacktrace afterwards.
-- (Mostly we show that it exists through being able to read the
-- timestamp/signal-preamble. Anything beyond that is somewhat
-- platform-dependent.)

--source include/not_valgrind.inc
--source include/not_crashrep.inc
--source include/not_windows.inc

-- Only debug-build has self-crash option.
--source include/have_debug.inc

-- Let's have performance_schema.error_log to ourselves.
--source include/not_parallel.inc

-- Error-log to this file:
--let LOG_FILE1= $MYSQLTEST_VARDIR/tmp/wl14955_debug.err

--echo --
--echo -- Take down server started by mtr.
--let $_server_id= `SELECT @@server_id`
--let $_expect_file_name= $MYSQLTEST_VARDIR/tmp/mysqld.$_server_id.expect
--exec echo "wait" > $_expect_file_name
--shutdown_server

--echo --
--echo -- Start our own server. Log to LOG_FILE1.
--exec_in_background $MYSQLD_CMD --port $MASTER_MYPORT --log-error=$LOG_FILE1 --log-timestamps=UTC --log-error-verbosity=1

--enable_reconnect
--echo --
--echo -- Connect to our own server.
--let $wait_counter=3000
--source include/wait_until_connected_again.inc
--disable_reconnect

--echo --
--echo -- Log a header.
--echo -- If the header is present, but the stackdump is not, the stackdump
--echo -- failed. If the header is not present, we have bigger issues.
SET @@session.debug="+d,parser_stmt_to_error_log_with_system_prio";
SELECT "--- STACKTRACE TO FOLLOW ---";
SET @@session.debug="-d,parser_stmt_to_error_log_with_system_prio";
SET @@session.debug='d,crash_now';

-- Find error-number for the error symbol ER_STACK_BACKTRACE we'll be using
-- (and normalize to symbol in .result file).
--let $err_code= convert_error(ER_STACK_BACKTRACE)
--replace_regex /=.*/=ER_STACK_BACKTRACE/
--eval SET @err_code=CONCAT("MY-",LPAD($err_code,6,"0"));
SELECT data
  FROM performance_schema.error_log
 WHERE data LIKE "%--- STACKTRACE TO FOLLOW ---%";

-- SELECT ">", data FROM performance_schema.error_log WHERE error_code=@err_code;
SELECT COUNT(*)
  FROM performance_schema.error_log
 WHERE error_code=@err_code
   AND data LIKE "% UTC - mysqld got %";
