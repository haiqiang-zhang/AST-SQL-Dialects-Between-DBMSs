
-- changes 2008-02-20 hhunger splitted events.test into events_1 and events_2
-- changes 2008-02-22 hhunger replaced all sleep by wait_condition
--

--disable_warnings
drop database if exists events_test;
drop database if exists db_x;
drop database if exists mysqltest_db2;
drop database if exists mysqltest_no_such_database;
create database events_test;
use events_test;

--
-- START:  BUG #17289 Events: missing privilege check for drop database
--
CREATE USER pauline@localhost;
CREATE DATABASE db_x;
USE db_x;
CREATE TABLE x_table(a int);
CREATE EVENT e_x1 ON SCHEDULE EVERY 1 SECOND DO DROP DATABASE db_x;
CREATE EVENT e_x2 ON SCHEDULE EVERY 1 SECOND DO DROP TABLE x_table;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE user = 'event_scheduler' AND command = 'Daemon';
let $wait_condition= SELECT count(*)= 1 FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME LIKE 'db_x';
DROP EVENT e_x1;
DROP EVENT e_x2;
DROP DATABASE db_x;
DROP USER pauline@localhost;
USE events_test;

--
-- END:    BUG #17289 Events: missing privilege check for drop database
--
SET GLOBAL event_scheduler=off;
drop event if exists event1;
create event event1 on schedule every 15 minute starts now() ends date_add(now(), interval 5 hour) DO begin end;
alter event event1 rename to event2 enable;
alter event event2 disable;
alter event event2 enable;
alter event event2 on completion not preserve;
alter event event2 on schedule every 1 year on completion preserve rename to event3 comment "new comment" do begin select 1;
alter event event3 rename to event2;

drop event event2;
create event event2 on schedule every 2 second starts now() ends date_add(now(), interval 5 hour) comment "some" DO begin end;
drop event event2;
CREATE EVENT event_starts_test ON SCHEDULE EVERY 10 SECOND COMMENT "" DO SELECT 1;

SELECT interval_field, interval_value, event_definition FROM information_schema.events WHERE event_name='event_starts_test';
SELECT execute_at IS NULL, starts IS NULL, ends IS NULL, event_comment FROM information_schema.events WHERE event_schema='events_test' AND event_name='event_starts_test';
ALTER EVENT event_starts_test ON SCHEDULE AT date_add(now(), interval 5 day);
SELECT execute_at IS NULL, starts IS NULL, ends IS NULL, event_comment FROM information_schema.events WHERE event_schema='events_test' AND event_name='event_starts_test';
ALTER EVENT event_starts_test COMMENT "non-empty comment";
SELECT execute_at IS NULL, starts IS NULL, ends IS NULL, event_comment FROM information_schema.events WHERE event_schema='events_test' AND event_name='event_starts_test';
ALTER EVENT event_starts_test COMMENT "";
SELECT execute_at IS NULL, starts IS NULL, ends IS NULL, event_comment FROM information_schema.events WHERE event_schema='events_test' AND event_name='event_starts_test';
DROP EVENT event_starts_test;

CREATE EVENT event_starts_test ON SCHEDULE EVERY 20 SECOND STARTS date_add(now(), interval 5 day) ENDS date_add(now(), interval 10 day) DO SELECT 2;
SELECT execute_at IS NULL, starts IS NULL, ends IS NULL, event_comment FROM information_schema.events WHERE event_schema='events_test' AND event_name='event_starts_test';
ALTER EVENT event_starts_test COMMENT "non-empty comment";
SELECT execute_at IS NULL, starts IS NULL, ends IS NULL, event_comment FROM information_schema.events WHERE event_schema='events_test' AND event_name='event_starts_test';
ALTER EVENT event_starts_test COMMENT "";
SELECT execute_at IS NULL, starts IS NULL, ends IS NULL, event_comment FROM information_schema.events WHERE event_schema='events_test' AND event_name='event_starts_test';
DROP EVENT event_starts_test;
create table test_nested(a int);
create event e_43 on schedule every 1 second do set @a = 5;
alter event e_43 do alter event e_43 do set @a = 4;
alter event e_43 do
begin
  alter event e_43 on schedule every 5 minute;
  insert into test_nested values(1);
set global event_scheduler = on;

let $wait_condition= SELECT count(*)>0 from information_schema.events where event_name='e_43' and interval_value= 5;
select event_name, event_definition, status, interval_field, interval_value from information_schema.events;
drop event e_43;
drop table test_nested;
create table non_qualif(a int);
create event non_qualif_ev on schedule every 10 minute do insert into non_qualif values (800219);
let $wait_condition=SELECT count(*)= 1 from non_qualif where a=800219;
select * from non_qualif;
drop event non_qualif_ev;
drop table non_qualif;
alter event non_existant rename to non_existant_too;

create event existant on schedule at now() + interval 1 year do select 12;
alter event non_existant rename to existant;
alter event existant rename to events_test.existant;
drop event existant;


create table t_event3 (a int, b float);
drop event if exists event3;
create event event3 on schedule every 50 + 10 minute starts date_add(curdate(), interval 5 minute) ends date_add(curdate(), interval 5 day) comment "portokala_comment" DO insert into t_event3 values (unix_timestamp(), rand());
let $wait_condition=SELECT count(*)=0 from t_event3;
select count(*) from t_event3;
drop event event3;
drop table t_event3;


set names utf8mb3;
CREATE EVENT root6 ON SCHEDULE EVERY '10:20' MINUTE_SECOND ON COMPLETION PRESERVE ENABLE COMMENT 'some comment' DO select 1;
create event root7 on schedule every 2 year do select 1;
create event root8 on schedule every '2:5' year_month do select 1;
create event root8_1 on schedule every '2:15' year_month do select 1;
create event root9 on schedule every 2 week ON COMPLETION PRESERVE DISABLE COMMENT 'коментар на кирилица' do select 1;
create event root10 on schedule every '20:5' day_hour do select 1;
create event root11 on schedule every '20:25' day_hour do select 1;
create event root12 on schedule every '20:25' hour_minute do select 1;
create event root13 on schedule every '25:25' hour_minute do select 1;
create event root13_1 on schedule every '11:65' hour_minute do select 1;
create event root14 on schedule every '35:35' minute_second do select 1;
create event root15 on schedule every '35:66' minute_second do select 1;
create event root16 on schedule every '35:56' day_minute do select 1;
create event root17 on schedule every '35:12:45' day_minute do select 1;
create event root17_1 on schedule every '35:25:65' day_minute do select 1;
create event root18 on schedule every '35:12:45' hour_second do select 1;
create event root19 on schedule every '15:59:85' hour_second do select 1;
create event root20 on schedule every '50:20:12:45' day_second do select 1;
set names cp1251;
create event ����21 on schedule every '50:23:59:95' day_second COMMENT '���� � 1251 ��������' do select 1;
CREATE DEFINER=user_name_robert_golebiowski1234@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char EVENT event_test ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR DO SELECT CURRENT_USER();

SELECT DEFINER FROM information_schema.EVENTS WHERE EVENT_NAME='event_test';

DROP EVENT event_test;
let $wait_condition=
  select count(*) = 0 from information_schema.processlist
  where db='events_test' and command = 'Connect' and user=current_user();
DROP DATABASE events_test;
