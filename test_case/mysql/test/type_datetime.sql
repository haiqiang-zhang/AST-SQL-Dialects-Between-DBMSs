--

--disable_warnings
drop table if exists t1;

create table t1 (t datetime) ENGINE=InnoDB;
insert ignore into t1 values (101),(691231),(700101),(991231),(10000101),(99991231),(101000000),(691231000000),(700101000000),(991231235959),(10000101000000),(99991231235959),(20030100000000),(20030000000000);
select * from t1;
delete from t1 where t > 0;
delete from t1;
insert ignore into t1 values("000101"),("691231"),("700101"),("991231"),("00000101"),("00010101"),("99991231"),("00101000000"),("691231000000"),("700101000000"),("991231235959"),("10000101000000"),("99991231235959"),("20030100000000"),("20030000000000");

-- Strange dates
insert into t1 values ("2003-003-03");

-- Bug #7308: ISO-8601 date format not handled correctly
insert into t1 values ("20030102T131415"),("2001-01-01T01:01:01"), ("2001-1-1T1:01:01");
select * from t1;

-- Test some wrong dates
truncate table t1;
insert ignore into t1 values("2003-0303 12:13:14");
select * from t1;
drop table t1;

--
-- Test insert of now() and curtime()
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 (a timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, b date, c time, d datetime);
insert into t1 (b,c,d) values(now(),curtime(),now());
select date_format(a,"%Y-%m-%d")=b,right(a+0,6)=c+0,a=d+0 from t1;
drop table t1;
SET sql_mode = default;
--

CREATE TABLE t1 (a datetime not null);
insert ignore into t1 values (0);
select * from t1 where a is null;
drop table t1;

--
-- Test with bug when propagating DATETIME to integer and WHERE optimization
--

create table t1 (id int, dt datetime);
insert into t1 values (1,"2001-08-14 00:00:00"),(2,"2001-08-15 00:00:00"),(3,"2001-08-16 00:00:00"),(4,"2003-09-15 01:20:30");
select * from t1 where dt='2001-08-14 00:00:00' and dt =  if(id=1,'2001-08-14 00:00:00','1999-08-15');
create index dt on t1 (dt);
select * from t1 where dt > 20021020;
select * from t1 ignore index (dt) where dt > 20021020;
drop table t1;

--
-- Let us check if we properly treat wrong datetimes and produce proper
-- warnings (for both strings and numbers)
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create table t1 (t datetime);
insert into t1 values (20030102030460),(20030102036301),(20030102240401),
                      (20030132030401),(20031302030401),(100001202030401);
select * from t1;
delete from t1;
insert into t1 values
  ("2003-01-02 03:04:60"),("2003-01-02 03:63:01"),("2003-01-02 24:04:01"),
  ("2003-01-32 03:04:01"),("2003-13-02 03:04:01"), ("10000-12-02 03:04:00");
select * from t1;
delete from t1;
insert into t1 values ("0000-00-00 00:00:00 some trailer"),("2003-01-01 00:00:00 some trailer");
select * from t1 order by t;
drop table t1;

--
-- Test for bug #7297 "Two digit year should be interpreted correctly even
-- with zero month and day"
--
create table t1 (dt datetime);
insert into t1 values ("12-00-00"), ("00-00-00 01:00:00");
insert into t1 values ("00-00-00"), ("00-00-00 00:00:00");
select * from t1;
drop table t1;
SET sql_mode = default;
select cast('2006-12-05 22:10:10' as datetime) + 0;


-- End of 4.1 tests

--
-- Bug#21475: Wrongly applied constant propagation leads to a false comparison.
--
CREATE TABLE t1(a DATETIME NOT NULL);
INSERT INTO t1 VALUES ('20060606155555');
SELECT a FROM t1 WHERE a=(SELECT MAX(a) FROM t1) AND (a="20060606155555");
DROP PREPARE s;
DROP TABLE t1;


