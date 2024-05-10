drop database if exists events_test;
drop database if exists mysqltest_db1;
drop database if exists mysqltest_db2;
create database events_test;
select * from performance_schema.global_variables where variable_name like 'event_scheduler';
CREATE EVENT lower_case ON SCHEDULE EVERY 1 MINUTE DO SELECT 1;
DROP EVENT Lower_case;
CREATE EVENT ÃÂ¤ÃÂ®ÃÂ«ÃÂ¥ÃÂ­_ÃÂ°ÃÂ¥ÃÂ£ÃÂ¨ÃÂ±ÃÂ²ÃÂºÃÂ°_1251 ON SCHEDULE EVERY 1 YEAR DO SELECT 100;
CREATE EVENT ÃÂÃÂ®ÃÂÃÂ¥ÃÂ_ÃÂ°ÃÂ¥ÃÂ£ÃÂ¨ÃÂ±ÃÂ²ÃÂºÃÂ°_1251 ON SCHEDULE EVERY 2 YEAR DO SELECT 200;
DROP EVENT ÃÂÃÂ®ÃÂÃÂ¥ÃÂ_ÃÂ°ÃÂ¥ÃÂ£ÃÂ¨ÃÂ±ÃÂ²ÃÂºÃÂ°_1251;
create event e_55 on schedule at 20000101000000 do drop table t;
select get_lock('test_bug16407', 60);
select count(*) > 0 from information_schema.processlist
  where state = 'User lock' and info = 'select get_lock(\'test_bug16407\', 60)';
select /*1*/ user, host, db, info from information_schema.processlist
where state = 'User lock' and info = 'select get_lock(\'test_bug16407\', 60)';
select release_lock('test_bug16407');
select count(*) = 0 from information_schema.processlist
  where state = 'User lock' and info = 'select get_lock(\'test_bug16407\', 60)';
SELECT * FROM information_schema.processlist;
select event_schema, event_name, sql_mode from information_schema.events order by event_schema, event_name;
select event_schema, event_name, sql_mode from information_schema.events order by event_schema, event_name;
select get_lock('ee_16407_2', 60);
create table events_smode_test(ev_name char(10), a date);
select release_lock('ee_16407_2');
select release_lock('ee_16407_2');
select release_lock('ee_16407_2');
select event_schema, event_name, sql_mode from information_schema.events order by event_schema, event_name;
select count(*) = 3 from information_schema.processlist
  where state = 'User lock' and info = 'select get_lock(\'ee_16407_2\', 60)';
select /*2*/ user, host, db, info from information_schema.processlist
where state = 'User lock' and info = 'select get_lock(\'ee_16407_2\', 60)';
select release_lock('ee_16407_2');
select count(*) = 0
  from information_schema.processlist
  where state = 'User lock' and info = 'select get_lock(\'ee_16407_2\', 60)';
SELECT * FROM information_schema.processlist;
select /*3*/ user, host, db, info from information_schema.processlist
where state = 'User lock' and info = 'select get_lock(\'ee_16407_2\', 60)';
select event_schema, event_name, sql_mode from information_schema.events order by event_schema, event_name;
select get_lock('ee_16407_5', 60);
select release_lock('ee_16407_5');
select release_lock('ee_16407_5');
select count(*) = 2 from information_schema.processlist
  where state = 'User lock' and info = 'select get_lock(\'ee_16407_5\', 60)';
select /*4*/ user, host, db, info from information_schema.processlist
where state = 'User lock' and info = 'select get_lock(\'ee_16407_5\', 60)';
select release_lock('ee_16407_5');
select count(*) = 0 from information_schema.processlist
  where state = 'User lock' and info = 'select get_lock(\'ee_16407_5\', 60)';
select /*5*/ user, host, db, info from information_schema.processlist
where state = 'User lock' and info = 'select get_lock(\'ee_16407_5\', 60)';
select event_schema, event_name, sql_mode from information_schema.events order by event_schema, event_name;
drop table events_smode_test;
drop database if exists mysqltest_db1;
create database mysqltest_db1;
create event mysqltest_user1 on schedule every 10 second do select 42;
select database();
select event_schema, event_name, definer, event_type, status from information_schema.events;
drop database mysqltest_db1;
drop event if exists e_16;
drop procedure if exists p_16;
create event e_16 on schedule every 1 second do set @a=5;
create procedure p_16 () alter event e_16 on schedule every @a second;
drop procedure p_16;
drop event e_16;
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
select get_lock('ee_22830', 60);
select release_lock('ee_22830');
select 123;
select event_name, event_definition, interval_value, interval_field from information_schema.events order by event_name;
select release_lock('ee_22830');
select group_concat(interval_value order by interval_value) = '1,1,1,8'
  from information_schema.events;
select event_name, event_definition, interval_value, interval_field from information_schema.events order by event_name;
drop table t1;
drop table t2;
CREATE EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;
CREATE DEFINER=CURRENT_USER EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;
CREATE DEFINER=CURRENT_USER() EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
CREATE EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;
CREATE DEFINER=CURRENT_USER EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;
CREATE DEFINER=CURRENT_USER() EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, definer FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT e1;
CREATE EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
ALTER EVENT e1 ON SCHEDULE EVERY 1 DAY STARTS '2000-01-01 00:00:00';
ALTER EVENT e1 ON SCHEDULE AT '2000-01-02 00:00:00'
  ON COMPLETION PRESERVE DISABLE;
