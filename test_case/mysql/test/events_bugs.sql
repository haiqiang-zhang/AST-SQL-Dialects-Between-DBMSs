--     - Fix for
--       Bug#41111 events_bugs fails sporadically on pushbuild
--     - Avoid effects of
--       Bug#41925 Warning 1366 Incorrect string value: ...  for column processlist.info
--
-- Please set $
let $fixed_bug41925= 0;
--     
-- Dear maintainer of this test. Please do NOT remove the next big comment.
-- The tests for events were quite unstable over a significant time because the
-- effects of events in general and their representation within the processlist
-- were partially not known. Therefore I had to make excessive experiments.
-- The comment with the outcome of these experiments will be moved into a README
-- file as soon as the tests for events get their own testsuite.
--
-- Outcome of some experiments (mleich, mysql-5.1 2008-12):
-- --------------------------------------------------------
-- 0. Most time used setup:
--    High parallel I/O load
--    set global event_scheduler= off;
--    sleep 3;
--    use events_test;
--    create event e_16407 on schedule every 2 second do
--    begin
--      select 'FIRST COMMAND', sleep(0.5);
--      select 'SECOND COMMAND';
--    end|
--    set global event_scheduler= on;
--    Start observation of the processlist
--  
--
-- 1. SET GLOBAL event_scheduler = 'ON' and immediate observation of the processlist.
-- 1.1 Effects around event scheduler:
-- 1.1.1 First phase (very short)
--       No user 'event_scheduler' within information_schema.processlist.
-- 1.1.2 Second phase observed (independend of probably existing events and very short) was
--       USER            HOST       DB   COMMAND TIME STATE        INFO
--       event_scheduler localhost  NULL Daemon     0 Initialized  NULL
-- 1.1.3 Third phase observed:
-- 1.1.3.1 Case we do not have existing events (rather long)
--         USER            HOST       DB   COMMAND TIME STATE                  INFO
--         event_scheduler localhost  NULL Daemon     0 Waiting on empty queue NULL
-- 1.1.3.2 Case there exists already an event
-- 1.1.3.2.1 Event executor is not visible in processlist but comes up soon
--           USER            HOST       DB    COMMAND TIME STATE  INFO
--           event_scheduler localhost  NULL  Daemon     0 NULL
--                   or
--           event_scheduler localhost  NULL  Daemon     0  NULL  NULL
-- 1.1.3.2.2 A bit later, at least one event executor is or was visible in processlist
--           The states mentioned in 3.2.1 or a bit later
--           USER            HOST       DB    COMMAND TIME STATE                        INFO
--           event_scheduler localhost  NULL  Daemon     0 Waiting for next activation  NULL
-- 1.2 Effects around event executor:
--     Typical processlist content:
--     USER    evtest1      -- Definer of event
--     DB      events_test  -- DB during time of event creation (use DB is not allowed in events)
--     COMMAND Connect
--     STATE   NULL
--     INFO    SET @evname = 'ev_sched_1823' -- Part of the event code
--
--     State before "User sleep select 'FIRST COMMAND', sleep(0.5);
--     ID  USER            HOST       DB    COMMAND TIME  STATE  INFO
--     7   event_scheduler localhost  NULL  Connect    0  NULL   NULL
--     !! The user is not the event creator and the DB is different.  !!
--     !! This means that we must get later a change of the identity. !!
--     or
--     USER  HOST       DB           COMMAND  TIME  STATE                 INFO
--     root  localhost  events_test  Connect     0  checking permissions
--     or
--     USER  HOST       DB           COMMAND  TIME  STATE                 INFO
--     root  localhost  events_test  Connect     0  checking permissions  CREATE PROCEDURE ....
--     or
--     USER  HOST       DB           COMMAND  TIME  STATE  INFO
--     root  localhost  events_test  Connect     0  NULL   select 'FIRST COMMAND', sleep(0.5)
--     or
--     USER  HOST       DB           COMMAND  TIME  STATE                 INFO
--     root  localhost  events_test  Connect     0  checking permissions  select 'FIRST COMMAND'...
--     or
--     USER  HOST       DB           COMMAND  TIME  STATE          INFO
--     root  localhost  events_test  Connect     0  Opening table  select 'FIRST COMMAND', sleep(0.5)
--     or
--     USER  HOST       DB           COMMAND  TIME  STATE   INFO
--     root  localhost  events_test  Connect     0  Locked  select 'FIRST COMMAND', sleep(0.5)
--     or
--     USER  HOST       DB           COMMAND  TIME  STATE      INFO
--     root  localhost  events_test  Connect     0  executing  select 'FIRST COMMAND', sleep(0.5)
--
--     State "User sleep select 'FIRST COMMAND', sleep(0.5);
--     USER  HOST       DB           COMMAND  TIME  STATE       INFO
--     root  localhost  events_test  Connect     0  User sleep  select 'FIRST COMMAND', sleep(0.5)
--
--     State at end (! It looks like a slow CREATE PROC !) of event code execution was sometimes
--     USER  HOST       DB           COMMAND  TIME  STATE               INFO
--     root  localhost  events_test  Connect     0  logging slow query  CREATE PROCEDURE `e_16407`...
--
--     State after running some event code was sometimes
--     USER  HOST       DB           COMMAND  TIME  STATE               INFO
--     root  localhost  events_test  Connect  0     logging slow query  select 'SECOND COMMAND'
--
--     State somewhere (I guess just before the event executor disappears)
--     USER              HOST     DB           COMMAND  TIME  STATE     INFO
--     Event thread fin  <empty>  events_test  Connect  0     Clearing  NULL
--
--
-- 2. SET GLOBAL event_scheduler = 'OFF';
--    Immediate observation of the processlist.
--    Effects:
--    1. I never found the user 'event_scheduler' within the processlist.
--    2. Events just during execution could be found within the processlist
--       = It does not look like "SET GLOBAL event_scheduler = 'OFF'" stops them.
--         ==> Everything mentioned in 1.2 above could be observed.
--
-- Several subtests were weak because they showed random result set differences after issuing
-- "SET GLOBAL EVENT_SCHEDULER= off;
--    1. Reason one: There were already event executors
--       Fix: Wait till there is no event executor active ==> no session WHERE
--            - command IN ('Connect')
--              There must be no parallel session being just in "Connect" phase!
--            or
--            - user = <who created the maybe current running events>
--                 There must be no parallel session of this person.
--              or user = 'event_scheduler' with command = 'Connect'
--                 The session which will soon change its identity to event creator.
--
--    2. Reason two: If an event modifies a MyISAM table than a delayed visibilty of changes
--                   might occur (concurrent_inserts=on).
--

