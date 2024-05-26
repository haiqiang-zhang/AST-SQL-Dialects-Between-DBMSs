select 'events_logs_tests' as outside_event;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE user = 'event_scheduler' AND command = 'Daemon';
create event ev_log_general on schedule at now() on completion not preserve do select 'events_logs_test' as inside_event;
drop database events_test;
select count(*) = 0 from information_schema.processlist
  where db='events_test' and command = 'Connect' and user=current_user();
