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
