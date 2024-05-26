drop table if exists t1,t2,t3;
select from_days(to_days("960101")),to_days(960201)-to_days("19960101"),to_days(date_add(curdate(), interval 1 day))-to_days(curdate()),weekday("1997-11-29");
select period_add("9602",-12),period_diff(199505,"9404");
select now()-now(),weekday(curdate())-weekday(now()),unix_timestamp()-unix_timestamp(now());
select from_unixtime(unix_timestamp("1994-03-02 10:11:12")),from_unixtime(unix_timestamp("1994-03-02 10:11:12"),"%Y-%m-%d %h:%i:%s"),from_unixtime(unix_timestamp("1994-03-02 10:11:12"))+0;
select sec_to_time(9001),sec_to_time(9001)+0,time_to_sec("15:12:22"),
  sec_to_time(time_to_sec("0:30:47")/6.21);
select sec_to_time(time_to_sec('-838:59:59'));
select now()-curdate()*1000000-curtime();
select strcmp(current_timestamp(),concat(current_date()," ",current_time()));
select date_format("1997-01-02 03:04:05", "%M %W %D %Y %y %m %d %h %i %s %w");
select dayofmonth("1997-01-02"),dayofmonth(19970323);
select month("1997-01-02"),year("98-02-03"),dayofyear("1997-12-31");
select month("2001-02-00"),year("2001-00-00");
select DAYOFYEAR("1997-03-03"), WEEK("1998-03-03"), QUARTER(980303);
select HOUR("1997-03-03 23:03:22"), MINUTE("23:03:22"), SECOND(230322);
select week(19980101),week(19970101),week(19980101,1),week(19970101,1);
select yearweek('1981-12-31',1),yearweek('1982-01-01',1),yearweek('1982-12-31',1),yearweek('1983-01-01',1);
select week("2000-01-01",0) as '2000', week("2001-01-01",0) as '2001', week("2002-01-01",0) as '2002',week("2003-01-01",0) as '2003', week("2004-01-01",0) as '2004', week("2005-01-01",0) as '2005', week("2006-01-01",0) as '2006';
select week("2000-01-06",0) as '2000', week("2001-01-06",0) as '2001', week("2002-01-06",0) as '2002',week("2003-01-06",0) as '2003', week("2004-01-06",0) as '2004', week("2005-01-06",0) as '2005', week("2006-01-06",0) as '2006';
select week("2000-01-01",1) as '2000', week("2001-01-01",1) as '2001', week("2002-01-01",1) as '2002',week("2003-01-01",1) as '2003', week("2004-01-01",1) as '2004', week("2005-01-01",1) as '2005', week("2006-01-01",1) as '2006';
select week("2000-01-06",1) as '2000', week("2001-01-06",1) as '2001', week("2002-01-06",1) as '2002',week("2003-01-06",1) as '2003', week("2004-01-06",1) as '2004', week("2005-01-06",1) as '2005', week("2006-01-06",1) as '2006';
select yearweek("2000-01-01",0) as '2000', yearweek("2001-01-01",0) as '2001', yearweek("2002-01-01",0) as '2002',yearweek("2003-01-01",0) as '2003', yearweek("2004-01-01",0) as '2004', yearweek("2005-01-01",0) as '2005', yearweek("2006-01-01",0) as '2006';
select yearweek("2000-01-06",0) as '2000', yearweek("2001-01-06",0) as '2001', yearweek("2002-01-06",0) as '2002',yearweek("2003-01-06",0) as '2003', yearweek("2004-01-06",0) as '2004', yearweek("2005-01-06",0) as '2005', yearweek("2006-01-06",0) as '2006';
select yearweek("2000-01-01",1) as '2000', yearweek("2001-01-01",1) as '2001', yearweek("2002-01-01",1) as '2002',yearweek("2003-01-01",1) as '2003', yearweek("2004-01-01",1) as '2004', yearweek("2005-01-01",1) as '2005', yearweek("2006-01-01",1) as '2006';
select yearweek("2000-01-06",1) as '2000', yearweek("2001-01-06",1) as '2001', yearweek("2002-01-06",1) as '2002',yearweek("2003-01-06",1) as '2003', yearweek("2004-01-06",1) as '2004', yearweek("2005-01-06",1) as '2005', yearweek("2006-01-06",1) as '2006';
select week(19981231,0) as '0', week(19981231,1) as '1', week(19981231,2) as '2', week(19981231,3) as '3', week(19981231,4) as '4', week(19981231,5) as '5', week(19981231,6) as '6', week(19981231,7) as '7';
select week(20000101,0) as '0', week(20000101,1) as '1', week(20000101,2) as '2', week(20000101,3) as '3', week(20000101,4) as '4', week(20000101,5) as '5', week(20000101,6) as '6', week(20000101,7) as '7';
select week(20000106,0) as '0', week(20000106,1) as '1', week(20000106,2) as '2', week(20000106,3) as '3', week(20000106,4) as '4', week(20000106,5) as '5', week(20000106,6) as '6', week(20000106,7) as '7';
select week(20001231,0) as '0', week(20001231,1) as '1', week(20001231,2) as '2', week(20001231,3) as '3', week(20001231,4) as '4', week(20001231,5) as '5', week(20001231,6) as '6', week(20001231,7) as '7';
select week(20010101,0) as '0', week(20010101,1) as '1', week(20010101,2) as '2', week(20010101,3) as '3', week(20010101,4) as '4', week(20010101,5) as '5', week(20010101,6) as '6', week(20010101,7) as '7';
select dayname("1962-03-03"),dayname("1962-03-03")+0;
select monthname("1972-03-04"),monthname("1972-03-04")+0;
select time_format(19980131000000,'%H|%I|%k|%l|%i|%p|%r|%S|%T');
select date_add("1997-12-31 23:59:59",INTERVAL 1 SECOND);
select date_sub("1998-01-01 00:00:00",INTERVAL 1 SECOND);
select "1997-12-31 23:59:59" + INTERVAL 1 SECOND;
select INTERVAL 1 DAY + "1997-12-31";
select "1998-01-01 00:00:00" - INTERVAL 1 SECOND;
select extract(YEAR FROM "1999-01-02 10:11:12");
SELECT EXTRACT(QUARTER FROM '2004-01-15') AS quarter;
SELECT EXTRACT(QUARTER FROM '2004-02-15') AS quarter;
SELECT EXTRACT(QUARTER FROM '2004-03-15') AS quarter;
SELECT EXTRACT(QUARTER FROM '2004-04-15') AS quarter;
SELECT EXTRACT(QUARTER FROM '2004-05-15') AS quarter;
SELECT EXTRACT(QUARTER FROM '2004-06-15') AS quarter;
SELECT EXTRACT(QUARTER FROM '2004-07-15') AS quarter;
SELECT EXTRACT(QUARTER FROM '2004-08-15') AS quarter;
SELECT EXTRACT(QUARTER FROM '2004-09-15') AS quarter;
SELECT EXTRACT(QUARTER FROM '2004-10-15') AS quarter;
SELECT EXTRACT(QUARTER FROM '2004-11-15') AS quarter;
SELECT EXTRACT(QUARTER FROM '2004-12-15') AS quarter;
SELECT DATE_SUB(str_to_date('9999-12-31 00:01:00','%Y-%m-%d %H:%i:%s'), INTERVAL 1 MINUTE);
SELECT DATE_ADD(str_to_date('9999-12-30 23:59:00','%Y-%m-%d %H:%i:%s'), INTERVAL 1 MINUTE);
SELECT "1900-01-01 00:00:00" + INTERVAL 2147483648 SECOND;
SELECT "1900-01-01 00:00:00" + INTERVAL "1:2147483647" MINUTE_SECOND;
SELECT "1900-01-01 00:00:00" + INTERVAL "100000000:214748364700" MINUTE_SECOND;
SELECT "1900-01-01 00:00:00" + INTERVAL 1<<31 MINUTE;
SELECT "1900-01-01 00:00:00" + INTERVAL 1<<20 HOUR;
SELECT "1900-01-01 00:00:00" + INTERVAL 1<<38 SECOND;
SELECT "1900-01-01 00:00:00" + INTERVAL 1<<33 MINUTE;
SELECT "1900-01-01 00:00:00" + INTERVAL 1<<30 HOUR;
SELECT "1900-01-01 00:00:00" + INTERVAL "1000000000:214748364700" MINUTE_SECOND;
create table t1 (ctime varchar(20));
insert into t1 values ('2001-01-12 12:23:40');
select ctime, hour(ctime) from t1;
select ctime from t1 where extract(MONTH FROM ctime) = 1 AND extract(YEAR FROM ctime) = 2001;
drop table t1;
create table t1 (id int);
create table t2 (id int, date date);
insert into t1 values (1);
insert ignore into t2 values (1, "0000-00-00");
insert into t1 values (2);
insert into t2 values (2, "2000-01-01");
drop table t1,t2;
CREATE TABLE t1 (updated text) ENGINE=Innodb;
INSERT INTO t1 VALUES ('');
SELECT month(updated) from t1;
SELECT year(updated) from t1;
drop table t1;
create table t1 (d date, dt datetime, t timestamp, c char(10));
insert ignore into t1 values ("0000-00-00", "0000-00-00", "0000-00-00", "0000-00-00");
select dayofyear("0000-00-00"),dayofyear(d),dayofyear(dt),dayofyear(t),dayofyear(c) from t1;
select quarter("0000-00-00"),quarter(d),quarter(dt),quarter(t),quarter(c) from t1;
select to_days("0000-00-00"),to_days(d),to_days(dt),to_days(t),to_days(c) from t1;
drop table t1;
CREATE TABLE t1 ( start datetime default NULL);
INSERT INTO t1 VALUES ('2002-10-21 00:00:00'),('2002-10-28 00:00:00'),('2002-11-04 00:00:00');
CREATE TABLE t2 ( ctime1 timestamp NOT NULL, ctime2 timestamp NOT NULL);
INSERT INTO t2 VALUES (20021029165106,20021105164731);
CREATE TABLE t3 (ctime1 char(19) NOT NULL, ctime2 char(19) NOT NULL);
INSERT INTO t3 VALUES ("2002-10-29 16:51:06","2002-11-05 16:47:31");
select * from t1, t2 where t1.start between t2.ctime1 and t2.ctime2;
select * from t1, t2 where t1.start >= t2.ctime1 and t1.start <= t2.ctime2;
select * from t1, t3 where t1.start between t3.ctime1 and t3.ctime2;
drop table t1,t2,t3;
select @a:=FROM_UNIXTIME(1);
select unix_timestamp(@a);
SELECT FROM_UNIXTIME(-0.000001);
SELECT CHARSET(DAYNAME(19700101));
SELECT LOWER(DAYNAME(19700101));
SELECT COERCIBILITY(MONTHNAME('1970-01-01')),COERCIBILITY(DAYNAME('1970-01-01'));
CREATE TABLE t1 (datetime datetime, timestamp timestamp, date date, time time);
INSERT INTO t1 values ("2001-01-02 03:04:05", "2002-01-02 03:04:05", "2003-01-02", "06:07:08");
SELECT * from t1;
select timestampadd(MINUTE, 1, date) from t1;
select timestampdiff(MONTH, '2001-02-01', '2001-05-01') as a;
select timestampdiff(YEAR, '2002-05-01', '2001-01-01') as a;
select timestampdiff(QUARTER, '2002-05-01', '2001-01-01') as a;
select timestampdiff(MONTH, '2000-03-28', '2000-02-29') as a;
select timestampdiff(MONTH, '1991-03-28', '2000-02-29') as a;
select timestampdiff(SQL_TSI_WEEK, '2001-02-01', '2001-05-01') as a;
select timestampdiff(SQL_TSI_HOUR, '2001-02-01', '2001-05-01') as a;
select timestampdiff(SQL_TSI_DAY, '2001-02-01', '2001-05-01') as a;
select timestampdiff(SQL_TSI_MINUTE, '2001-02-01 12:59:59', '2001-05-01 12:58:59') as a;
select timestampdiff(SQL_TSI_SECOND, '2001-02-01 12:59:59', '2001-05-01 12:58:58') as a;
select timestampdiff(SQL_TSI_DAY, '1986-02-01', '1986-03-01') as a1,
       timestampdiff(SQL_TSI_DAY, '1900-02-01', '1900-03-01') as a2,
       timestampdiff(SQL_TSI_DAY, '1996-02-01', '1996-03-01') as a3,
       timestampdiff(SQL_TSI_DAY, '2000-02-01', '2000-03-01') as a4;
