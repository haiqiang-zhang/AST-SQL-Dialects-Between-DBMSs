
-- changes 2008-02-20 hhunger splitted events.test into events_1 and events_2
--

--disable_warnings
drop database if exists events_test;
create database events_test;
use events_test;

--
-- mysql.event intact checking end
--

create event e_26 on schedule at '2037-01-01 00:00:00' disable do set @a = 5;
select  event_definition, definer, convert_tz(execute_at, 'UTC', 'SYSTEM'), on_completion from information_schema.events;
drop event e_26;
create event e_26 on schedule at NULL disable do set @a = 5;
create event e_26 on schedule at 'definitely not a datetime' disable do set @a = 5;

set names utf8mb3;
create event задачка on schedule every 123 minute starts now() ends now() + interval 1 month do select 1;
drop event задачка;
set global event_scheduler=off;

select definer, event_name from information_schema.events;
select get_lock("test_lock1", 20);
create event закачка on schedule every 10 hour do select get_lock("test_lock1", 20);
select definer, event_name from information_schema.events;
select /*1*/ user, host, db, command, state, info
  from information_schema.processlist
  where (user='event_scheduler')
  order by info;
select release_lock("test_lock1");
drop event закачка;
select count(*) from information_schema.events;

--
--
--
--echo "ENABLE the scheduler and get a lock"
set global event_scheduler=on;
select get_lock("test_lock2", 20);
create event закачка on schedule every 10 hour do select get_lock("test_lock2", 20);
let $wait_condition= select count(*) = 2 from information_schema.processlist
  where ( (state like 'User lock%' AND info like 'select get_lock%')
       OR (command='Daemon' AND user='event_scheduler' AND
           state = 'Waiting for next activation'));

select /*2*/ user, host, db, command, state, info
  from information_schema.processlist
  where (info like "select get_lock%" OR user='event_scheduler')
  order by info;
select release_lock("test_lock2");
drop event закачка;

-- Wait for release_lock("test_lock2") to complete,
-- to avoid polluting the next test information_schema.processlist
let $wait_condition= select count(*) = 0 from information_schema.processlist
  where (state like 'User lock%' AND info like 'select get_lock%');


--#
--# 1. get a lock
--# 2. create an event
--# 3. sleep so it has time to start
--# 4. should appear in processlist
--# 5. kill the scheduler, it will wait for the child to stop
--# 6. both processes should be there on show processlist
--# 7. release the lock and sleep, both scheduler and child should end
select get_lock("test_lock2_1", 20);
create event закачка21 on schedule every 10 hour do select get_lock("test_lock2_1", 20);
let $wait_condition= select count(*) = 2 from information_schema.processlist
  where ( (state like 'User lock%' AND info like 'select get_lock%')
          OR (command='Daemon' AND user='event_scheduler' AND
              state = 'Waiting for next activation'));

select /*3*/ user, host, db, command, state, info
  from information_schema.processlist
  where (info like "select get_lock%" OR user='event_scheduler')
  order by info;

set global event_scheduler=off;

let $wait_condition= select count(*) =1 from information_schema.processlist
  where (info like "select get_lock%" OR user='event_scheduler');
select /*4*/ user, host, db, command, state, info
  from information_schema.processlist
  where (info like "select get_lock%" OR user='event_scheduler')
  order by info;
select release_lock("test_lock2_1");
drop event закачка21;
let $wait_condition=
  select count(*) = 0 from information_schema.processlist
  where db='events_test' and command = 'Connect' and user=current_user();
set global event_scheduler = ON;
create table t_16 (s1 int);
create trigger t_16_bi before insert on t_16 for each row create event  e_16 on schedule every 1 second do set @a=5;
drop table t_16;

--
-- START: BUG #17453: Creating Event crash the server
--
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
--

--
-- Bug#17403 "Events: packets out of order with show create event"
--
create event e1 on schedule every 1 year do set @a = 5;
create table t1 (s1 int);
create trigger t1_ai after insert on t1 for each row show create event e1;
drop table t1;
drop event e1;

--
-- test with very often occurring event
-- (disabled for now, locks)
--#select get_lock("test_lock4", 20);

--
-- Test wrong syntax
--

--error ER_TOO_LONG_IDENT 
SHOW EVENTS FROM aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa;
create table t1 (a int);
create event e1 on schedule every 10 hour do select 1;
select event_name from information_schema.events;
create event e2 on schedule every 10 hour do select 1;
alter event e2 disable;
alter event e2 rename to e3;
drop event e2;
drop event e1;
drop event e1;
select event_name from information_schema.events;
create event e1 on schedule every 10 hour do select 1;
create function f1() returns int
begin
  show create event e1;