ALTER EVENT e1 ON SCHEDULE EVERY 1 DAY ENDS '2038-01-03 00:00:00'
  ON COMPLETION PRESERVE DISABLE;
ALTER EVENT e1 DO SELECT 2;
DROP EVENT e1;
CREATE EVENT e1 ON SCHEDULE EVERY 1 DAY STARTS '2006-01-01 00:00:00' DO
  SELECT 1;
CREATE EVENT e2 ON SCHEDULE EVERY 1 DAY STARTS '2006-01-01 00:00:00' DO
  SELECT 1;
CREATE EVENT e3 ON SCHEDULE EVERY 1 DAY STARTS '2006-01-01 00:00:00' DO
  SELECT 1;
SELECT * FROM INFORMATION_SCHEMA.EVENTS ORDER BY event_name;
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
drop event if exists new_event;
CREATE TABLE events_test.event_log
(id int KEY AUTO_INCREMENT, ev_nm char(40), ev_cnt int, ev_tm timestamp);
DROP TABLE events_test.event_log;
DROP EVENT IF EXISTS e1;
DROP EVENT IF EXISTS e2;
CREATE EVENT e1 ON SCHEDULE AT '2038-01-01 00:00:00' DO SET @a = 1;
ALTER EVENT e1 COMMENT 'comment';
DROP EVENT e1;
CREATE EVENT e1 ON SCHEDULE AT '2038-01-01 00:00:00' DO SET @a = 1;
ALTER EVENT e1 COMMENT 'comment';
DROP EVENT e1;
CREATE EVENT e1 ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 SECOND DO SET @a = 1;
CREATE EVENT e2 ON SCHEDULE EVERY 1 SECOND DO SET @a = 1;
SELECT
  event_name,
  last_executed IS NULL,
  definer
FROM INFORMATION_SCHEMA.EVENTS
WHERE event_schema = 'events_test';
SELECT COUNT(*) = 0
  FROM INFORMATION_SCHEMA.EVENTS
  WHERE event_schema = 'events_test' AND event_name = 'e1';
SELECT last_executed IS NOT NULL
  FROM INFORMATION_SCHEMA.EVENTS
  WHERE event_schema = 'events_test' AND event_name = 'e2';
SELECT
  event_name,
  last_executed IS NULL,
  definer
FROM INFORMATION_SCHEMA.EVENTS
WHERE event_schema = 'events_test';
DROP EVENT e1;
DROP EVENT e2;
drop procedure if exists p;
create event e1 on schedule every 1 day do select 1;
select @@sql_mode into @full_mode;
select event_name from information_schema.events where event_name = 'e1' and sql_mode = @full_mode;
drop event e1;
SELECT @@GLOBAL.server_id;
CREATE EVENT ev1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
SELECT event_name, originator FROM INFORMATION_SCHEMA.EVENTS;
DROP EVENT ev1;
CREATE DATABASE event_test12;
CREATE EVENT ev1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;
CREATE DATABASE event_test1;
DROP DATABASE event_test1;
DROP DATABASE event_test12;
DROP TABLE IF EXISTS table_bug12546938;
DROP EVENT IF EXISTS event_Bug12546938;
CREATE TABLE table_bug12546938 (i INT);
SELECT COUNT(*) FROM table_bug12546938;
DROP EVENT IF EXISTS event_Bug12546938;
DROP TABLE table_bug12546938;
DROP DATABASE IF EXISTS event_test11764334;
CREATE DATABASE event_test11764334;
ALTER EVENT ev1 ON SCHEDULE EVERY 4 SECOND;
DROP EVENT ev1;
DROP DATABASE event_test11764334;
CREATE EVENT e1 ON SCHEDULE EVERY 2 HOUR DO SELECT 1;
ALTER EVENT e1 ON SCHEDULE EVERY
EXISTS (SELECT 1 AS x ORDER BY x LIMIT 0) NOT IN (2) MINUTE_SECOND;
DROP EVENT e1;
CREATE TABLE t1(_userid CHAR (1)KEY) ENGINE=InnoDB;
CREATE EVENT e1 ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 DAY DO INSERT INTO t1 VALUES(1);
SELECT SLEEP(3);
DROP TABLE t1;
CREATE EVENT cafe ON SCHEDULE EVERY 2 YEAR DO SELECT 1;
CREATE EVENT cafÃÂÃÂ© ON SCHEDULE EVERY 2 YEAR DO SELECT 1;
DROP EVENT CaFÃÂÃÂ©;
CREATE EVENT my_event
    ON SCHEDULE EVERY 2 SECOND
      STARTS '2019-08-01 01:20:30'
      ENDS   '2034-08-30 01:20:30'
    DO DO 1+1;
SELECT last_executed IS NOT NULL
  FROM INFORMATION_SCHEMA.EVENTS WHERE event_name = 'my_event';
ALTER EVENT my_event COMMENT 'event comment';
DROP EVENT my_event;
DROP DATABASE events_test;
