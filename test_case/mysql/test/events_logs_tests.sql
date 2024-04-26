SET @old_log_output = @@global.log_output;
SET GLOBAL log_output="FILE,TABLE";
drop database if exists events_test;
create database if not exists events_test;
use events_test;
create procedure select_general_log()
begin
  select user_host, argument from mysql.general_log
  where argument like '%events_logs_test%';
select 'events_logs_tests' as outside_event;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE user = 'event_scheduler' AND command = 'Daemon';
create event ev_log_general on schedule at now() on completion not preserve do select 'events_logs_test' as inside_event;
set @@session.long_query_time=1;
set @@global.long_query_time=300;
create event ev_log_general on schedule at now() on completion not preserve
  do select 'events_logs_test' as inside_event, sleep(1.5);
select user_host, db, sql_text from mysql.slow_log
  where sql_text like 'select \'events_logs_test\'%';
set @@global.long_query_time=1;
create event ev_log_general on schedule at now() on completion not preserve
  do select 'events_logs_test' as inside_event, sleep(1.5);
select user_host, db, sql_text from mysql.slow_log
  where sql_text like 'select \'events_logs_test\'%';

drop database events_test;
set @@global.long_query_time=default;
set @@session.long_query_time=default;

--
-- Safety
--
let $wait_condition=
  select count(*) = 0 from information_schema.processlist
  where db='events_test' and command = 'Connect' and user=current_user();
SET GLOBAL log_output = @old_log_output;
