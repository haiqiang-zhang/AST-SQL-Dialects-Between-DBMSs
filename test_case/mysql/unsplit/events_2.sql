drop database if exists events_test;
create database events_test;
create event e_26 on schedule at '2037-01-01 00:00:00' disable do set @a = 5;
select  event_definition, definer, convert_tz(execute_at, 'UTC', 'SYSTEM'), on_completion from information_schema.events;
drop event e_26;
select definer, event_name from information_schema.events;
select get_lock("test_lock1", 20);
select definer, event_name from information_schema.events;
select /*1*/ user, host, db, command, state, info
  from information_schema.processlist
  where (user='event_scheduler')
  order by info;
select release_lock("test_lock1");
select count(*) from information_schema.events;
select /*2*/ user, host, db, command, state, info
  from information_schema.processlist
  where (info like "select get_lock%" OR user='event_scheduler')
  order by info;
select /*3*/ user, host, db, command, state, info
  from information_schema.processlist
  where (info like "select get_lock%" OR user='event_scheduler')
  order by info;
select /*4*/ user, host, db, command, state, info
  from information_schema.processlist
  where (info like "select get_lock%" OR user='event_scheduler')
  order by info;
select count(*) = 0 from information_schema.processlist
  where db='events_test' and command = 'Connect' and user=current_user();
create table t_16 (s1 int);
drop table t_16;
create event white_space
on schedule every 10 hour
disable
do
select 1;
select event_schema, event_name, definer, event_definition from information_schema.events where event_name='white_space';
drop event white_space;
create event white_space on schedule every 10 hour disable do

select 2;
select event_schema, event_name, definer, event_definition from information_schema.events where event_name='white_space';
drop event white_space;
create event white_space on schedule every 10 hour disable do	select 3;
select event_schema, event_name, definer, event_definition from information_schema.events where event_name='white_space';
drop event white_space;
create event e1 on schedule every 1 year do set @a = 5;
create table t1 (s1 int);
drop table t1;
drop event e1;
create table t1 (a int);
create event e1 on schedule every 10 hour do select 1;
lock table t1 read;
select event_name from information_schema.events;
unlock tables;
drop event e1;
select event_name from information_schema.events;
create event e1 on schedule every 10 hour do select 1;
select EVENT_NAME from information_schema.events
where event_schema='test';
create event event_35981 on schedule every 6 month on completion preserve
disable
do
  select 1;
alter   event event_35981 enable;
alter   event event_35981 on completion not preserve;
alter   event event_35981 disable;
alter   event event_35981 on completion preserve;
drop event event_35981;
create event event_35981 on schedule every 6 month disable
do
  select 1;
drop event event_35981;
create event event_35981 on schedule every 1 hour starts current_timestamp
  on completion not preserve
do
  select 1;
drop event event_35981;
create event event_35981 on schedule every 1 hour starts current_timestamp
  on completion not preserve
do
  select 1;
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'
  ends '1999-01-02 00:00:00' on completion preserve;
drop event event_35981;
create event event_35981 on schedule every 1 hour starts current_timestamp
  on completion preserve
do
  select 1;
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'
  ends '1999-01-02 00:00:00';
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'
  ends '1999-01-02 00:00:00' on completion preserve;
drop event event_35981;
select count(*) = 0 from information_schema.processlist
  where db='events_test' and command = 'Connect' and user=current_user();
drop database events_test;
