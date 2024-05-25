drop table if exists t1, t2;
drop function if exists f1;
create table t1 (ts timestamp);
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
select convert_tz('1970-01-01 01:00:00', 'MET', 'UTC');
select convert_tz('1970-01-01 01:00:01', 'MET', 'UTC');
select convert_tz('2003-03-01 00:00:00', 'MET', 'UTC');
select convert_tz('2003-03-30 01:59:59', 'MET', 'UTC');
select convert_tz('2003-03-30 02:30:00', 'MET', 'UTC');
select convert_tz('2003-03-30 03:00:00', 'MET', 'UTC');
select convert_tz('2003-05-01 00:00:00', 'MET', 'UTC');
select convert_tz('2003-10-26 01:00:00', 'MET', 'UTC');
select convert_tz('2003-10-26 02:00:00', 'MET', 'UTC');
select convert_tz('2003-10-26 02:59:59', 'MET', 'UTC');
select convert_tz('2003-10-26 04:00:00', 'MET', 'UTC');
select convert_tz('2038-01-19 04:14:07', 'MET', 'UTC');
create table t1 (tz varchar(3));
insert into t1 (tz) values ('MET'), ('UTC');
select tz, convert_tz('2003-12-31 00:00:00',tz,'UTC'), convert_tz('2003-12-31 00:00:00','UTC',tz) from t1 order by tz;
drop table t1;
select convert_tz('2003-12-31 04:00:00', NULL, 'UTC');
select convert_tz('2003-12-31 04:00:00', 'SomeNotExistingTimeZone', 'UTC');
select convert_tz('2003-12-31 04:00:00', 'MET', 'SomeNotExistingTimeZone');
select convert_tz('2003-12-31 04:00:00', 'MET', NULL);
select convert_tz( NULL, 'MET', 'UTC');
create table t1 (ts timestamp);
insert into t1 (ts) values (now());
select convert_tz(ts, @@time_zone, 'Japan') from t1;
drop table t1;
select convert_tz('2005-01-14 17:00:00', 'UTC', custTimeZone) from (select 'UTC' as custTimeZone) as tmp;
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
SELECT CONVERT_TZ(1, a, 1) FROM t1;
SELECT CONVERT_TZ(1, 1, a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a TIMESTAMP, b VARCHAR(30));
SELECT a, UNIX_TIMESTAMP(a), b FROM t1;
DROP TABLE t1;
SELECT UNIX_TIMESTAMP('2003-03-30 01:59:59'), 'Before the gap' AS b;
SELECT UNIX_TIMESTAMP('2003-03-30 02:30:00'), 'Inside the gap' AS b;
SELECT UNIX_TIMESTAMP('2003-03-30 03:00:00'), 'After the gap' AS b;
SELECT FROM_UNIXTIME(0);
SELECT UNIX_TIMESTAMP("1969-12-31 15:59:59");
SELECT UNIX_TIMESTAMP("1969-12-31 16:00:00");
SELECT UNIX_TIMESTAMP("1969-12-31 16:00:01");
SELECT UNIX_TIMESTAMP("1970-01-01 00:00:01");
SELECT UNIX_TIMESTAMP("2022-01-01 16:00:01");
