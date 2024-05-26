select * from t1;
select * from t1;
drop table t1;
create table t1 (t time);
insert into t1 values ('09:00:00'),('13:00:00'),('19:38:34'), ('13:00:00'),('09:00:00'),('09:00:00'),('13:00:00'),('13:00:00'),('13:00:00'),('09:00:00');
select t, time_to_sec(t),sec_to_time(time_to_sec(t)) from t1;
select sec_to_time(time_to_sec(t)) from t1;
drop table t1;
CREATE TABLE t1 (t TIME);
INSERT INTO t1 VALUES (+10), (+10.0), (+10e0);
INSERT INTO t1 VALUES (-10), (-10.0), (-10e0);
SELECT * FROM t1;
DROP TABLE t1;
SELECT CAST(235959.123456 AS TIME);
select cast('100:55:50' as time) < cast('24:00:00' as time);
select cast('100:55:50' as time) < cast('024:00:00' as time);
select cast('300:55:50' as time) < cast('240:00:00' as time);
select cast('100:55:50' as time) > cast('24:00:00' as time);
select cast('100:55:50' as time) > cast('024:00:00' as time);
select cast('300:55:50' as time) > cast('240:00:00' as time);
create table t1 (f1 time);
insert into t1 values ('24:00:00');
select cast('24:00:00' as time) = (select f1 from t1);
drop table t1;
create table t1(f1 time, f2 time);
insert into t1 values('20:00:00','150:00:00');
select 1 from t1 where cast('100:00:00' as time) between f1 and f2;
drop table t1;
CREATE TABLE  t1 (
  f2 date NOT NULL,
  f3 int(11) unsigned NOT NULL default '0',
  PRIMARY KEY  (f3, f2)
);
insert into t1 values('2007-07-01', 1);
insert into t1 values('2007-07-01', 2);
insert into t1 values('2007-07-02', 1);
insert into t1 values('2007-07-02', 2);
SELECT sum(f3) FROM t1 where f2='2007-07-01 00:00:00' group by f2;
drop table t1;
CREATE TABLE t1 (c TIME);
INSERT INTO t1 VALUES ('0:00:00');
DROP TABLE t1;
CREATE TABLE t1(f1 TIME);
INSERT INTO t1 VALUES ('23:38:57');
SELECT TIMESTAMP(f1,'1') FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (f1 TIME);
INSERT INTO t1 VALUES ('24:00:00');
SELECT      '24:00:00' = (SELECT f1 FROM t1);
SELECT CAST('24:00:00' AS TIME) = (SELECT f1 FROM t1);
SELECT CAST('-24:00:00' AS TIME) = (SELECT f1 FROM t1);
INSERT INTO t1 VALUES ('-24:00:00');
DROP TABLE t1;
CREATE TABLE t1 (a TIME);
INSERT INTO t1 VALUES ('20:00:00'),('19:20:30');
SELECT * FROM t1 WHERE a<=>'19:20:30';
SELECT * FROM t1 WHERE a<=>TIME'19:20:30';
SELECT * FROM t1 WHERE a<=>192030;
DROP TABLE t1;
CREATE TABLE t1 (a TIME);
INSERT INTO t1 VALUES ('10:10:10.9999994'), ('10:10:10.9999995');
INSERT INTO t1 VALUES (101010.9999994), (101010.9999995);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a TIME);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (-106059), (-105960);
DROP TABLE t1;
SELECT TIME('1000009:10:10');
SELECT COALESCE(TIME(NULL));
CREATE TABLE t1 (a TIME);
INSERT INTO t1 VALUES (NULL);
SELECT * FROM t1 WHERE a NOT IN (TIME'20:20:20',TIME'10:10:10');
DROP TABLE t1;
CREATE TABLE t1 (a TIME);
INSERT INTO t1 VALUES ('10:10:10');
DROP TABLE t1;
CREATE TABLE t1 (a TIME);
INSERT INTO t1 VALUES ('10:10:10');
DROP TABLE t1;
CREATE TABLE t1 (a DATE);
DROP TABLE t1;
CREATE TABLE t1 (col_time_key TIME, KEY(col_time_key)) ENGINE=InnoDB;
INSERT INTO t1 VALUES ('00:00:00'),('-24:00:00'),('-48:00:00'),('24:00:00'),('48:00:00');
CREATE TABLE t2 (col_datetime_key DATETIME, KEY(col_datetime_key)) ENGINE=InnoDB;
INSERT INTO t2 SELECT * FROM t1;
DROP TABLE t1,t2;
CREATE TABLE t1 (
  pk INT NOT NULL AUTO_INCREMENT,
  col_int_nokey INT,
  col_int_key INT NOT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) ENGINE=InnoDB;
