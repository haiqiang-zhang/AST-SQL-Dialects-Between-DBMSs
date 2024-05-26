select * from t1;
delete from t1 where t > 0;
delete from t1;
insert ignore into t1 values("000101"),("691231"),("700101"),("991231"),("00000101"),("00010101"),("99991231"),("00101000000"),("691231000000"),("700101000000"),("991231235959"),("10000101000000"),("99991231235959"),("20030100000000"),("20030000000000");
insert into t1 values ("2003-003-03");
insert into t1 values ("20030102T131415"),("2001-01-01T01:01:01"), ("2001-1-1T1:01:01");
select * from t1;
insert ignore into t1 values("2003-0303 12:13:14");
select * from t1;
drop table t1;
CREATE TABLE t1 (a timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, b date, c time, d datetime);
insert into t1 (b,c,d) values(now(),curtime(),now());
select date_format(a,"%Y-%m-%d")=b,right(a+0,6)=c+0,a=d+0 from t1;
drop table t1;
CREATE TABLE t1 (a datetime not null);
insert ignore into t1 values (0);
select * from t1 where a is null;
drop table t1;
create table t1 (id int, dt datetime);
insert into t1 values (1,"2001-08-14 00:00:00"),(2,"2001-08-15 00:00:00"),(3,"2001-08-16 00:00:00"),(4,"2003-09-15 01:20:30");
select * from t1 where dt='2001-08-14 00:00:00' and dt =  if(id=1,'2001-08-14 00:00:00','1999-08-15');
create index dt on t1 (dt);
select * from t1 where dt > 20021020;
select * from t1 ignore index (dt) where dt > 20021020;
drop table t1;
create table t1 (t datetime);
select * from t1;
delete from t1;
select * from t1;
delete from t1;
select * from t1 order by t;
drop table t1;
create table t1 (dt datetime);
select * from t1;
drop table t1;
select cast('2006-12-05 22:10:10' as datetime) + 0;
CREATE TABLE t1(a DATETIME NOT NULL);
INSERT INTO t1 VALUES ('20060606155555');
SELECT a FROM t1 WHERE a=(SELECT MAX(a) FROM t1) AND (a="20060606155555");
PREPARE s FROM 'SELECT a FROM t1 WHERE a=(SELECT MAX(a) FROM t1) AND (a="20060606155555")';
DROP PREPARE s;
DROP TABLE t1;
SELECT CAST(CAST('2006-08-10' AS DATE) AS DECIMAL(20,6));
create table t1 (da date default '1962-03-03 23:33:34', dt datetime default '1962-03-03');
insert into t1 values ();
insert into t1 values ('2007-03-23 13:49:38','2007-03-23 13:49:38');
insert into t1 values ('2007-03-23 13:49:38','2007-03-23 13:49:38');
insert into t1 set dt='2007-03-23 13:49:38',da=dt;
select * from t1;
drop table t1;
create table t1 (f1 date, f2 datetime, f3 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
insert into t1(f1) values(curdate());
select curdate() < now(), f1 < now(), cast(f1 as date) < now() from t1;
delete from t1;
insert into t1 values('2001-01-01','2001-01-01 01:01:01','2001-01-01 01:01:01');
insert into t1 values('2001-02-05','2001-02-05 00:00:00','2001-02-05 01:01:01');
insert into t1 values('2001-03-10','2001-03-09 01:01:01','2001-03-10 01:01:01');
insert into t1 values('2001-04-15','2001-04-15 00:00:00','2001-04-15 00:00:00');
insert into t1 values('2001-05-20','2001-05-20 01:01:01','2001-05-20 01:01:01');
select f1, f3 from t1 where f1 >= '2001-02-05 00:00:00' and f3 <= '2001-04-15';
select f1, f3 from t1 where f1 >= '2001-2-5 0:0:0' and f2 <= '2001-4-15';
select f1, f2 from t1 where if(1, f1, 0) >= f2;
select 1 from dual where cast('2001-1-1 2:3:4' as date) = cast('2001-01-01' as datetime);
select f1, f2, f1 > f2, f1 = f2, f1 < f2 from t1;
drop table t1;
create table t1 (f1 date, f2 datetime, f3 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
insert into t1 values('2001-01-01','2001-01-01 01:01:01','2001-01-01 01:01:01');
insert into t1 values('2001-02-05','2001-02-05 00:00:00','2001-02-05 01:01:01');
insert into t1 values('2001-03-10','2001-03-09 01:01:01','2001-03-10 01:01:01');
insert into t1 values('2001-04-15','2001-04-15 00:00:00','2001-04-15 00:00:00');
insert into t1 values('2001-05-20','2001-05-20 01:01:01','2001-05-20 01:01:01');
select f2 from t1 where f2 between '2001-2-5' and '01-04-14';
select f1, f2, f3 from t1 where f1 between f2 and f3;
select f1, f2, f3 from t1 where cast(f1 as datetime) between f2 and
  cast(f3 as date);
select f2 from t1 where '2001-04-10 12:34:56' between f2 and '01-05-01';
select f2, f3 from t1 where '01-03-10' between f2 and f3;
select f2 from t1 where DATE(f2) between "2001-4-15" AND "01-4-15";
SELECT 1 from dual where NOW() BETWEEN CURRENT_DATE() - INTERVAL 1 DAY AND CURRENT_DATE();
drop table t1;
create table t1 (f1 date);
insert into t1 values('01-01-01'),('01-01-02'),('01-01-03');
select * from t1 where f1 in ('01-01-01','2001-01-02','2001-01-03 00:00:00');
create table t2(f2 datetime);
insert into t2 values('01-01-01 00:00:00'),('01-02-03 12:34:56'),('02-04-06 11:22:33');
select * from t2 where f2 in ('01-01-01','01-02-03 12:34:56','01-02-03');
select * from t1,t2 where '01-01-02' in (f1, cast(f2 as date));
select * from t1,t2 where '01-01-01' in (f1, '01-02-03');
select * from t1,t2 where if(1,'01-02-03 12:34:56','') in (f1, f2);
create table t3(f3 varchar(20));
insert into t3 select * from t2;
select * from t2,t3 where f2 in (f3,'03-04-05');
select f1,f2,f3 from t1,t2,t3 where (f1,'1') in ((f2,'1'),(f3,'1')) order by f1,f2,f3;
select f1 from t1 where ('1',f1) in (('1','01-01-01'),('1','2001-1-1 0:0:0'),('1','02-02-02'));
drop table t1,t2,t3;
select least(cast('01-01-01' as date), '01-01-02');
select greatest(cast('01-01-01' as date), '01-01-02');
select least(cast('01-01-01' as date), '01-01-02') + 0;
select greatest(cast('01-01-01' as date), '01-01-02') + 0;
select least(cast('01-01-01' as datetime), '01-01-02') + 0;
select cast(least(cast('01-01-01' as datetime), '01-01-02') as signed);
DROP PROCEDURE IF EXISTS test27759;
create table t1 (f1 date);
insert into t1 values (curdate());
select left(f1,10) = curdate() from t1;
drop table t1;
create table t1(f1 date);
insert into t1 values('01-01-01'),('02-02-02'),('01-01-01'),('02-02-02');
select if(@bug28261 = f1, '', @bug28261:= f1) from t1;
drop table t1;
create table t1(f1 datetime);
insert into t1 values('2001-01-01'),('2002-02-02');
select * from t1 where f1 between 20020101 and 20070101000000;
select * from t1 where f1 between 2002010 and 20070101000000;
select * from t1 where f1 between 20020101 and 2007010100000;
drop table t1;
create table t1 (f1 date, f2 datetime, f3 varchar(20));
create table t2 as select coalesce(f1,f1) as f4 from t1;
create table t3 as select coalesce(f1,f2) as f4 from t1;
create table t4 as select coalesce(f2,f2) as f4 from t1;
create table t5 as select coalesce(f1,f3) as f4 from t1;
create table t6 as select coalesce(f2,f3) as f4 from t1;
create table t7 as select coalesce(makedate(1997,1),f2) as f4 from t1;
create table t8 as select coalesce(cast('01-01-01' as datetime),f2) as f4
  from t1;
create table t9 as select case when 1 then cast('01-01-01' as date)
  when 0 then cast('01-01-01' as date) end as f4 from t1;
create table t10 as select case when 1 then cast('01-01-01' as datetime)
  when 0 then cast('01-01-01' as datetime) end as f4 from t1;
create table t11 as select if(1, cast('01-01-01' as datetime),
  cast('01-01-01' as date)) as f4 from t1;
create table t12 as select least(cast('01-01-01' as datetime),
  cast('01-01-01' as date)) as f4 from t1;
create table t13 as select ifnull(cast('01-01-01' as datetime),
  cast('01-01-01' as date)) as f4 from t1;
drop tables t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13;
create table t1 (f1 time);
insert into t1 set f1 = '45:44:44';
insert into t1 set f1 = '15:44:44';
select * from t1 where (convert(f1,datetime)) != 1;
drop table t1;
create table t1 (a tinyint);
insert into t1 values (), (), ();
select sum(a) from t1 group by convert(a, datetime);
drop table t1;
create table t1 (id int(10) not null, cur_date datetime not null);
create table t2 (id int(10) not null, cur_date date not null);
insert into t1 (id, cur_date) values (1, '2007-04-25 18:30:22');
insert into t2 (id, cur_date) values (1, '2007-04-25');
select * from t1
where id in (select id from t1 as x1 where (t1.cur_date is null));
select * from t1
where id in (select id from t1 as x1 where (t1.cur_date is null));
select * from t2
where id in (select id from t2 as x1 where (t2.cur_date is null));
select * from t2
where id in (select id from t2 as x1 where (t2.cur_date is null));
insert into t1 (id, cur_date) values (2, '2007-04-26 18:30:22');
insert into t2 (id, cur_date) values (2, '2007-04-26');
select * from t1
where id in (select id from t1 as x1 where (t1.cur_date is null));
select * from t1
where id in (select id from t1 as x1 where (t1.cur_date is null));
select * from t2
where id in (select id from t2 as x1 where (t2.cur_date is null));
select * from t2
where id in (select id from t2 as x1 where (t2.cur_date is null));
drop table t1,t2;
SELECT 
  CAST('NULL' AS DATE) <=> CAST('2008-01-01' AS DATE) n1, 
  CAST('2008-01-01' AS DATE) <=> CAST('NULL' AS DATE) n2,
  CAST('NULL' AS DATE) <=> CAST('NULL' AS DATE) n3,
  CAST('NULL' AS DATE) <> CAST('2008-01-01' AS DATE) n4, 
  CAST('2008-01-01' AS DATE) <> CAST('NULL' AS DATE) n5,
  CAST('NULL' AS DATE) <> CAST('NULL' AS DATE) n6,
  CAST('NULL' AS DATE) < CAST('2008-01-01' AS DATE) n7, 
  CAST('2008-01-01' AS DATE) < CAST('NULL' AS DATE) n8,
  CAST('NULL' AS DATE) < CAST('NULL' AS DATE) n9;
create table t1 (da date default '1962-03-03 23:33:34', dt datetime default '1962-03-03');
insert into t1 values ();
insert into t1 values ('2007-03-23 13:49:38','2007-03-23 13:49:38');
insert into t1 values ('2007-03-23 13:49:38','2007-03-23 13:49:38');
insert into t1 set dt='2007-03-23 13:49:38',da=dt;
select * from t1;
drop table t1;
CREATE TABLE t1 (dt1 DATETIME);
INSERT IGNORE INTO t1 (dt1) VALUES ('0000-00-01 00:00:01');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (Id INT, AtTime DATETIME, KEY AtTime (AtTime));
INSERT INTO t1 VALUES (1,'2010-04-12 22:30:12'), (2,'2010-04-12 22:30:12'), (3,'2010-04-12 22:30:12');
DROP TABLE t1;
CREATE TABLE t1 (
  `year` int(4) NOT NULL,
  `month` int(2) NOT NULL
);
INSERT INTO t1 VALUES (2010,3),(2010,4),(2009,8),(2008,9);
SELECT *
FROM t1
WHERE STR_TO_DATE(CONCAT_WS('/01/',`month`,`year`), '%m/%d/%Y') >=
STR_TO_DATE('1/1/2010', '%m/%d/%Y');
create table t2(f1 datetime primary key);
insert into t2 select STR_TO_DATE(CONCAT_WS('/01/',`month`,`year`), '%m/%d/%Y') from t1;
select * from t2 where f1=STR_TO_DATE('4/1/2010', '%m/%d/%Y');
DROP TABLE t1,t2;
CREATE TABLE t1 (`b` datetime );
INSERT INTO t1 VALUES ('2010-01-01 00:00:00'), ('2010-01-01 00:00:00');
SELECT * FROM t1 WHERE b <= coalesce(NULL, now());
DROP TABLE t1;
CREATE TABLE t1 (a DATE NOT NULL, b INT);
INSERT IGNORE INTO t1 VALUES ('0000-00-00',1), ('1999-05-10',2);
CREATE TABLE t2 (a DATETIME NOT NULL, b INT);
INSERT IGNORE INTO t2 VALUES ('0000-00-00 00:00:00',1), ('1999-05-10 00:00:00',2);
SELECT * FROM t1 WHERE a IS NULL;
SELECT * FROM t2 WHERE a IS NULL;
SELECT * FROM t1 LEFT JOIN t1 AS t1_2 ON 1 WHERE t1_2.a IS NULL;
SELECT * FROM t2 LEFT JOIN t2 AS t2_2 ON 1 WHERE t2_2.a IS NULL;
SELECT * FROM t1 JOIN t1 AS t1_2 ON 1 WHERE t1_2.a IS NULL;
SELECT * FROM t2 JOIN t2 AS t2_2 ON 1 WHERE t2_2.a IS NULL;
PREPARE stmt1 FROM 
  'SELECT *
   FROM t1 LEFT JOIN t1 AS t1_2 ON 1
   WHERE t1_2.a IS NULL AND t1_2.b < 2';
DEALLOCATE PREPARE stmt1;
DROP TABLE t1,t2;
CREATE TABLE t1 (a DATETIME);
INSERT INTO t1 VALUES ('2001-01-01 10:10:10.9999994'), ('2001-01-01 10:10:10.9999995');
INSERT INTO t1 VALUES (20010101101010.9999994), (20010101101010.9999995);
SELECT * FROM t1;
DROP TABLE t1;
DROP TABLE if EXISTS t1, t2, t3;
CREATE TABLE t1 (c1 int);
DROP TABLE t1;
CREATE TABLE t1 (c1 INT);
DROP TABLE t1;
CREATE TABLE t1 (
  col_datetime_1_not_null datetime NOT NULL,
  col_datetime_2_not_null datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
SELECT * FROM t1 order by col_datetime_1_not_null;
SELECT LEAST( '2005-06-05',
              LEAST( col_datetime_1_not_null , col_datetime_2_not_null ) )
AS c1 FROM t1 ORDER BY c1;
DROP TABLE t1;
SELECT TIMESTAMP'2019-09-20 10:00:00.999999+02:00 ';
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";
deallocate prepare stmt;
CREATE TABLE t1 (
  pk INTEGER PRIMARY KEY,
  t0 TIME NOT NULL,
  t1 TIME NOT NULL,
  dt DATETIME
);
INSERT INTO t1 VALUES
(1, TIME'08:00:00', TIME'12:00:00', TIMESTAMP'2020-01-01 00:00:00'),
(2, TIME'12:00:00', TIME'12:00:00', TIMESTAMP'2020-01-01 00:00:00'),
(3, TIME'16:00:00', TIME'12:00:00', TIMESTAMP'2020-01-01 00:00:00');
SELECT pk, t0, t1, dt,
       t0 BETWEEN NULL AND t1 AS b1,
       t0 NOT BETWEEN NULL AND t1 AS b2,
       t0 BETWEEN NULL AND COALESCE(t1, dt) AS b3,
       t0 NOT BETWEEN NULL AND COALESCE(t1, dt) AS b4
FROM t1;
SELECT pk, t0, t1, dt,
       t1 BETWEEN t0 AND NULL AS b1,
       t1 NOT BETWEEN t0 AND NULL AS b2,
       t1 BETWEEN COALESCE(t0, dt) AND NULL AS b3,
       t1 NOT BETWEEN COALESCE(t0, dt) AND NULL AS b4
FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (
  pk INTEGER PRIMARY KEY,
  col_date date DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  col_varchar VARCHAR(1) DEFAULT NULL,
  KEY (col_varchar)
);
INSERT INTO t1 VALUES(5, '2022-02-25', '2022-02-25 11:01:14', 'I');
SELECT * FROM t1 WHERE pk = 5 AND
(col_datetime, col_varchar)
IN (('2022-02-25 11:01:14', 'Y'), ('2022-02-25 11:01:14', 'I'));
SELECT * FROM t1 WHERE pk = 5 AND
(col_datetime, col_varchar) IN ((@a, @b), (@c, @d));
SELECT * FROM t1 WHERE pk = 5 AND
(col_date, col_varchar) IN (('2022-02-25', 'Y'), ('2022-02-25', 'I'));
SELECT * FROM t1 wHERE pk = 5 AND
(col_varchar, col_date) IN (('Y','2022-02-25'), ('I', '2022-02-25'));
SELECT * FROM t1 wHERE pk = 5 AND
(col_varchar, col_date) IN (('I','2022-02-25'), ('I', '2022-02-25'));
DROP TABLE t1;
CREATE TABLE t(a VARCHAR(100) CHARSET latin1, KEY(a));
INSERT INTO t VALUES ('2023-1-1 1:2:3'), ('2023-01-01 01:02:03');
SELECT * FROM t WHERE a = TIMESTAMP'2023-01-01 01:02:03';
DROP TABLE t;
CREATE TABLE t (a VARCHAR(30) CHARSET latin1,
                b VARCHAR(30) CHARSET latin1);
INSERT INTO t VALUES
  ('2023-01-01 01:02:03', '2023-01-01 01:02:03'),
  ('2023-01-01 01:02:03', '2023-1-1 1:2:3'),
  ('2023-1-1 1:2:3',      '2023-01-01 01:02:03'),
  ('2023-1-1 1:2:3',      '2023-1-1 1:2:3');
SELECT * FROM t WHERE a = b and b = TIMESTAMP'2023-01-01 01:02:03';
DROP TABLE t;
CREATE TABLE t(a DATETIME, KEY(a));
INSERT INTO t VALUES ('2023-03-15 00:00:00');
SELECT * FROM t WHERE a = CURRENT_TIME;
SELECT * FROM t WHERE a = CURRENT_TIMESTAMP;
SELECT * FROM t WHERE a = CURRENT_DATE;
DROP TABLE t;
