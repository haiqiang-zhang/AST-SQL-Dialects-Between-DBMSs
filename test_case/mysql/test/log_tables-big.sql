
-- Test sleeps for long times
--source include/big_test.inc

set @@global.log_output = 'TABLE';

--
-- Bug #27638: slow logging to CSV table inserts bad query_time and lock_time values
--
connection con1;
set session long_query_time=10;
select get_lock('bug27638', 1);
set session long_query_time=1;
select get_lock('bug27638', 2);
select if (query_time >= '00:00:01', 'OK', 'WRONG') as qt, sql_text from mysql.slow_log
       where sql_text = 'select get_lock(\'bug27638\', 2)';
select get_lock('bug27638', 60);
select if (query_time >= '00:00:59', 'OK', 'WRONG') as qt, sql_text from mysql.slow_log
       where sql_text = 'select get_lock(\'bug27638\', 60)';
select get_lock('bug27638', 101);
select if (query_time >= '00:01:40', 'OK', 'WRONG') as qt, sql_text from mysql.slow_log
       where sql_text = 'select get_lock(\'bug27638\', 101)';
select release_lock('bug27638');

set @@global.log_output=default;