SELECT TIMESTAMPDIFF(day,'2006-01-10 14:30:28','2006-01-11 14:30:27');
drop table t1;
select last_day('2000-02-05') as f1, last_day('2002-12-31') as f2,
       last_day('2003-03-32') as f3, last_day('2003-04-01') as f4,
       last_day('2001-01-01 01:01:01') as f5, last_day(NULL),
       last_day('2001-02-12');
create table t1 select last_day('2000-02-05') as a,
                from_days(to_days("960101")) as b;
select * from t1;
drop table t1;
select last_day('2000-02-05') as a,
       from_days(to_days("960101")) as b;
select length(last_day("1997-12-1"));
select last_day("1997-12-1")+0;
select last_day("1997-12-1")+0.0;
select strcmp(date_sub(localtimestamp(), interval 3 hour), utc_timestamp())=0;
select strcmp(date_format(date_sub(localtimestamp(), interval 3 hour),"%T"), utc_time())=0;
select strcmp(date_format(date_sub(localtimestamp(), interval 3 hour),"%Y-%m-%d"), utc_date())=0;
select strcmp(date_format(utc_timestamp(),"%T"), utc_time())=0;
select strcmp(date_format(utc_timestamp(),"%Y-%m-%d"), utc_date())=0;
select strcmp(concat(utc_date(),' ',utc_time()),utc_timestamp())=0;
CREATE TABLE t1 (d DATETIME);
INSERT INTO t1 VALUES ('2007-08-01 12:22:59');
INSERT INTO t1 VALUES ('2007-08-01 12:23:01');
INSERT INTO t1 VALUES ('2007-08-01 12:23:20');
SELECT count(*) FROM t1 WHERE d>FROM_DAYS(TO_DAYS(@TMP)) AND d<=FROM_DAYS(TO_DAYS(@TMP)+1);
DROP TABLE t1;
create table t1(a timestamp);
select * from t1;
drop table t1;
create table t1(f1 date, f2 time, f3 datetime);
insert into t1 values ("2006-01-01", "12:01:01", "2006-01-01 12:01:01");
insert into t1 values ("2006-01-02", "12:01:02", "2006-01-02 12:01:02");
select f1 from t1 where f1 between CAST("2006-1-1" as date) and CAST(20060101 as date);
select f1 from t1 where f1 between cast("2006-1-1" as date) and cast("2006.1.1" as date);
select f1 from t1 where date(f1) between cast("2006-1-1" as date) and cast("2006.1.1" as date);
select f2 from t1 where f2 between cast("12:1:2" as time) and cast("12:2:2" as time);
select f2 from t1 where time(f2) between cast("12:1:2" as time) and cast("12:2:2" as time);
select f3 from t1 where f3 between cast("2006-1-1 12:1:1" as datetime) and cast("2006-1-1 12:1:2" as datetime);
select f3 from t1 where timestamp(f3) between cast("2006-1-1 12:1:1" as datetime) and cast("2006-1-1 12:1:2" as datetime);
select f1 from t1 where cast("2006-1-1" as date) between f1 and f3;
select f1 from t1 where cast("2006-1-1" as date) between date(f1) and date(f3);
select f1 from t1 where cast("2006-1-1" as date) between f1 and cast('zzz' as date);
select f1 from t1 where makedate(2006,1) between date(f1) and date(f3);
select f1 from t1 where makedate(2006,2) between date(f1) and date(f3);
drop table t1;
create table t1 select now() - now(), curtime() - curtime(), 
                       sec_to_time(1) + 0, from_unixtime(1) + 0;
