set global event_scheduler=off;
drop database if exists events_test;
create database events_test;
use events_test;
create table execution_log(name char(10));

create event abc1 on schedule every 1 second do
  insert into execution_log value('abc1');
create event abc2 on schedule every 1 second do
  insert into execution_log value('abc2');
create event abc3 on schedule every 1 second do 
  insert into execution_log value('abc3');

use events_test;
select @@event_scheduler;
let $wait_condition=select count(distinct name)=3 from execution_log;
drop table execution_log;
drop database events_test;

let $wait_condition=
  select count(*) = 0 from information_schema.processlist
  where db='events_test' and command = 'Connect' and user=current_user();
SELECT @@event_scheduler;
USE test;
DROP EVENT IF EXISTS e1;
CREATE EVENT e1 ON SCHEDULE EVERY 1 SECOND DISABLE DO SELECT 1;
USE test;
SELECT @@event_scheduler;
DROP EVENT e1;