create trigger trg before insert on t1 for each row
begin
  show create event e1;
create function f1() returns int
begin
  select event_name from information_schema.events;
create trigger trg before insert on t1 for each row
begin
  select event_name from information_schema.events;
create function f1() returns int
begin
  create event e2 on schedule every 10 hour do select 1;
create function f1() returns int
begin
  alter event e1 rename to e2;
create function f1() returns int
begin
  drop event e2;
create trigger trg before insert on t1 for each row
begin
  set new.a= f1();
create function f1() returns int
begin
  call p1();
create procedure p1()
begin
  select event_name from information_schema.events;
insert into t1 (a) values (1)|
drop procedure p1|
create procedure p1()
begin
  create temporary table tmp select event_name from information_schema.events;
insert into t1 (a) values (1)|
select * from tmp|
drop temporary table tmp|
drop procedure p1|
create procedure p1()
begin
  alter event e1 rename to e2;
insert into t1 (a) values (1)|
drop procedure p1|
create procedure p1()
begin
  drop event e1;
insert into t1 (a) values (1)|
drop table t1|
drop event e1|
delimiter ;
                                                                             
--
-- Bug#21432 Database/Table name limited to 64 bytes, not chars, problems with multi-byte
--
set names utf8mb3;
create event имя_события_в_кодировке_утф8_длиной_больше_чем_48 on schedule every 2 year do select 1;
select EVENT_NAME from information_schema.events
where event_schema='test';
drop event имя_события_в_кодировке_утф8_длиной_больше_чем_48;
create event
очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_66
on schedule every 2 year do select 1;

--
-- Bug#35981: ALTER EVENT causes the server to change the PRESERVE option.
--

create event event_35981 on schedule every 6 month on completion preserve
disable
do
  select 1;

-- show current ON_COMPLETION
select  count(*) from information_schema.events
where   event_schema = database() and event_name = 'event_35981' and
        on_completion = 'PRESERVE';

-- show ON_COMPLETION remains "PRESERVE" when not given in ALTER EVENT
alter   event event_35981 enable;
select  count(*) from information_schema.events
where   event_schema = database() and event_name = 'event_35981' and
        on_completion = 'PRESERVE';

-- show we can change ON_COMPLETION
alter   event event_35981 on completion not preserve;
select  count(*) from information_schema.events
where   event_schema = database() and event_name = 'event_35981' and
        on_completion = 'NOT PRESERVE';

-- show ON_COMPLETION remains "NOT PRESERVE" when not given in ALTER EVENT
alter   event event_35981 disable;
select  count(*) from information_schema.events
where   event_schema = database() and event_name = 'event_35981' and
        on_completion = 'NOT PRESERVE';

-- show we can change ON_COMPLETION
alter   event event_35981 on completion preserve;
select  count(*) from information_schema.events
where   event_schema = database() and event_name = 'event_35981' and
        on_completion = 'PRESERVE';


drop event event_35981;

create event event_35981 on schedule every 6 month disable
do
  select 1;

-- show that the defaults for CREATE EVENT are still correct (NOT PRESERVE)
select  count(*) from information_schema.events
where   event_schema = database() and event_name = 'event_35981' and
        on_completion = 'NOT PRESERVE';

drop event event_35981;


-- show that backdating doesn't break

create event event_35981 on schedule every 1 hour starts current_timestamp
  on completion not preserve
do
  select 1;

-- should fail thanks to above's NOT PRESERVE
--error ER_EVENT_CANNOT_ALTER_IN_THE_PAST
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'
  ends '1999-01-02 00:00:00';

drop event event_35981;

create event event_35981 on schedule every 1 hour starts current_timestamp
  on completion not preserve
do
  select 1;

-- succeed with warning
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'
  ends '1999-01-02 00:00:00' on completion preserve;

drop event event_35981;



create event event_35981 on schedule every 1 hour starts current_timestamp
  on completion preserve
do
  select 1;

-- this should succeed thanks to above PRESERVE! give a warning though.
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'
  ends '1999-01-02 00:00:00';

-- this should fail, as the event would have passed already
--error ER_EVENT_CANNOT_ALTER_IN_THE_PAST
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'
  ends '1999-01-02 00:00:00' on completion not preserve;

-- should succeed giving a warning
alter event event_35981 on schedule every 1 hour starts '1999-01-01 00:00:00'
  ends '1999-01-02 00:00:00' on completion preserve;

drop event event_35981;

-- 
-- End of tests
--

let $wait_condition=
  select count(*) = 0 from information_schema.processlist
  where db='events_test' and command = 'Connect' and user=current_user();

drop database events_test;