--disable_warnings
drop database if exists events_test;
drop database if exists mysqltest_db1;
drop database if exists mysqltest_db2;
create database events_test;
use events_test;
set @concurrent_insert= @@global.concurrent_insert;
set @@global.concurrent_insert = 0;

--
-- START:  Bug #31332 --event-scheduler option misbehaving
--

-- NOTE!! this test must come first! It's testing that the --event-scheduler
-- option with no argument in events_bugs-master.opt turns the scheduler on.

--disable_warnings
select * from performance_schema.global_variables where variable_name like 'event_scheduler';

SET GLOBAL event_scheduler = 'OFF';

--
-- END: Bug #31332
--

--
-- START - 16415: Events: event names are case sensitive
--
CREATE EVENT lower_case ON SCHEDULE EVERY 1 MINUTE DO SELECT 1;
CREATE EVENT Lower_case ON SCHEDULE EVERY 2 MINUTE DO SELECT 2;
DROP EVENT Lower_case;
SET NAMES cp1251;
CREATE EVENT �����_��������_1251 ON SCHEDULE EVERY 1 YEAR DO SELECT 100;
CREATE EVENT �����_��������_1251 ON SCHEDULE EVERY 2 YEAR DO SELECT 200;
DROP EVENT �����_��������_1251;
SET NAMES utf8mb3;
CREATE EVENT долен_регистър_утф8 ON SCHEDULE EVERY 3 YEAR DO SELECT 300;
CREATE EVENT ДОЛЕН_регистър_утф8 ON SCHEDULE EVERY 4 YEAR DO SELECT 400;
DROP EVENT ДОЛЕН_регистър_утф8;
SET NAMES latin1;

--
-- END   - 16415: Events: event names are case sensitive
--

--
-- START - BUG#16408: Events: crash for an event in a procedure
--
set @a=3;
CREATE PROCEDURE p_16 () CREATE EVENT e_16 ON SCHEDULE EVERY @a SECOND DO SET @a=5;
--

--
-- Start - 16396: Events: Distant-future dates become past dates
--
--error ER_WRONG_VALUE
create event e_55 on schedule at 99990101000000 do drop table t;
create event e_55 on schedule every 10 hour starts 99990101000000 do drop table t;
create event e_55 on schedule every 10 minute ends 99990101000000 do drop table t;
create event e_55 on schedule at 10000101000000 do drop table t;

-- For the purpose of backup we allow times in the past.  Here, no
-- error will be given, but the event won't be created.  One may think
-- of that as if the event was created, then it turned out it's in the
-- past, so it was dropped because of implicit ON COMPLETION NOT
-- PRESERVE.
create event e_55 on schedule at 20000101000000 do drop table t;
create event e_55 on schedule at 20380101000000 starts 10000101000000 do drop table t;
create event e_55 on schedule at 20380101000000 ends 10000101000000 do drop table t;
create event e_55 on schedule at 20380101000000 starts 10000101000000 ends 10000101000000 do drop table t;
create event e_55 on schedule every 10 hour starts 10000101000000 do drop table t;

--
-- End  -  16396: Events: Distant-future dates become past dates
--

--
-- Start - 16407: Events: Changes in sql_mode won't be taken into account
--
set global event_scheduler=off;
set global event_scheduler= on;
set @old_sql_mode:=@@sql_mode;
set sql_mode=ansi;
select get_lock('test_bug16407', 60);
create event e_16407 on schedule every 60 second do
begin
  select get_lock('test_bug16407', 60);

