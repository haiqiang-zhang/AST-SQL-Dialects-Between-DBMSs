
CREATE DATABASE IF NOT EXISTS events_test;
CREATE DATABASE events_conn1_test2;
CREATE TABLE events_test.fill_it1(test_name varchar(20), occur datetime);
CREATE TABLE events_test.fill_it2(test_name varchar(20), occur datetime);
CREATE TABLE events_test.fill_it3(test_name varchar(20), occur datetime);
CREATE USER event_user2@localhost;
CREATE DATABASE events_conn2_db;
CREATE USER event_user3@localhost;
CREATE DATABASE events_conn3_db;
let $1= 50;
{
  eval CREATE EVENT conn2_ev$1 ON SCHEDULE EVERY 1 SECOND DO INSERT INTO events_test.fill_it1 VALUES("conn2_ev$1", NOW());
  dec $1;
let $1= 50;
{
  eval CREATE EVENT conn3_ev$1 ON SCHEDULE EVERY 1 SECOND DO INSERT INTO events_test.fill_it1 VALUES("conn3_ev$1", NOW());
  dec $1;
USE events_conn1_test2;
CREATE EVENT ev_drop1 ON SCHEDULE EVERY 10 MINUTE DISABLE DO SELECT 1;
CREATE EVENT ev_drop2 ON SCHEDULE EVERY 10 MINUTE DISABLE DO SELECT 1;
CREATE EVENT ev_drop3 ON SCHEDULE EVERY 10 MINUTE DISABLE DO SELECT 1;
USE events_test;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_SCHEMA='events_conn1_test2';
DROP DATABASE events_conn1_test2;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_SCHEMA='events_conn1_test2';
CREATE DATABASE events_conn1_test2;
USE events_conn1_test2;
let $1= 50;
{
  eval CREATE EVENT conn1_round1_ev$1 ON SCHEDULE EVERY 1 SECOND DO INSERT INTO events_test.fill_it2 VALUES("conn1_round1_ev$1", NOW());
  dec $1;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_SCHEMA='events_conn1_test2';
SET GLOBAL event_scheduler=on;
DROP DATABASE events_conn1_test2;

SET GLOBAL event_scheduler=off;

SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_SCHEMA='events_conn1_test2';
CREATE DATABASE events_conn1_test3;
USE events_conn1_test3;
let $1= 50;
{
  eval CREATE EVENT conn1_round2_ev$1 ON SCHEDULE EVERY 1 SECOND DO INSERT INTO events_test.fill_it2 VALUES("conn1_round2_ev$1", NOW());
  dec $1;
SET GLOBAL event_scheduler=on;

SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_SCHEMA='events_conn1_test3';
CREATE DATABASE events_conn1_test4;
USE events_conn1_test4;
let $1= 50;
{
  eval CREATE EVENT conn1_round3_ev$1 ON SCHEDULE EVERY 1 SECOND DO INSERT INTO events_test.fill_it3 VALUES("conn1_round3_ev$1", NOW());
  dec $1;

CREATE DATABASE events_conn1_test2;
USE events_conn1_test2;
let $1= 50;
{
  eval CREATE EVENT ev_round4_drop$1 ON SCHEDULE EVERY 1 SECOND DO INSERT INTO events_test.fill_it3 VALUES("conn1_round4_ev$1", NOW());
  dec $1;
SELECT COUNT(*) FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_SCHEMA='events_conn1_test2';
DROP DATABASE events_conn2_db;
DROP DATABASE events_conn3_db;
DROP DATABASE events_conn1_test2;
DROP DATABASE events_conn1_test3;
SET GLOBAL event_scheduler=off;
DROP DATABASE events_conn1_test4;
SET GLOBAL event_scheduler=on;
USE events_test;
DROP TABLE fill_it1;
DROP TABLE fill_it2;
DROP TABLE fill_it3;
DROP USER event_user2@localhost;
DROP USER event_user3@localhost;
--

DROP DATABASE events_test;
