drop database if exists events_test;
create database events_test;
create table execution_log(name char(10));
create event abc1 on schedule every 1 second do
  insert into execution_log value('abc1');
create event abc2 on schedule every 1 second do
  insert into execution_log value('abc2');
create event abc3 on schedule every 1 second do 
  insert into execution_log value('abc3');
select @@event_scheduler;
drop table execution_log;
drop database events_test;
select count(*) = 0 from information_schema.processlist
  where db='events_test' and command = 'Connect' and user=current_user();
SELECT @@event_scheduler;
DROP EVENT IF EXISTS e1;
CREATE EVENT e1 ON SCHEDULE EVERY 1 SECOND DISABLE DO SELECT 1;
SELECT @@event_scheduler;
DROP EVENT e1;