drop table t1;
SELECT SEC_TO_TIME(3300000);
SELECT SEC_TO_TIME(3300000)+0;
SELECT TIME_TO_SEC('916:40:00');
SELECT ADDTIME('500:00:00', '416:40:00');
SELECT SUBTIME('916:40:00', '416:40:00');
SELECT MAKETIME(916,0,0);
SELECT EXTRACT(HOUR FROM '100000:02:03');
CREATE TABLE t1(f1 TIME);
INSERT IGNORE INTO t1 VALUES('916:00:00 a');
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE testBug8868 (field1 DATE, field2 VARCHAR(32) CHARACTER SET BINARY);
INSERT INTO testBug8868 VALUES ('2006-09-04', 'abcd');
SELECT DATE_FORMAT(field1,'%b-%e %l:%i%p') as fmtddate, field2 FROM testBug8868;
DROP TABLE testBug8868;
CREATE TABLE t1 (
  a TIMESTAMP
);
INSERT INTO t1 VALUES (now()), (now());
DROP TABLE t1;
select isnull(week(now() + 0)), isnull(week(now() + 0.2)),
  week(20061108), week(20061108.01), week(20061108085411.000002);
create table t1 (a timestamp default '2005-05-05 01:01:01',
                 b timestamp default '2005-05-05 01:01:01');