INSERT INTO t1 VALUES (10,1,7), (11,7,0), (12,4,9), (13,7,3),
(14,0,4), (15,2,2), (16,9,5), (17,4,3), (18,0,1), (19,9,3), (20,1,6),
(21,3,7), (22,8,5), (23,8,1), (24,18,204), (25,84,224), (26,6,9),
(27,3,5), (28,6,0), (29,6,3);
CREATE TABLE t2 (
  col_int_nokey INT NOT NULL,
  col_datetime_key DATETIME NOT NULL,
  col_varchar_key VARCHAR(1) NOT NULL,
  KEY col_datetime_key (col_datetime_key),
  KEY col_varchar_key (col_varchar_key)
) ENGINE=InnoDB;
INSERT INTO t2 VALUES (1,'2001-11-04 19:07:55','k');
CREATE TABLE t3 (
  col_time_key TIME,
  KEY col_time_key (col_time_key)
) ENGINE=InnoDB;
INSERT INTO t3 VALUES ('21:22:34'), ('10:50:38'), ('00:21:38'),
('04:08:02'), ('16:25:11'), ('10:14:58'), ('19:47:59'), ('11:14:24'),
('00:00:00'), ('00:00:00'), ('15:57:25'), ('07:05:51'), ('19:22:21'),
('03:53:16'), ('09:16:38'), ('15:37:26'), ('00:00:00'), ('05:03:03'),
('02:59:24'), ('00:01:58');
DROP TABLE t1,t2,t3;
prepare stmt from "SELECT TIME'01:01:01' = ?";
prepare stmt from "SELECT TIME'01:01:01' = ?";
prepare stmt from "SELECT TIME'01:01:01' = ?";
prepare stmt from "SELECT TIME'01:01:01' = ?";
prepare stmt from "SELECT TIME'01:01:01' = ?";
prepare stmt from "SELECT TIME'01:01:01' = ?";
prepare stmt from "SELECT TIME'01:01:01' = ?";
prepare stmt from "SELECT TIME'01:01:01' = ?";
prepare stmt from "SELECT TIME'01:01:01' = ?";
prepare stmt from "SELECT TIME'01:01:01' = ?";
prepare stmt from "SELECT TIME'01:01:01' = ?";
prepare stmt from "SELECT TIME'01:01:01' = ?";
prepare stmt from "SELECT TIME'01:01:01' = ?";
deallocate prepare stmt;
prepare ps from "SELECT TIME'01:01:01' = ?";
CREATE TABLE t1(t TIME);
prepare s from "INSERT INTO t1 VALUES (?)";
DROP TABLE t1;
CREATE TABLE t(t TIME);
CREATE TABLE dt(dt DATETIME);
INSERT INTO t VALUES('2021-10-10 00:00:00.123456+01:00');
INSERT INTO dt VALUES('2021-10-10 00:00:00.123456+01:00');
INSERT INTO t SELECT * FROM dt;
prepare s from "INSERT INTO t VALUES(?)";
SELECT * FROM t;
DROP TABLE t, dt;
CREATE TABLE t(a VARCHAR(100), KEY(a));
INSERT INTO t VALUES ('1:2:3'), ('01:02:03');
SELECT * FROM t WHERE a = TIME'01:02:03';
DROP TABLE t;
CREATE TABLE t (a VARCHAR(10), b VARCHAR(10));
INSERT INTO t VALUES
  ('01:02:03', '01:02:03'),
  ('01:02:03', '1:2:3'),
  ('1:2:3',    '01:02:03'),
  ('1:2:3',    '1:2:3');
SELECT * FROM t WHERE a = b and b = TIME'01:02:03';
DROP TABLE t;
CREATE TABLE t(a TIME, KEY(a));
INSERT INTO t VALUES ('01:02:03');
SELECT * FROM t WHERE a = CURRENT_TIME;
SELECT * FROM t WHERE a = CURRENT_TIMESTAMP;
SELECT * FROM t WHERE a = CURRENT_DATE;
DROP TABLE t;