-- The default session has the user lock.
-- We wait till one event runs and hangs when trying to get the user lock.
let $wait_condition=
  select count(*) > 0 from information_schema.processlist
  where state = 'User lock' and info = 'select get_lock(\'test_bug16407\', 60)';
select /*1*/ user, host, db, info from information_schema.processlist
where state = 'User lock' and info = 'select get_lock(\'test_bug16407\', 60)';
select release_lock('test_bug16407');
--    Bug#39863 events_bugs fails sporadically on pushbuild (extra processes in I_S.PROCESSLIST)
-- which is most probably caused by
--    Bug#32782 User lock hash fails to find lock
--    "various issues related to missing or incorrect return results
--     from release_lock()."
-- Therefore we check here if the event executor is no more locked or
-- we waited >= 5 seconds for this to happen.
let $wait_timeout= 5;
let $wait_condition=
  select count(*) = 0 from information_schema.processlist
  where state = 'User lock' and info = 'select get_lock(\'test_bug16407\', 60)';
{
   --echo ERROR: There must be no session with
   --echo        state = 'User lock' and info = 'select get_lock('test_bug16407', 60)
   --echo        within the processlist.
   --echo        We probably hit Bug--32782 User lock hash fails to find lock
   SELECT * FROM information_schema.processlist;

set global event_scheduler= off;

select event_schema, event_name, sql_mode from information_schema.events order by event_schema, event_name;
set sql_mode='traditional';
alter event e_16407 do select 1;
select event_schema, event_name, sql_mode from information_schema.events order by event_schema, event_name;
drop event e_16407;

set sql_mode="ansi";
select get_lock('ee_16407_2', 60);

set global event_scheduler= 1;
set sql_mode="traditional";
create table events_smode_test(ev_name char(10), a date);
create event ee_16407_2 on schedule every 60 second do
begin
  select get_lock('ee_16407_2', 60) /*ee_16407_2*/;
  select release_lock('ee_16407_2');
  insert into events_test.events_smode_test values('ee_16407_2','1980-19-02');
insert into events_test.events_smode_test values ('test','1980-19-02')|
--echo "This is ok"
create event ee_16407_3 on schedule every 60 second do
begin
  select get_lock('ee_16407_2', 60) /*ee_16407_3*/;
  select release_lock('ee_16407_2');
  insert into events_test.events_smode_test values ('ee_16407_3','1980-02-19');
  insert into events_test.events_smode_test values ('ee_16407_3','1980-02-29');
set sql_mode=""|
--echo "This will insert rows but they will be truncated"
create event ee_16407_4 on schedule every 60 second do
begin
  select get_lock('ee_16407_2', 60) /*ee_16407_4*/;
  select release_lock('ee_16407_2');
  insert into events_test.events_smode_test values ('ee_16407_4','10-11-1956');
select event_schema, event_name, sql_mode from information_schema.events order by event_schema, event_name;

-- We wait till we have three event executors waiting for the removal of the lock.
let $wait_condition=
  select count(*) = 3 from information_schema.processlist
  where state = 'User lock' and info = 'select get_lock(\'ee_16407_2\', 60)';

-- There is an extreme low risk that an additional event execution is just coming
-- up because
-- - the events have to be started every 60 seconds.
-- - we are just after event creation + waiting for seeing 3 locked
-- We expect to see three event executors in state 'User lock'.
select /*2*/ user, host, db, info from information_schema.processlist
where state = 'User lock' and info = 'select get_lock(\'ee_16407_2\', 60)';

select release_lock('ee_16407_2');

-- Try to avoid
--    Bug#39863 events_bugs fails sporadically on pushbuild (extra processes in I_S.PROCESSLIST)
-- which is most probably caused by
--    Bug#32782 User lock hash fails to find lock
--    "various issues related to missing or incorrect return results
--     from release_lock()."
-- Therefore we check here if the event executing sessions disappeared or
-- we waited >= 5 seconds for this to happen.
let $wait_timeout= 5;
let $wait_condition=
  select count(*) = 0
  from information_schema.processlist
  where state = 'User lock' and info = 'select get_lock(\'ee_16407_2\', 60)';
{
   --echo ERROR: There must be no session with
   --echo        state = 'User lock' and info = 'select get_lock('test_bug16407_2', 60)
   --echo        within the processlist.
   --echo        We probably hit Bug--32782 User lock hash fails to find lock
   SELECT * FROM information_schema.processlist;

-- We expect to see no event executors in state 'User lock'.
if(!$fixed_bug41925)
{
   --disable_warnings
}
select /*3*/ user, host, db, info from information_schema.processlist
where state = 'User lock' and info = 'select get_lock(\'ee_16407_2\', 60)';
{
   --enable_warnings
}

set global event_scheduler= off;

select * from events_test.events_smode_test order by ev_name, a;
select event_schema, event_name, sql_mode from information_schema.events order by event_schema, event_name;
drop event ee_16407_2;
drop event ee_16407_3;
drop event ee_16407_4;
delete from events_test.events_smode_test;
set sql_mode='ansi';
select get_lock('ee_16407_5', 60);

set global event_scheduler= on;

set sql_mode='traditional';
create procedure ee_16407_5_pendant() begin insert into events_test.events_smode_test values('ee_16407_5','2001-02-29');
create procedure ee_16407_6_pendant() begin insert into events_test.events_smode_test values('ee_16407_6','2004-02-29');
create event ee_16407_5 on schedule every 60 second do
begin
  select get_lock('ee_16407_5', 60) /*ee_16407_5*/;
  select release_lock('ee_16407_5');
create event ee_16407_6 on schedule every 60 second do
begin
  select get_lock('ee_16407_5', 60) /*ee_16407_6*/;
  select release_lock('ee_16407_5');

let $wait_condition=
  select count(*) = 2 from information_schema.processlist
  where state = 'User lock' and info = 'select get_lock(\'ee_16407_5\', 60)';
select /*4*/ user, host, db, info from information_schema.processlist
where state = 'User lock' and info = 'select get_lock(\'ee_16407_5\', 60)';

select release_lock('ee_16407_5');

let $wait_condition=
  select count(*) = 0 from information_schema.processlist
  where state = 'User lock' and info = 'select get_lock(\'ee_16407_5\', 60)';
{
   --disable_warnings
}
select /*5*/ user, host, db, info from information_schema.processlist
where state = 'User lock' and info = 'select get_lock(\'ee_16407_5\', 60)';
{
   --enable_warnings
}

-- Wait till all event executors have finished their work, so that we can be sure
-- that their changes to events_smode_test are done.
--source include/no_running_events.inc

select * from events_test.events_smode_test order by ev_name, a;
select event_schema, event_name, sql_mode from information_schema.events order by event_schema, event_name;

drop event ee_16407_5;
drop event ee_16407_6;
drop procedure ee_16407_5_pendant;
drop procedure ee_16407_6_pendant;
set global event_scheduler= off;
drop table events_smode_test;
set sql_mode=@old_sql_mode;
--

--
-- START - 18897: Events: unauthorized action possible with alter event rename
--
set global event_scheduler=off;
delete from mysql.user where User like 'mysqltest_%';
delete from mysql.db where User like 'mysqltest_%';
drop database if exists mysqltest_db1;
create user mysqltest_user1@localhost;
create database mysqltest_db1;
create event mysqltest_user1 on schedule every 10 second do select 42;
alter event mysqltest_user1 rename to mysqltest_db1.mysqltest_user1;
select database();
alter event events_test.mysqltest_user1 rename to mysqltest_user1;
select event_schema, event_name, definer, event_type, status from information_schema.events;
drop event events_test.mysqltest_user1;
drop user mysqltest_user1@localhost;
drop database mysqltest_db1;
--

--
-- START - BUG#16394: Events: Crash if schedule contains SELECT
--
--error ER_NOT_SUPPORTED_YET
create event e_53 on schedule at (select s1 from ttx) do drop table t;
create event e_53 on schedule every (select s1 from ttx) second do drop table t;
create event e_53 on schedule every 5 second starts (select s1 from ttx) do drop table t;
create event e_53 on schedule every 5 second ends (select s1 from ttx) do drop table t;
--

--
-- START - BUG#22397: Events: crash with procedure which alters events
--
--disable_warnings
drop event if exists e_16;
drop procedure if exists p_16;
create event e_16 on schedule every 1 second do set @a=5;
create procedure p_16 () alter event e_16 on schedule every @a second;
set @a = null;
set @a= 6;

drop procedure p_16;
drop event e_16;

--
-- START - BUG#22830 Events: crash with procedure which alters events with function
--
--disable_warnings
drop function if exists f22830;
drop event if exists e22830;
drop event if exists e22830_1;
drop event if exists e22830_2;
drop event if exists e22830_3;
drop event if exists e22830_4;
drop table if exists t1;
drop table if exists t2;
create table t1 (a int);
insert into t1 values (2);
create table t2 (a char(20));
insert into t2 values ("e22830_1");
create function f22830 () returns int return 5;

select get_lock('ee_22830', 60);
set global event_scheduler=on;
create procedure p22830_wait()
begin
  select get_lock('ee_22830', 60);
  select release_lock('ee_22830');
create event e22830 on schedule every f22830() second do
begin
  call p22830_wait();
  select 123;
create event e22830_1 on schedule every 1 hour do
begin
  call p22830_wait();
  alter event e22830_1 on schedule every (select 8 from dual) hour;
create event e22830_2 on schedule every 1 hour do
begin
  call p22830_wait();
  alter event e22830_2 on schedule every (select 8 from t1) hour;
create event e22830_3 on schedule every 1 hour do
begin
  call p22830_wait();
  alter event e22830_3 on schedule every f22830() hour;
create event e22830_4 on schedule every 1 hour do
begin
  call p22830_wait();
  alter event e22830_4 on schedule every (select f22830() from dual) hour;
select event_name, event_definition, interval_value, interval_field from information_schema.events order by event_name;

select release_lock('ee_22830');

let $wait_condition=
  select group_concat(interval_value order by interval_value) = '1,1,1,8'
  from information_schema.events;

set global event_scheduler=off;
select event_name, event_definition, interval_value, interval_field from information_schema.events order by event_name;
drop procedure p22830_wait;
drop function f22830;
drop event (select a from t2);
drop event e22830_1;
drop event e22830_2;
drop event e22830_3;
drop event e22830_4;
drop table t1;
drop table t2;


--
-- BUG#16425: Events: no DEFINER clause
--
--error 0,ER_CANNOT_USER
DROP USER mysqltest_u1@localhost;

CREATE USER mysqltest_u1@localhost;

CREATE EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;

CREATE DEFINER=CURRENT_USER EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
ALTER DEFINER=mysqltest_u1@localhost EVENT e1 ON SCHEDULE EVERY 1 HOUR;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;

CREATE DEFINER=CURRENT_USER() EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;

CREATE DEFINER=mysqltest_u1@localhost EVENT e1 ON SCHEDULE EVERY 1 DAY DO
  SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;

CREATE EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;

CREATE DEFINER=CURRENT_USER EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
ALTER DEFINER=root@localhost EVENT e1 ON SCHEDULE EVERY 1 HOUR;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;

CREATE DEFINER=CURRENT_USER() EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;
CREATE DEFINER=root@localhost EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
DROP EVENT e1;

DROP USER mysqltest_u1@localhost;


--
-- BUG#16420: Events: timestamps become UTC
-- BUG#26429: SHOW CREATE EVENT is incorrect for an event that
--            STARTS NOW()
-- BUG#26431: Impossible to re-create an event from backup if its
--            STARTS clause is in the past
-- WL#3698: Events: execution in local time zone
--
-- Here we only check non-concurrent aspects of the patch.
-- For the actual tests of time zones please see events_time_zone.test
--
SET GLOBAL EVENT_SCHEDULER= OFF;
SET @save_time_zone= @@TIME_ZONE;

-- We will use a separate connection because SET TIMESTAMP will stop
-- the clock in that connection.

SET TIME_ZONE= '+00:00';
SET TIMESTAMP= UNIX_TIMESTAMP('2005-12-31 23:58:59');


-- Test when event time zone is updated on ALTER EVENT.
--

CREATE EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;

-- Test storing and updating of the event time zone.
--
SET TIME_ZONE= '-01:00';
ALTER EVENT e1 ON SCHEDULE EVERY 1 DAY STARTS '2000-01-01 00:00:00';

-- This will update event time zone.
SET TIME_ZONE= '+02:00';
ALTER EVENT e1 ON SCHEDULE AT '2000-01-02 00:00:00'
  ON COMPLETION PRESERVE DISABLE;

-- This will update event time zone.
SET TIME_ZONE= '-03:00';
ALTER EVENT e1 ON SCHEDULE EVERY 1 DAY ENDS '2038-01-03 00:00:00'
  ON COMPLETION PRESERVE DISABLE;

-- This will not update event time zone, as no time is being adjusted.
SET TIME_ZONE= '+04:00';
ALTER EVENT e1 DO SELECT 2;

DROP EVENT e1;

-- Create some events.
SET TIME_ZONE='+05:00';
CREATE EVENT e1 ON SCHEDULE EVERY 1 DAY STARTS '2006-01-01 00:00:00' DO
  SELECT 1;

SET TIMESTAMP= @@TIMESTAMP + 1;

SET TIME_ZONE='-05:00';
CREATE EVENT e2 ON SCHEDULE EVERY 1 DAY STARTS '2006-01-01 00:00:00' DO
  SELECT 1;

SET TIMESTAMP= @@TIMESTAMP + 1;

SET TIME_ZONE='+00:00';
CREATE EVENT e3 ON SCHEDULE EVERY 1 DAY STARTS '2006-01-01 00:00:00' DO
  SELECT 1;


-- Test INFORMATION_SCHEMA.EVENTS.
--

SELECT * FROM INFORMATION_SCHEMA.EVENTS ORDER BY event_name;


-- Test SHOW EVENTS.
--

SHOW EVENTS;


-- Test SHOW CREATE EVENT.
--

SHOW CREATE EVENT e1;

-- Test times in the past.
--

--echo The following should fail, and nothing should be altered.

--error ER_EVENT_CANNOT_ALTER_IN_THE_PAST
ALTER EVENT e1 ON SCHEDULE EVERY 1 HOUR STARTS '1999-01-01 00:00:00'
  ENDS '1999-01-02 00:00:00';
ALTER EVENT e1 ON SCHEDULE EVERY 1 HOUR STARTS '1999-01-01 00:00:00'
  ENDS '1999-01-02 00:00:00' DISABLE;

CREATE EVENT e4 ON SCHEDULE EVERY 1 HOUR STARTS '1999-01-01 00:00:00'
  ENDS '1999-01-02 00:00:00'
DO
  SELECT 1;

CREATE EVENT e4 ON SCHEDULE EVERY 1 HOUR STARTS '1999-01-01 00:00:00'
  ENDS '1999-01-02 00:00:00' DISABLE
DO
  SELECT 1;

CREATE EVENT e4 ON SCHEDULE AT '1999-01-01 00:00:00' DO
  SELECT 1;

CREATE EVENT e4 ON SCHEDULE AT '1999-01-01 00:00:00' DISABLE
DO
  SELECT 1;

ALTER EVENT e1 ON SCHEDULE EVERY 1 HOUR STARTS '1999-01-01 00:00:00'
  ENDS '1999-01-02 00:00:00' ON COMPLETION PRESERVE;

CREATE EVENT e4 ON SCHEDULE EVERY 1 HOUR STARTS '1999-01-01 00:00:00'
  ENDS '1999-01-02 00:00:00' ON COMPLETION PRESERVE
DO
  SELECT 1;

CREATE EVENT e5 ON SCHEDULE AT '1999-01-01 00:00:00'
  ON COMPLETION PRESERVE
DO
  SELECT 1;

ALTER EVENT e2 ON SCHEDULE EVERY 1 HOUR STARTS '1999-01-01 00:00:00';

ALTER EVENT e3 ON SCHEDULE EVERY 1 HOUR STARTS '1999-01-01 00:00:00'
  ENDS '1999-01-02 00:00:00' ON COMPLETION PRESERVE DISABLE;

CREATE EVENT e6 ON SCHEDULE EVERY 1 HOUR STARTS '1999-01-01 00:00:00' DO
  SELECT 1;

CREATE EVENT e7 ON SCHEDULE EVERY 1 HOUR STARTS '1999-01-01 00:00:00'
  ENDS '1999-01-02 00:00:00' ON COMPLETION PRESERVE DISABLE
DO
  SELECT 1;

CREATE EVENT e8 ON SCHEDULE AT '1999-01-01 00:00:00'
  ON COMPLETION PRESERVE DISABLE
DO
  SELECT 1;


DROP EVENT e8;
DROP EVENT e7;
DROP EVENT e6;
DROP EVENT e5;
DROP EVENT e4;
DROP EVENT e3;
DROP EVENT e2;
DROP EVENT e1;

SET TIME_ZONE=@save_time_zone;
SET TIMESTAMP=DEFAULT;

--
-- START - BUG#28666 CREATE EVENT ... EVERY 0 SECOND let server crash
--
--disable_warnings
drop event if exists new_event;
CREATE EVENT new_event ON SCHEDULE EVERY 0 SECOND DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE EVERY (SELECT 0) SECOND DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE EVERY "abcdef" SECOND DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE EVERY "0abcdef" SECOND DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE EVERY "a1bcdef" SECOND DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE EVERY (SELECT "abcdef" UNION SELECT "abcdef") SECOND DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE EVERY (SELECT "0abcdef") SECOND DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE EVERY (SELECT "a1bcdef") SECOND DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE AT "every day" DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE AT "0every day" DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE AT (SELECT "every day") DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE AT NOW() STARTS NOW() DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE AT NOW() ENDS NOW() DO SELECT 1;
CREATE EVENT new_event ON SCHEDULE AT NOW() STARTS NOW() ENDS NOW() DO SELECT 1;

--
-- START - BUG#28924 If I drop the user who is the definer of an active event
--                   then server cores
--
USE test;
SET GLOBAL event_scheduler = ON;
CREATE TABLE events_test.event_log
(id int KEY AUTO_INCREMENT, ev_nm char(40), ev_cnt int, ev_tm timestamp);
SET @save_session_autocommit = @@session.autocommit;
SET @@session.autocommit=0;
CREATE USER evtest1@localhost;
ALTER USER evtest1@localhost IDENTIFIED BY 'ev1';
CREATE EVENT ev_sched_1823 ON SCHEDULE EVERY 2 SECOND
DO BEGIN
   SET AUTOCOMMIT = 0;
   SET @evname = 'ev_sched_1823';
   SET @cnt = 0;
   SELECT COUNT(*) INTO @cnt FROM events_test.event_log WHERE ev_nm = @evname;
   IF @cnt < 6 THEN
      INSERT INTO events_test.event_log VALUES (NULL,@evname,@cnt+1,current_timestamp());
      COMMIT;
   END IF;
   SELECT COUNT(*) INTO @cnt FROM events_test.event_log WHERE ev_nm = @evname;
   IF @cnt < 6 THEN
      INSERT INTO events_test.event_log VALUES (NULL,@evname,@cnt+1,current_timestamp());
      ROLLBACK;
   END IF;
--    reasonable time like 4 seconds. Till ~ 2 seconds could pass on a heavy
--    loaded testing box before something gets executed).
--    Detection of execution is via the records inserted by the event.
--echo Sleep till the first INSERT into events_test.event_log occurred
let $wait_timeout= 4;
let $wait_condition=
SELECT COUNT(*) > 0 FROM events_test.event_log;
SELECT COUNT(*) > 0 AS "Expect 1" FROM events_test.event_log;
--    few seconds
-- 3. Check that the event is never executed again
--    It could be that an event execution was running before the DROP USER
--    and all implicite actions belonging to this are completed.
--    Lets assume that ~ 4 seconds waiting are enough for the event
--    scheduler to detect that
--echo Sleep 4 seconds
sleep 4;
SELECT COUNT(*) INTO @row_cnt FROM events_test.event_log;
--    Give the event mechanism ~ 4 seconds to do something wrong
--    (execute the event of the dropped user -> inser rows).
--echo Sleep 4 seconds
sleep 4;
SELECT COUNT(*) > @row_cnt AS "Expect 0" FROM events_test.event_log;
DROP EVENT events_test.ev_sched_1823;
DROP USER evtest1@localhost;
DROP TABLE events_test.event_log;
SET GLOBAL event_scheduler = OFF;
SET @@session.autocommit = @save_session_autocommit;


--
-- Bug#28641 CREATE EVENT with '2038.01.18 03:00:00' let server crash.
--
SET GLOBAL event_scheduler= ON;
CREATE EVENT bug28641 ON SCHEDULE AT '2038.01.18 03:00:00'
DO BEGIN
   SELECT 1;
SET GLOBAL event_scheduler= OFF;
DROP EVENT bug28641;
DROP USER mysqltest_u1@localhost;
DROP EVENT IF EXISTS e1;
DROP EVENT IF EXISTS e2;

-- Check that an ordinary user can not create/update/drop events in the
-- read-only mode.

CREATE USER mysqltest_u1@localhost;

SET GLOBAL READ_ONLY = 1;
CREATE EVENT e1 ON SCHEDULE AT '2038-01-01 00:00:00' DO SET @a = 1;
ALTER EVENT e1 COMMENT 'comment';
DROP EVENT e1;

-- Check that the super user still can create/update/drop events.

--echo --
--echo -- Connection: root_con (root@localhost/events_test).
--echo --

--connect(root_con,localhost,root,,events_test)

--echo

CREATE EVENT e1 ON SCHEDULE AT '2038-01-01 00:00:00' DO SET @a = 1;

ALTER EVENT e1 COMMENT 'comment';

DROP EVENT e1;

--
-- Switch to read-write mode;
--

SET GLOBAL READ_ONLY = 0;

CREATE EVENT e1 ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 SECOND DO SET @a = 1;
CREATE EVENT e2 ON SCHEDULE EVERY 1 SECOND DO SET @a = 1;

SELECT
  event_name,
  last_executed IS NULL,
  definer
FROM INFORMATION_SCHEMA.EVENTS
WHERE event_schema = 'events_test';

SET GLOBAL READ_ONLY = 1;

-- Check that the event scheduler is able to update event.

--echo

SET GLOBAL EVENT_SCHEDULER = ON;

let $wait_timeout = 4;
let $wait_condition =
  SELECT COUNT(*) = 0
  FROM INFORMATION_SCHEMA.EVENTS
  WHERE event_schema = 'events_test' AND event_name = 'e1';

let $wait_condition =
  SELECT last_executed IS NOT NULL
  FROM INFORMATION_SCHEMA.EVENTS
  WHERE event_schema = 'events_test' AND event_name = 'e2';

SET GLOBAL EVENT_SCHEDULER = OFF;

SELECT
  event_name,
  last_executed IS NULL,
  definer
FROM INFORMATION_SCHEMA.EVENTS
WHERE event_schema = 'events_test';
DROP EVENT e1;

DROP EVENT e2;

SET GLOBAL READ_ONLY = 0;

DROP USER mysqltest_u1@localhost;

--
-- Bug#32633 Can not create any routine if SQL_MODE=no_engine_substitution
--
-- Ensure that when new SQL modes are introduced, they are also added to
-- the mysql.events table.
--

--disable_warnings
drop procedure if exists p;
set @old_mode= @@sql_mode;
set @@sql_mode= cast(pow(2,33)-1 as unsigned integer) & ~0x1003ff00;
create event e1 on schedule every 1 day do select 1;
select @@sql_mode into @full_mode;
set @@sql_mode= @old_mode;
select event_name from information_schema.events where event_name = 'e1' and sql_mode = @full_mode;
drop event e1;

--
-- Bug#36540: CREATE EVENT and ALTER EVENT statements fail with large server_id
--

SET @old_server_id = @@GLOBAL.server_id;
SET GLOBAL server_id = (1 << 32) - 1;
SELECT @@GLOBAL.server_id;
CREATE EVENT ev1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, originator FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT ev1;
SET GLOBAL server_id = @old_server_id;

--
-- Bug#11751148: show events shows events in other schema
--

CREATE DATABASE event_test12;
USE event_test12;
CREATE EVENT ev1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
CREATE DATABASE event_test1;
USE event_test1;
DROP DATABASE event_test1;
DROP DATABASE event_test12;
USE events_test;
SET GLOBAL event_scheduler = ON;
DROP TABLE IF EXISTS table_bug12546938;
DROP EVENT IF EXISTS event_Bug12546938;
CREATE TABLE table_bug12546938 (i INT);
CREATE EVENT event_Bug12546938
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 SECOND ON COMPLETION PRESERVE
ENABLE DO
BEGIN 
  INSERT INTO table_bug12546938 VALUES(1);
END
|

--echo -- Now try to create the same event using CREATE EVENT IF NOT EXISTS.
--echo -- A warning should be emitted. A new event should not be created nor
--echo -- the old event should be re-executed.
CREATE EVENT IF NOT EXISTS event_bug12546938
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 SECOND ON COMPLETION PRESERVE
ENABLE DO
BEGIN
  INSERT INTO table_bug12546938 VALUES (1);
END
|

delimiter ;
let $wait_condition= SELECT COUNT(*) FROM table_bug12546938;
SELECT COUNT(*) FROM table_bug12546938;
DROP EVENT IF EXISTS event_Bug12546938;
DROP TABLE table_bug12546938;
SET GLOBAL EVENT_SCHEDULER = OFF;

--
-- Bug#11764334 - 57156: ALTER EVENT CHANGES THE EVENT STATUS
--
--disable_warnings
DROP DATABASE IF EXISTS event_test11764334;
CREATE DATABASE event_test11764334;
USE event_test11764334;
CREATE EVENT ev1 ON SCHEDULE EVERY 3 SECOND DISABLE DO SELECT 1;
ALTER EVENT ev1 ON SCHEDULE EVERY 4 SECOND;
DROP EVENT ev1;
DROP DATABASE event_test11764334;
USE test;
ALTER EVENT e1 ON SCHEDULE EVERY
EXISTS (SELECT 1 AS x ORDER BY x LIMIT 0) NOT IN (1) MINUTE_SECOND;
ALTER EVENT e1 ON SCHEDULE EVERY
EXISTS (SELECT 1 AS x ORDER BY x LIMIT 0) NOT IN (2) MINUTE_SECOND;
CREATE EVENT e1 ON SCHEDULE EVERY 2 HOUR DO SELECT 1;
ALTER EVENT e1 ON SCHEDULE EVERY
EXISTS (SELECT 1 AS x ORDER BY x LIMIT 0) NOT IN (2) MINUTE_SECOND;
DROP EVENT e1;

SET GLOBAL event_scheduler= 'ON';
CREATE TABLE t1(_userid CHAR (1)KEY) ENGINE=InnoDB;
SET @save_autocommit_value= @@global.autocommit;
SET @@global.autocommit= OFF;
SET @@session.TIMESTAMP=200;
CREATE EVENT e1 ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 DAY DO INSERT INTO t1 VALUES(1);
SELECT SLEEP(3);
SET @@global.autocommit=@save_autocommit_value;
SET @@session.TIMESTAMP=default;
DROP TABLE t1;
SET NAMES utf8mb3;
CREATE EVENT cafe ON SCHEDULE EVERY 2 YEAR DO SELECT 1;
CREATE EVENT café ON SCHEDULE EVERY 2 YEAR DO SELECT 1;
CREATE EVENT CAFE ON SCHEDULE EVERY 2 YEAR DO SELECT 1;
DROP EVENT CaFé;
CREATE EVENT очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_e ON SCHEDULE EVERY 2 YEAR DO SELECT 1;
CREATE EVENT очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_é ON SCHEDULE EVERY 2 YEAR DO SELECT 1;
CREATE EVENT очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_E ON SCHEDULE EVERY 2 YEAR DO SELECT 1;
DROP EVENT очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_é;

SET NAMES default;

SET TIMESTAMP= UNIX_TIMESTAMP('2019-08-01 01:20:30');
SET GLOBAL event_scheduler = ON;
SET sql_mode='STRICT_TRANS_TABLES';
SET TIME_ZONE= '+03:00';
CREATE EVENT my_event
    ON SCHEDULE EVERY 2 SECOND
      STARTS '2019-08-01 01:20:30'
      ENDS   '2034-08-30 01:20:30'
    DO DO 1+1;

let $created=`SELECT created FROM INFORMATION_SCHEMA.EVENTS
              WHERE EVENT_NAME='my_event'`;
let $wait_condition =
  SELECT last_executed IS NOT NULL
  FROM INFORMATION_SCHEMA.EVENTS WHERE event_name = 'my_event';
     FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_NAME='my_event';
SET TIMESTAMP= UNIX_TIMESTAMP('2019-08-01 01:20:50');
ALTER EVENT my_event COMMENT 'event comment';
let $last_altered=`SELECT LAST_ALTERED FROM INFORMATION_SCHEMA.EVENTS
                   WHERE EVENT_NAME='my_event'`;
            (LAST_ALTERED - TIMESTAMP('$last_altered'))
     FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_NAME='my_event';
SET TIME_ZONE= '-02:00';
            (LAST_ALTERED - CONVERT_TZ('$last_altered', '+03:00', '-02:00'))
     FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_NAME='my_event';

-- Cleanup
DROP EVENT my_event;
SET TIME_ZONE=default;
SET TIMESTAMP=default;
CREATE EVENT e ON SCHEDULE AT ROW(1, 2) DO SELECT 1;
CREATE EVENT e ON SCHEDULE EVERY ROW(1, 2) HOUR DO SELECT 1;
CREATE EVENT e ON SCHEDULE EVERY 1 HOUR STARTS ROW(1, 2) DO SELECT 1;
CREATE EVENT e ON SCHEDULE EVERY 1 HOUR ENDS ROW(1, 2) DO SELECT 1;

-- Ensure that all event executors have finished their work and cannot harm
-- the next test.
--source include/no_running_events.inc

DROP DATABASE events_test;
SET GLOBAL event_scheduler= 'ON';
SET @@global.concurrent_insert= @concurrent_insert;