drop function if exists t_slow_sysdate;
insert into t1 set a = sysdate();
select a != b from t1;
drop table t1;
create table t1 (a datetime, i int, b datetime);
insert into t1 select sysdate(), sleep(1), sysdate() from dual;
select a != b from t1;
drop table t1;
select sysdate() into @b;
select @a != @b;
select timestampdiff(month,'2004-09-11','2004-09-11');
CREATE TABLE t1 (id int NOT NULL PRIMARY KEY, day date);
CREATE TABLE t2 (id int NOT NULL PRIMARY KEY, day date);
INSERT INTO t1 VALUES
  (1, '2005-06-01'), (2, '2005-02-01'), (3, '2005-07-01');
INSERT INTO t2 VALUES
  (1, '2005-08-01'), (2, '2005-06-15'), (3, '2005-07-15');
SELECT * FROM t1, t2 
  WHERE t1.day BETWEEN 
               '2005.09.01' - INTERVAL 6 MONTH AND t2.day;
SELECT * FROM t1, t2 
  WHERE CAST(t1.day AS DATE) BETWEEN 
                             '2005.09.01' - INTERVAL 6 MONTH AND t2.day;
DROP TABLE t1,t2;
select str_to_date('10:00 PM', '%h:%i %p') + INTERVAL 10 MINUTE;
create table t1 (field DATE);
insert into t1 values ('2006-11-06');
select * from t1 where field < '2006-11-06 04:08:36.0';
select * from t1 where field = '2006-11-06 04:08:36.0';
select * from t1 where field = '2006-11-06';
select * from t1 where CAST(field as DATETIME) < '2006-11-06 04:08:36.0';
select * from t1 where CAST(field as DATE) < '2006-11-06 04:08:36.0';
drop table t1;
CREATE TABLE t1 (a int, t1 time, t2 time, d date, PRIMARY KEY  (a));
INSERT INTO t1 VALUES (1, '10:00:00', NULL, NULL), 
       (2, '11:00:00', '11:15:00', '1972-02-06');
