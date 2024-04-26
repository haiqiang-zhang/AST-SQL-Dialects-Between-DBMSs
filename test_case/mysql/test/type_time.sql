
--
-- testing of the TIME column type
--

--disable_warnings
drop table if exists t1;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create table t1 (t time);
insert into t1 values("10:22:33"),("12:34:56.78"),(10),(1234),(123456.78),(1234559.99),("1"),("1:23"),("1:23:45"), ("10.22"), ("-10  1:22:33.45"),("20 10:22:33"),("1999-02-03 20:33:34");
insert t1 values (30),(1230),("1230"),("12:30"),("12:30:35"),("1 12:30:31.32");
select * from t1;
insert into t1 values("10.22.22"),(1234567),(123456789),(123456789.10),("10 22:22"),("12.45a");
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

--
-- BUG #12440: Incorrect processing of time values containing
-- long fraction part and/or large exponent part.
--
SELECT CAST(235959.123456 AS TIME);
SELECT CAST(0.235959123456e+6 AS TIME);
SELECT CAST(235959123456e-6 AS TIME);

-- These must cut fraction part
SELECT CAST(235959.1234567 AS TIME);
SELECT CAST(0.2359591234567e6 AS TIME);

-- This must return NULL and produce warning:
SELECT CAST(0.2359591234567e+30 AS TIME);

--
-- Bug#29555: Comparing time values as strings may lead to a wrong result.
--
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

--
-- Bug#29739: Incorrect time comparison in BETWEEN.
--
create table t1(f1 time, f2 time);
insert into t1 values('20:00:00','150:00:00');
select 1 from t1 where cast('100:00:00' as time) between f1 and f2;
drop table t1;

--
-- Bug#29729: Wrong conversion error led to an empty result set.
--
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
SELECT CAST(c AS TIME) FROM t1;
DROP TABLE t1;
SET @@timestamp=UNIX_TIMESTAMP('2001-01-01 01:00:00');
CREATE TABLE t1(f1 TIME);
INSERT INTO t1 VALUES ('23:38:57');
SELECT TIMESTAMP(f1,'1') FROM t1;
DROP TABLE t1;
SET @@timestamp=default;

--
-- Bug#42664 - Sign ignored for TIME types when not comparing as longlong
--

CREATE TABLE t1 (f1 TIME);
INSERT INTO t1 VALUES ('24:00:00');
SELECT      '24:00:00' = (SELECT f1 FROM t1);
SELECT CAST('24:00:00' AS TIME) = (SELECT f1 FROM t1);
SELECT CAST('-24:00:00' AS TIME) = (SELECT f1 FROM t1);
INSERT INTO t1 VALUES ('-24:00:00');
SELECT CAST('24:00:00' AS TIME) = (SELECT f1 FROM t1);
SELECT CAST('-24:00:00' AS TIME) = (SELECT f1 FROM t1);
SELECT '-24:00:00' = (SELECT f1 FROM t1);
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
INSERT INTO t1 VALUES ('-10:60:59'), ('-10:59:60'), (-106059), (-105960);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (-106059), (-105960);
SELECT CAST(a AS TIME) FROM t1;
DROP TABLE t1;
SELECT TIME('1000009:10:10');
SELECT TIME('1000009:10:10.1999999999999');
SELECT TIME('10000090:10:10');
SELECT TIME('10000090:10:10.1999999999999');
SELECT TIME('100000900:10:10');
SELECT TIME('100000900:10:10.1999999999999');
SELECT TIME('1000009000:10:10');
SELECT TIME('1000009000:10:10.1999999999999');
SELECT TIME('10000090000:10:10');
SELECT TIME('10000090000:10:10.1999999999999');
SELECT CAST(IF(1, TIME'00:00:00',TIME'00:00:00') AS CHAR);
SELECT CAST(CASE WHEN 1 THEN TIME'00:00:00' ELSE TIME'00:00:00' END AS CHAR);
SELECT CAST(CASE WHEN 0 THEN '01:01:01' END AS TIME);
SELECT CAST(CASE WHEN 0 THEN TIME'01:01:01' END AS TIME);
SELECT COALESCE(TIME(NULL));
CREATE TABLE t1 (a TIME);
INSERT INTO t1 VALUES (NULL);
SELECT * FROM t1 WHERE a NOT IN (TIME'20:20:20',TIME'10:10:10');
DROP TABLE t1;
CREATE TABLE t1 (a TIME);
INSERT INTO t1 VALUES ('10:10:10');
SELECT CAST(COALESCE(a,a) AS SIGNED) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a TIME);
INSERT INTO t1 VALUES ('10:10:10');
SELECT CAST(COALESCE(a,a) AS DECIMAL(23,6)) FROM t1;
DROP TABLE t1;
SELECT CAST(COALESCE(10,20) AS TIME);
SELECT CAST(LEAST(DATE(NULL), DATE(NULL)) AS TIME);
SELECT CAST(LEAST(111111,222222) AS TIME);
SELECT CAST(SUM(0) AS TIME);
SELECT CAST(SUM(0 + 0e0) AS TIME);
SET timestamp=1322115328;
SELECT CAST(UNIX_TIMESTAMP() AS TIME);
SET timestamp=default;
SELECT TIME(154559.616 + 0e0);
SELECT TIME(NAME_CONST('a', 0));
CREATE TABLE t1 (a DATE);
INSERT INTO t1 VALUES (0);
SELECT TIME(MIN(a)) FROM t1;
DROP TABLE t1;

SET TIMESTAMP=UNIX_TIMESTAMP('2012-01-31 10:14:35');

