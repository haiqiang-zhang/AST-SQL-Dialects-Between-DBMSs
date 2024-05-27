CREATE DATABASE IF NOT EXISTS events_test;
CREATE TABLE table_1(a int);
CREATE TABLE table_2(a int);
CREATE TABLE table_3(a int);
CREATE TABLE table_4(a int);
CREATE EVENT event_1 ON SCHEDULE EVERY 2 SECOND
DO
  INSERT INTO table_1 VALUES (1);
CREATE EVENT event_2 ON SCHEDULE EVERY 1 SECOND
ENDS NOW() + INTERVAL 6 SECOND
ON COMPLETION PRESERVE
DO
  INSERT INTO table_2 VALUES (1);
CREATE EVENT event_3 ON SCHEDULE EVERY 2 SECOND ENDS NOW() + INTERVAL 1 SECOND
ON COMPLETION NOT PRESERVE
DO
  INSERT INTO table_3 VALUES (1);
CREATE EVENT event_4 ON SCHEDULE EVERY 1 SECOND ENDS NOW() + INTERVAL 1 SECOND
ON COMPLETION PRESERVE
DO
  INSERT INTO table_4 VALUES (1);