SELECT t1, t2, SEC_TO_TIME( TIME_TO_SEC( t2 ) - TIME_TO_SEC( t1 ) ), QUARTER(d) 
  FROM t1;
DROP TABLE t1;
SELECT TIME_FORMAT(SEC_TO_TIME(a),"%H:%i:%s") FROM (SELECT 3020399 AS a UNION SELECT 3020398 ) x GROUP BY 1;
create table t1 (a varchar(15) character set ascii not null);
insert into t1 values ('070514-000000');
drop table t1;
select LAST_DAY('2007-12-06 08:59:19.05') - INTERVAL 1 SECOND;
CREATE TABLE t1(a DOUBLE NOT NULL);
INSERT INTO t1 VALUES (0),(9.216e-096);
SELECT 1 FROM t1 ORDER BY @x:=makedate(a,a);
DROP TABLE t1;
CREATE TABLE t1(a CHAR(10) NOT NULL);
INSERT INTO t1 VALUES (''),('');
SELECT COUNT(*) FROM t1 GROUP BY TIME_TO_SEC(a);
DROP TABLE t1;
SELECT STR_TO_DATE(SPACE(2),'1');
SELECT FORMAT(YEAR(STR_TO_DATE('',GET_FORMAT(TIME,''))),1);
SELECT CAST((MONTH(FROM_UNIXTIME(@@GLOBAL.SQL_MODE))) AS BINARY(1025));
SELECT ADDDATE(MONTH(FROM_UNIXTIME(NULL)),INTERVAL 1 HOUR);
SELECT DATE_FORMAT('0000-00-11', '%W');
SELECT MAKEDATE(11111111,1);
SELECT WEEK(DATE_ADD(FROM_DAYS(1),INTERVAL 1 MONTH), 1);
SELECT LEAST(TIMESTAMP('0000-01-00','0'),'2011-10-24') > 0;
CREATE TABLE t1(c1 DATE NOT NULL PRIMARY KEY, c2 DATE NULL, c3 INT,
INDEX idx2(c2)) ENGINE=InnoDB;
INSERT INTO t1 VALUES(NOW(),NOW(),3),
(ADDTIME(NOW(),'1 01:01:01'),ADDTIME(NOW(),'1 01:01:01'),4),
(ADDTIME(NOW(),'2 01:01:01'),ADDTIME(NOW(),'2 01:01:01'),5),
(ADDTIME(NOW(),'3 01:01:01'),ADDTIME(NOW(),'3 01:01:01'),6);
SELECT * FROM t1;
SELECT * FROM t1 WHERE c1 > ADDTIME(NOW(),'1 01:01:01') ORDER BY c1 DESC;
drop table t1;
CREATE TABLE t1 (`date_date` datetime NOT NULL);
INSERT INTO t1 VALUES ('2008-01-03 00:00:00'), ('2008-01-03 00:00:00');
SELECT * FROM t1 WHERE date_date >= subtime(now(), "00:30:00");
SELECT * FROM t1 WHERE date_date <= addtime(date_add("2000-1-1", INTERVAL "1:1:1" HOUR_SECOND), "00:20:00");
DROP TABLE t1;
SELECT SUBDATE(STR_TO_DATE(NULL,0), INTERVAL 1 HOUR);
SELECT MONTHNAME(0), MONTHNAME(0) IS NULL, MONTHNAME(0) + 1;
CREATE TABLE t1 (a DATETIME NOT NULL);
INSERT INTO t1 VALUES ('2009-09-20 07:32:39.06');
INSERT IGNORE INTO t1 VALUES ('0000-00-00 00:00:00.00');
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT CAST(UNIX_TIMESTAMP(a) AS DECIMAL(25,3)) AS c1 FROM v1 ORDER BY 1;
DROP VIEW v1;
DROP TABLE t1;
SELECT min(timestampadd(month, 1>'', from_days('%Z')));
create table t1(a time);
insert into t1 values ('00:00:00'),('00:01:00');
select 1 from t1 where 1 < some (select cast(a as datetime) from t1);
drop table t1;
CREATE TABLE t1 (a TIME NOT NULL) ENGINE=InnoDB;
INSERT INTO t1 VALUES ('04:39:24');
INSERT INTO t1 VALUES ('00:20:09');
SELECT a FROM t1
WHERE CONVERT_TZ(TIMESTAMPADD(YEAR , a, TIMESTAMP('0000-00-00')),
                 '+00:00','+00:00');