CREATE TABLE t1 (col_time_key TIME, KEY(col_time_key)) ENGINE=InnoDB;
INSERT INTO t1 VALUES ('00:00:00'),('-24:00:00'),('-48:00:00'),('24:00:00'),('48:00:00');
CREATE TABLE t2 (col_datetime_key DATETIME, KEY(col_datetime_key)) ENGINE=InnoDB;
INSERT INTO t2 SELECT * FROM t1;

-- disable_result_log
ANALYZE TABLE t1;

let $cnt_0=5;
let $operator= =;
{  
  let $cnt_1=2;
  let $first_table=t1;
  -- for table in t1,t2
  while ($cnt_1)
  {
    if ($first_table==t1)
    {
      let $first_index=col_time_key;
      let $second_table=t2;
      let $second_index=col_datetime_key;
    }
    if ($first_table==t2)
    {
      let $first_index=col_datetime_key;
      let $second_table=t1;
      let $second_index=col_time_key;
    }
    let $cnt_2=2;
    let $first_index_hint=ignore;
    -- for first_index_hint in ignore,force
    while ($cnt_2)
    {
      let $cnt_3=2;
      let $second_index_hint=ignore;
      -- for second_index_hint in ignore, force
      while ($cnt_3)
      {
        let $cnt_4=2;
        let $first_operand=col_time_key;
        -- for first_operand in col_time_key, col_datetime_key
        while ($cnt_4)
        {
          if ($first_operand==col_time_key)
          {
            let $second_operand=col_datetime_key;
          }
          if ($first_operand==col_datetime_key)
          {
            let $second_operand=col_time_key;
          }
  
          eval EXPLAIN SELECT * FROM
               $first_table $first_index_hint INDEX ($first_index)
               STRAIGHT_JOIN
               $second_table $second_index_hint INDEX ($second_index)
               WHERE $first_operand $operator $second_operand;
          --sorted_result
          eval SELECT * FROM
               $first_table $first_index_hint INDEX ($first_index)
               STRAIGHT_JOIN
               $second_table $second_index_hint INDEX ($second_index)
               WHERE $first_operand $operator $second_operand;
  
          let $first_operand=col_datetime_key;
          dec $cnt_4;
        }
        let $second_index_hint=force;
        dec $cnt_3;
      }
      let $first_index_hint=force;
      dec $cnt_2;
    }
    let $first_table=t2;
    dec $cnt_1;
  }
  if ($cnt_0==5)
  {
    let $operator= >=;
  }
  if ($cnt_0==4)
  {
    let $operator= >;
  }
  if ($cnt_0==3)
  {
    let $operator= <=;
  }
  if ($cnt_0==2)
  {
    let $operator= <;
  }
  dec $cnt_0;

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

-- disable_result_log
ANALYZE TABLE t1;

let $query=SELECT * FROM t2 STRAIGHT_JOIN t3 FORCE INDEX (col_time_key)
           ON t3.col_time_key > t2.col_datetime_key;

let $query=SELECT * FROM t2 STRAIGHT_JOIN t3 IGNORE INDEX (col_time_key)
           ON t3.col_time_key > t2.col_datetime_key;

DROP TABLE t1,t2,t3;
SET TIMESTAMP = DEFAULT;
SET sql_mode = default;

-- Check prepared statements with various TIME comparisons

set @d_str = '2020-01-01';
set @t_str = '01:01:01';
set @dt_str = '2020-01-01 01:01:01';
set @dt_tz = '2020-01-01 01:01:01+03:00';
set @d_int = 20200101;
set @t_int = 010101;
set @dt_int = 20200101010101;
set @d_dec = 20200101.0;
set @t_dec = 010101.0;
set @dt_dec = 20200101010101.0;
set @d_flt = 20200101E0;
set @t_flt = 010101E0;
set @dt_flt = 20200101010101E0;

-- Executions that supply a numeric date literal will cause truncation warnings.
-- Executions that supply a string date literal is wrongly interpreted as a
-- time literal and the conversion will fail.
-- Executions that supply a time literal will need no conversions and
-- the comparison will succeed.
-- Executions that supply a datetime literal will be incompatible with
-- time literal, however the date part is silently truncated and
-- the comparison will succeed.

prepare stmt from "SELECT TIME'01:01:01' = ?";

set @var = 'e';

set @var = '';

set @var = '23:59:60';

CREATE TABLE t1(t TIME);
INSERT INTO t1 VALUES ('10-11-12');

SET @t = '10-11-12';

DROP TABLE t1;

CREATE TABLE t(t TIME);
CREATE TABLE dt(dt DATETIME);

INSERT INTO t VALUES('2021-10-10 00:00:00.123456+01:00');
INSERT INTO dt VALUES('2021-10-10 00:00:00.123456+01:00');
INSERT INTO t SELECT * FROM dt;

set @dt='2021-10-10 00:00:00.123456+01:00';

SELECT * FROM t;

DROP TABLE t, dt;

CREATE TABLE t(a VARCHAR(100), KEY(a));
INSERT INTO t VALUES ('1:2:3'), ('01:02:03');
SELECT * FROM t WHERE a = TIME'01:02:03';
DROP TABLE t;

-- This test case is provided for completeness, based on the test cases
-- for the same bug number in type_date and type_datetime, even though
-- the bug that was seen with DATE and DATETIME was not seen with TIME.
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
SET timestamp = UNIX_TIMESTAMP('2023-03-15 01:02:03');
SELECT * FROM t WHERE a = CURRENT_TIME;
SELECT * FROM t WHERE a = CURRENT_TIMESTAMP;
SELECT * FROM t WHERE a = CURRENT_DATE;
SET timestamp = DEFAULT;
DROP TABLE t;