--
-- Bug 19491 (CAST DATE AS DECIMAL returns incorrect result
--
SELECT CAST(CAST('2006-08-10' AS DATE) AS DECIMAL(20,6));
SELECT CAST(CAST('2006-08-10 10:11:12' AS DATETIME) AS DECIMAL(20,6));
SELECT CAST(CAST('2006-08-10 10:11:12' AS DATETIME) + INTERVAL 14 MICROSECOND AS DECIMAL(20,6));
SELECT CAST(CAST('10:11:12.098700' AS TIME) AS DECIMAL(20,6));


--
-- Test of storing datetime into date fields
--

set @org_mode=@@sql_mode;
create table t1 (da date default '1962-03-03 23:33:34', dt datetime default '1962-03-03');
insert into t1 values ();
insert into t1 values ('2007-03-23 13:49:38','2007-03-23 13:49:38');
set @@sql_mode='ansi,traditional';
insert into t1 values ('2007-03-23 13:49:38','2007-03-23 13:49:38');
insert into t1 set dt='2007-03-23 13:49:38',da=dt;
insert into t1 values ('2007-03-32','2007-03-23 13:49:38');
select * from t1;
drop table t1;
create table t1 (da date default '1962-03-32 23:33:34', dt datetime default '1962-03-03');
create table t1 (t time default '916:00:00 a');
set @@sql_mode= @org_mode;


--
-- Bug#27590: Wrong DATE/DATETIME comparison.  
--
--# The following sub test will fail (difference to expected result) if the
--# select curdate() < now(), f1 < now(), cast(f1 as date) < now() from t1;
--# runs exact at midnight ('00:00:00').
--# ( Bug#29290 type_datetime.test failure in 5.1 )
--# Therefore we sleep a bit if we are too close to midnight.
--# The complete test itself needs around 1 second.
--# Therefore a time_distance to midnight of 5 seconds should be sufficient.
if (`SELECT CURTIME() > SEC_TO_TIME(24 * 3600 - 5)`)
{
   -- We are here when CURTIME() is between '23:59:56' and '23:59:59'.
   -- So a sleep time of 5 seconds brings us between '00:00:01' and '00:00:04'.
   --sleep 5
}
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

--
-- Bug#16377: Wrong DATE/DATETIME comparison in BETWEEN function.
--
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

--
-- Bug#28133: Wrong DATE/DATETIME comparison in IN() function.
--
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

--
-- Bug#27759: Wrong DATE/DATETIME comparison in LEAST()/GREATEST() functions.
--
select least(cast('01-01-01' as date), '01-01-02');
select greatest(cast('01-01-01' as date), '01-01-02');
select least(cast('01-01-01' as date), '01-01-02') + 0;
select greatest(cast('01-01-01' as date), '01-01-02') + 0;
select least(cast('01-01-01' as datetime), '01-01-02') + 0;
select cast(least(cast('01-01-01' as datetime), '01-01-02') as signed);
select cast(least(cast('01-01-01' as datetime), '01-01-02') as decimal(16,2));
DROP PROCEDURE IF EXISTS test27759 ;
CREATE PROCEDURE test27759()
BEGIN
declare v_a date default '2007-4-10';
select v_a as a,v_b as b,
       least( v_a, v_b ) as a_then_b,
       least( v_b, v_a ) as b_then_a,
       least( v_c, v_a ) as c_then_a;
drop procedure test27759;

--
-- Bug#28208: Wrong result of a non-const STRING function with a const
--            DATETIME function.
--
create table t1 (f1 date);
insert into t1 values (curdate());
select left(f1,10) = curdate() from t1;
drop table t1;

--
-- Bug#28261: Wrong DATETIME comparison result when the GET_USER_VAR function
--            is involved.
--
create table t1(f1 date);
insert into t1 values('01-01-01'),('02-02-02'),('01-01-01'),('02-02-02');
set @bug28261='';
select if(@bug28261 = f1, '', @bug28261:= f1) from t1;
select if(@bug28261 = f1, '', @bug28261:= f1) from t1;
select if(@bug28261 = f1, '', @bug28261:= f1) from t1;
drop table t1;

--
-- Bug#28778: Wrong result of BETWEEN when comparing a DATETIME field with an
--            integer constants.
--
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

--
-- Bug #31249: problem with convert(..., datetime)
--
create table t1 (a tinyint);
insert into t1 values (), (), ();
select sum(a) from t1 group by convert(a, datetime);
drop table t1;

--
-- Bug #32694: NOT NULL table field in a subquery produces invalid results
--
create table t1 (id int(10) not null, cur_date datetime not null);
create table t2 (id int(10) not null, cur_date date not null);
insert into t1 (id, cur_date) values (1, '2007-04-25 18:30:22');
insert into t2 (id, cur_date) values (1, '2007-04-25');
{
  set optimizer_switch='semijoin=off';
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
set @@optimizer_switch=default;
drop table t1,t2;


--
-- Bug #37526: asymertic operator <=> in trigger
--
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
--

set @org_mode=@@sql_mode;
create table t1 (da date default '1962-03-03 23:33:34', dt datetime default '1962-03-03');
insert into t1 values ();
insert into t1 values ('2007-03-23 13:49:38','2007-03-23 13:49:38');
set @@sql_mode='ansi,traditional';
insert into t1 values ('2007-03-23 13:49:38','2007-03-23 13:49:38');
insert into t1 set dt='2007-03-23 13:49:38',da=dt;
insert into t1 values ('2007-03-32','2007-03-23 13:49:38');
select * from t1;
drop table t1;
create table t1 (da date default '1962-03-32 23:33:34', dt datetime default '1962-03-03');
create table t1 (t time default '916:00:00 a');
set @@sql_mode= @org_mode;

--
-- Bug #42146 - DATETIME fractional seconds parse error
--
-- show we trucate microseconds from the right -- special case: leftmost is 0
SELECT CAST(CAST('2006-08-10 10:11:12.0123450' AS DATETIME) AS DECIMAL(30,7));

-- show that we ignore leading zeroes for all other fields
SELECT CAST(CAST('00000002006-000008-0000010 000010:0000011:00000012.0123450' AS DATETIME) AS DECIMAL(30,7));
SELECT CAST(CAST('00000002006-000008-0000010 000010:0000011:00000012.012345'  AS DATETIME) AS DECIMAL(30,7));

--
-- Bug #38435 - LONG Microseconds cause MySQL to fail a CAST to DATETIME or DATE
--
-- show we truncate microseconds from the right
SELECT CAST(CAST('2008-07-29T10:42:51.1234567' AS DateTime) AS DECIMAL(30,7));
CREATE TABLE t1 (dt1 DATETIME);
INSERT IGNORE INTO t1 (dt1) VALUES ('0000-00-01 00:00:01');
DELETE IGNORE  FROM t1 WHERE dt1 = '0000-00-01 00:00:01';
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (Id INT, AtTime DATETIME, KEY AtTime (AtTime));
SET NAMES CP850;
INSERT INTO t1 VALUES (1,'2010-04-12 22:30:12'), (2,'2010-04-12 22:30:12'), (3,'2010-04-12 22:30:12');
DROP TABLE t1;
SET NAMES latin1;
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
DROP TABLE t1,t2;
CREATE TABLE t1 (a DATETIME);
INSERT INTO t1 VALUES ('2001-01-01 10:10:10.9999994'), ('2001-01-01 10:10:10.9999995');
INSERT INTO t1 VALUES (20010101101010.9999994), (20010101101010.9999995);
SELECT * FROM t1;
DROP TABLE t1;
DROP TABLE if EXISTS t1, t2, t3;
SET @org_mode=@@sql_mode;
SET @@sql_mode='NO_ZERO_DATE,STRICT_ALL_TABLES';
CREATE TABLE t1 (c1 DATETIME DEFAULT 0);
CREATE TABLE t1 (c1 DATETIME DEFAULT '0000-00-00 00:00:00');
SET @@sql_mode='NO_ZERO_IN_DATE,STRICT_ALL_TABLES';
CREATE TABLE t1 (c1 DATETIME DEFAULT '2012-02-00 12:12:12');
SET @@sql_mode='NO_ZERO_DATE';
CREATE TABLE t1 (c1 DATETIME DEFAULT 0);
CREATE TABLE t2 (c1 DATETIME DEFAULT '0000-00-00 00:00:00');
SET @@sql_mode='NO_ZERO_IN_DATE';
CREATE TABLE t3 (c1 DATETIME DEFAULT '2012-02-00 12:12:12');
DROP TABLE t1, t2, t3;
SET @@sql_mode='';
CREATE TABLE t1 (c1 DATETIME DEFAULT 0);
CREATE TABLE t2 (c1 DATETIME DEFAULT '0000-00-00 00:00:00');
CREATE TABLE t3 (c1 DATETIME DEFAULT '2012-02-00 12:12:12');
DROP TABLE t1, t2, t3;

CREATE TABLE t1 (c1 int);
SET @@sql_mode='NO_ZERO_DATE,STRICT_ALL_TABLES';
ALTER TABLE t1 ADD c2 DATETIME DEFAULT 0;
ALTER TABLE t1 ADD c2 DATETIME DEFAULT '0000-00-00';
SET @@sql_mode='NO_ZERO_IN_DATE,STRICT_ALL_TABLES';
ALTER TABLE t1 ADD c2 DATETIME DEFAULT '2012-02-00';
SET @@sql_mode='NO_ZERO_DATE';
ALTER TABLE t1 ADD c2 DATETIME DEFAULT 0;
ALTER TABLE t1 ADD c3 DATETIME DEFAULT '0000-00-00';
SET @@sql_mode='NO_ZERO_IN_DATE';
ALTER TABLE t1 ADD c4 DATETIME DEFAULT '2012-02-00';
DROP TABLE t1;

CREATE TABLE t1 (c1 INT);
SET @@sql_mode='';
ALTER TABLE t1 ADD c2 DATETIME DEFAULT 0;
ALTER TABLE t1 ADD c3 DATETIME DEFAULT '0000-00-00';
ALTER TABLE t1 ADD c4 DATETIME DEFAULT '2012-02-00';
DROP TABLE t1;

SET @@sql_mode= @org_mode;
CREATE TABLE test.t(col_varchar_nokey VARCHAR(1) NOT NULL,
                    col_time_nokey time NOT NULL,
                    col_int_nokey INT NOT NULL,
                    col_datetime_key datetime not null,
                    key(col_datetime_key)) ENGINE= InnoDB;
DELETE FROM test.t WHERE `col_int_nokey` > `col_int_nokey`
                         AND TIMESTAMP( '18:16:35.025453' ) IS  NULL;
UPDATE test.t SET `col_varchar_nokey` = TIMESTAMP(`col_time_nokey`,'00:00:00')
  WHERE `col_int_nokey` > `col_int_nokey`
        AND TIMESTAMP('18:16:35.025453') IS  NULL;
INSERT INTO t VALUES('x', CURRENT_TIME(), 0, CURRENT_TIMESTAMP());
UPDATE test.t SET `col_datetime_key` = `col_datetime_key` WHERE
  `col_datetime_key` <=> FROM_UNIXTIME(1151860736,CONCAT_WS(':','%D','%v'));
DROP TABLE test.t;
                         st_longfromgeohash(('4358-04-12 03:45:08.727399'))),
			 0xdc0823,6756,release_all_locks()));
  31
 )
);
CREATE TABLE t1 (
  col_datetime_1_not_null datetime NOT NULL,
  col_datetime_2_not_null datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET sql_mode=NO_ENGINE_SUBSTITUTION;
INSERT INTO t1 VALUES ('0000-00-00 00:00:00.0','2005-12-22 19:53:31.01');
INSERT INTO t1 VALUES ('9999-00-00 00:00:00.0','2005-12-22 19:53:31.01');

SET sql_mode=default;

SELECT * FROM t1 order by col_datetime_1_not_null;
SELECT LEAST( '2005-06-05',
              LEAST( col_datetime_1_not_null , col_datetime_2_not_null ) )
AS c1 FROM t1 ORDER BY c1;

DROP TABLE t1;

SET time_zone = '+00:00';

SELECT CAST('2019-09-20 10:00:00.999999+00:00' AS DATETIME);
SELECT CAST('2019-09-20 10:00:00.999999+00:00' AS DATETIME(1));
SELECT CAST('2019-09-20 10:00:00.999999+00:00' AS DATETIME(2));
SELECT CAST('2019-09-20 10:00:00.999999+00:00' AS DATETIME(3));
SELECT CAST('2019-09-20 10:00:00.999999+00:00' AS DATETIME(4));
SELECT CAST('2019-09-20 10:00:00.999999+00:00' AS DATETIME(5));
SELECT CAST('2019-09-20 10:00:00.999999+00:00' AS DATETIME(6));

SELECT CAST('2019-09-20 10:00:00.999999+02:00' AS DATETIME);
SELECT CAST('2019-09-20 10:00:00.999999+02:00' AS DATETIME(1));
SELECT CAST('2019-09-20 10:00:00.999999+02:00' AS DATETIME(2));
SELECT CAST('2019-09-20 10:00:00.999999+02:00' AS DATETIME(3));
SELECT CAST('2019-09-20 10:00:00.999999+02:00' AS DATETIME(4));
SELECT CAST('2019-09-20 10:00:00.999999+02:00' AS DATETIME(5));
SELECT CAST('2019-09-20 10:00:00.999999+02:00' AS DATETIME(6));

SELECT TIMESTAMP'2019-09-20 10:00:00.999999+02:00 ';

SET time_zone = DEFAULT;

-- Check prepared statements with various DATETIME comparisons

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

-- Executions that supply a date literal will convert the literal to a
-- DATETIME value, and the comparison should fail.
-- Executions that supply a time literal will convert the literal to a
-- DATE value, and the comparison will fail.
-- Executions that supply a datetime literal will need no conversions and
-- the comparison should succeed.

prepare stmt from "SELECT TIMESTAMP'2020-01-01 01:01:01' = ?";

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

-- Complements a test case with the same bug number in type_time. The
-- assertion was only seen when the indexed column was a TIME column,
-- so this test case is only for extra test coverage.
CREATE TABLE t(a DATETIME, KEY(a));
INSERT INTO t VALUES ('2023-03-15 00:00:00');
SET timestamp = UNIX_TIMESTAMP('2023-03-15 01:02:03');
SELECT * FROM t WHERE a = CURRENT_TIME;
SELECT * FROM t WHERE a = CURRENT_TIMESTAMP;
SELECT * FROM t WHERE a = CURRENT_DATE;
SET timestamp = DEFAULT;
DROP TABLE t;