SELECT a FROM t1
WHERE CONVERT_TZ(TIMESTAMPADD(YEAR, a, DATE('0000-00-00')),
                 '+00:00','+00:00');
DROP TABLE t1;
CREATE TABLE t1 (a TIME) ENGINE=InnoDB;
INSERT INTO t1 VALUES ('00:00:00');
SELECT * FROM t1 WHERE TIMESTAMPDIFF(MONTH, a, TIMESTAMP('0000-00-01')) IS NULL;
SELECT * FROM t1 WHERE TIMESTAMPDIFF(MONTH, a, DATE('0000-00-01')) IS NULL;
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(32) NOT NULL);
INSERT INTO t1 VALUES ('a');
SELECT 1 FROM t1 GROUP BY @a:=UNIX_TIMESTAMP(a);
SELECT a, UNIX_TIMESTAMP(a), UNIX_TIMESTAMP('a') FROM t1;
DELETE FROM t1;
INSERT INTO t1 VALUES ('5000-01-01 00:00:00');
DROP TABLE t1;
SELECT CONCAT(UNIX_TIMESTAMP(COUNT(1)), '|');
CREATE TABLE t1 AS SELECT IF(0, coalesce(NULL), now(0)) + 0;
DROP TABLE t1;
CREATE VIEW v1 AS SELECT NOW(6), CURTIME(4), LOCALTIME(3), CURRENT_TIME(2),
CURRENT_TIMESTAMP(0), LOCALTIMESTAMP(1), UTC_TIME(4), UTC_TIMESTAMP(4);
SELECT * FROM v1;
CREATE VIEW v2 AS SELECT LOCATE(".", SYSDATE(6)) != 0;
SELECT * FROM v2;
DROP VIEW v1, v2;
SELECT
timestampadd(year ,1.212208e+308,'1995-01-05 06:32:20.859724') as result;
SELECT
timestampadd(quarter,1.212208e+308,'1995-01-05 06:32:20.859724') as result;
SELECT
timestampadd(month ,1.212208e+308,'1995-01-05 06:32:20.859724') as result;
SELECT
timestampadd(week,1.212208e+308,'1995-01-05 06:32:20.859724') as result;
SELECT
timestampadd(day ,1.212208e+308,'1995-01-05 06:32:20.859724') as result;
SELECT
timestampadd(hour ,1.212208e+308,'1995-01-05 06:32:20.859724') as result;
SELECT
timestampadd(minute ,1.212208e+308,'1995-01-05 06:32:20.859724') as result;
SELECT
timestampadd(second ,1.212208e+308,'1995-01-05 06:32:20.859724') as result;
SELECT
timestampadd(microsecond ,1.212208e+308,'1995-01-05 06:32:20.859724') as result;
SELECT
date_add('1995-01-05', INTERVAL '9223372036854775807-02' YEAR_MONTH) as result;
SELECT
date_add('1995-01-05', INTERVAL '9223372036854775808-02' YEAR_MONTH) as result;
SELECT
date_add('1995-01-05', INTERVAL '9223372036854775808-02' DAY) as result;
SELECT
date_add('1995-01-05', INTERVAL '9223372036854775808-02' WEEK) as result;
SELECT
date_add('1995-01-05', INTERVAL '9223372036854775808-02' SECOND) as result;
SELECT
date_add('1995-01-05', INTERVAL '9223372036854775700-02' YEAR_MONTH) as result;
SELECT
date_add('1995-01-05', INTERVAL 9223372036854775806 SECOND) as result;
SELECT
date_add('1995-01-05', INTERVAL 9223372036854775806 MINUTE) as result;
SELECT
date_add('1995-01-05', INTERVAL 9223372036854775806 HOUR) as result;
SELECT
date_add('1995-01-05', INTERVAL -9223372036854775806 SECOND) as result;
SELECT
date_add('1995-01-05', INTERVAL -9223372036854775806 MINUTE) as result;
SELECT
date_add('1995-01-05', INTERVAL -9223372036854775806 HOUR) as result;
CREATE TABLE t0022 (
  c0000 text
);
DROP TABLE t0022;
CREATE TABLE t AS
  SELECT CAST(TO_DAYS('9999-12-31') AS CHAR) AS x,
         TO_DAYS('9999-12-31') * -4.0 AS y;
SELECT * FROM t;
DROP TABLE t;
CREATE TABLE t1 (
  i1 INT,
  d1 DATETIME
);
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER);
CREATE VIEW v1 AS SELECT (SELECT 'v' FROM DUAL) AS field1 FROM t1 GROUP BY field1
HAVING TIME(field1) != 0 AND  TIMESTAMP(field1) != 0;
DROP VIEW v1;
DROP TABLE t1;
SELECT YEAR('1999-09-11') UNION SELECT YEAR('1999-09-11');
