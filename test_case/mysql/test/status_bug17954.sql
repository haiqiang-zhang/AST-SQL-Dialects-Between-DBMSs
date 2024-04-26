
-- This test requires that --log-output includes 'table', and the general
-- log is on

-- thread pool causes different results
-- source include/not_threadpool.inc

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

-- Disable concurrent inserts to avoid sporadic test failures as it might
-- affect the the value of variables used throughout the test case.
set @old_concurrent_insert= @@global.concurrent_insert;
set @@global.concurrent_insert= 0;

-- Disable logging to table, since this will also cause table locking and unlocking, which will
-- show up in SHOW STATUS and may cause sporadic failures

SET @old_log_output = @@global.log_output;
SET GLOBAL LOG_OUTPUT = 'FILE';

-- PS causes different statistics
--disable_ps_protocol

flush status;

--
-- Bug#17954 Threads_connected > Threads_created
--

CREATE VIEW v1 AS SELECT VARIABLE_NAME AS NAME, CONVERT(VARIABLE_VALUE, UNSIGNED) AS VALUE FROM performance_schema.global_status;

SELECT VALUE INTO @tc FROM v1 WHERE NAME = 'Threads_connected';
SELECT NAME FROM v1 WHERE NAME = 'Threads_created' AND VALUE < @tc;

DROP VIEW v1;

-- Restore global concurrent_insert value. Keep in the end of the test file.
--connection default
set @@global.concurrent_insert= @old_concurrent_insert;
SET GLOBAL log_output = @old_log_output;
