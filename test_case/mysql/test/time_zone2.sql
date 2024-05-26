select unix_timestamp(utc_timestamp())-unix_timestamp(current_timestamp());
select unix_timestamp(utc_timestamp())-unix_timestamp(current_timestamp());
select unix_timestamp(utc_timestamp())-unix_timestamp(current_timestamp());
select * from t1;
drop table t1;
create table t1 (i int, ts timestamp);
insert into t1 (i, ts) values
  (unix_timestamp('2003-03-01 00:00:00'),'2003-03-01 00:00:00');
insert into t1 (i, ts) values
  (unix_timestamp('2003-05-01 00:00:00'),'2003-05-01 00:00:00');
insert into t1 (i, ts) values
  (unix_timestamp('2003-10-26 01:00:00'),'2003-10-26 01:00:00'),
  (unix_timestamp('2003-10-26 02:00:00'),'2003-10-26 02:00:00'),
  (unix_timestamp('2003-10-26 02:59:59'),'2003-10-26 02:59:59'),
  (unix_timestamp('2003-10-26 04:00:00'),'2003-10-26 04:00:00'),
  (unix_timestamp('2003-10-26 02:59:59'),'2003-10-26 02:59:59');
select * from t1;
select * from t1;
select * from t1;
insert into t1 (i, ts) values
  (unix_timestamp('1981-07-01 03:59:59'),'1981-07-01 03:59:59'),
  (unix_timestamp('1981-07-01 04:00:00'),'1981-07-01 04:00:00');
select * from t1;
select from_unixtime(362793609);
drop table t1;
create table t1 (ts timestamp);
select * from t1;
select * from t1;
select * from t1;
drop table t1;
select convert_tz(now(),'UTC', 'Universal') = now();
select convert_tz(now(),'utc', 'UTC') = now();
select convert_tz('1917-11-07 12:00:00', 'MET', 'UTC');
create table t1 (tz varchar(3));
insert into t1 (tz) values ('MET'), ('UTC');
drop table t1;
create table t1 (ts timestamp);
insert into t1 (ts) values (now());
drop table t1;
create table t1 select convert_tz(NULL, NULL, NULL);
select * from t1;
drop table t1;
create table t1 (ldt datetime, udt datetime);
insert into t1 (ldt) values ('2006-04-19 16:30:00');
select * from t1;
drop table t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (t TIMESTAMP);
INSERT INTO t1 VALUES (NULL), (NULL);
LOCK TABLES t1 WRITE;
SELECT CONVERT_TZ(NOW(), 'UTC', 'Europe/Moscow') IS NULL;
UPDATE t1 SET t = CONVERT_TZ(t, 'UTC', 'Europe/Moscow');
UNLOCK TABLES;
DROP TABLE t1;
CREATE TABLE t1 (a SET('x') NOT NULL);
INSERT INTO t1 VALUES ('');
DROP TABLE t1;
CREATE TABLE t1 (a TIMESTAMP, b VARCHAR(30));
SELECT a, UNIX_TIMESTAMP(a), b FROM t1;
DROP TABLE t1;
SELECT FROM_UNIXTIME(0);
