select str_to_date(concat('15-01-2001',' 2:59:58.999'),
	           concat('%d-%m-%Y',' ','%H:%i:%s.%f'));
select STR_TO_DATE('2004.12.12 22.30.61','%Y.%m.%d %T');
create table t1 (date char(30), format char(30) not null);
insert into t1 values
('2003-01-02 10:11:12', '%Y-%m-%d %H:%i:%S'),
('03-01-02 8:11:2.123456', '%y-%m-%d %H:%i:%S.%#'),
('0003-01-02 8:11:2.123456', '%Y-%m-%d %H:%i:%S.%#'),
('03-01-02 8:11:2.123456',   '%Y-%m-%d %H:%i:%S.%#'),
('2003-01-02 10:11:12 PM', '%Y-%m-%d %h:%i:%S %p'),
('2003-01-02 01:11:12.12345AM', '%Y-%m-%d %h:%i:%S.%f%p'),
('2003-01-02 02:11:12.12345AM', '%Y-%m-%d %h:%i:%S.%f %p'),
('2003-01-02 12:11:12.12345 am', '%Y-%m-%d %h:%i:%S.%f%p'),
('2003-01-02 11:11:12Pm', '%Y-%m-%d %h:%i:%S%p'),
('10:20:10', '%H:%i:%s'),
('10:20:10', '%h:%i:%s.%f'),
('10:20:10', '%T'),
('10:20:10AM', '%h:%i:%s%p'),
('10:20:10AM', '%r'),
('10:20:10.44AM', '%h:%i:%s.%f%p'),
('15-01-2001 12:59:58', '%d-%m-%Y %H:%i:%S'),
('15 September 2001', '%d %M %Y'),
('15 SEPTEMB 2001', '%d %M %Y'),
('15 MAY 2001', '%d %b %Y'),
('15th May 2001', '%D %b %Y'),
('Sunday 15 MAY 2001', '%W %d %b %Y'),
('Sund 15 MAY 2001', '%W %d %b %Y'),
('Tuesday 00 2002', '%W %U %Y'),
('Thursday 53 1998', '%W %u %Y'),
('Sunday 01 2001', '%W %v %x'),
('Tuesday 52 2001', '%W %V %X'),
('060 2004', '%j %Y'),
('4 53 1998', '%w %u %Y'),
('15-01-2001', '%d-%m-%Y %H:%i:%S'),
('15-01-20', '%d-%m-%y'),
('15-2001-1', '%d-%Y-%c');
select date,format,str_to_date(date, format) as str_to_date from t1;
select date,format,concat('',str_to_date(date, format)) as con from t1;
select date,format,cast(str_to_date(date, format) as datetime) as datetime from t1;
select date,format,DATE(str_to_date(date, format)) as date2 from t1;
select date,format,TIME(str_to_date(date, format)) as time from t1;
select date,format,concat(TIME(str_to_date(date, format))) as time2 from t1;
select concat('',str_to_date('8:11:2.123456 03-01-02','%H:%i:%S.%f %y-%m-%d'));
insert into t1 values
('2003-01-02 10:11:12 PM', '%Y-%m-%d %H:%i:%S %p'),
('2003-01-02 10:11:12.123456', '%Y-%m-%d %h:%i:%S %p'),
('2003-01-02 10:11:12AM', '%Y-%m-%d %h:%i:%S.%f %p'),
('2003-01-02 10:11:12AN', '%Y-%m-%d %h:%i:%S%p'),
('2003-01-02 10:11:12 PM', '%y-%m-%d %H:%i:%S %p'),
('10:20:10AM', '%H:%i:%s%p'),
('15 Septembei 2001', '%d %M %Y'),
('15 Ju 2001', '%d %M %Y'),
('Sund 15 MA', '%W %d %b %Y'),
('Thursdai 12 1998', '%W %u %Y'),
('Sunday 01 2001', '%W %v %X'),
('Tuesday 52 2001', '%W %V %x'),
('Tuesday 52 2001', '%W %V %Y'),
('Tuesday 52 2001', '%W %u %x'),
('7 53 1998', '%w %u %Y'),
(NULL, get_format(DATE,'USA'));
select date,format,str_to_date(date, format) as str_to_date from t1;
select date,format,concat(str_to_date(date, format),'') as con from t1;
insert into t1 values
('10:20:10AM', '%h:%i:%s'),
('2003-01-02 10:11:12', '%Y-%m-%d %h:%i:%S'),
('03-01-02 10:11:12 PM', '%Y-%m-%d %h:%i:%S %p');
select date,format,str_to_date(date, format) as str_to_date from t1;
select date,format,concat(str_to_date(date, format),'') as con from t1;
drop table t1;
select get_format(DATE, 'USA') as a;
select get_format(TIME, 'internal') as a;
select get_format(DATETIME, 'eur') as a;
select get_format(TIMESTAMP, 'eur') as a;
select get_format(DATE, 'TEST') as a;
create table t1 (d date);
insert into t1 values ('2004-07-14'),('2005-07-14');
select date_format(d,"%d") from t1 order by 1;
drop table t1;
select str_to_date("2003-....01ABCD-02 10:11:12.0012", "%Y-%.%m%@-%d %H:%i:%S.%f") as a;
create table t1 select "02 10" as a, "%d %H" as b;
select str_to_date("2003-01-02 10:11:12.0012", "%Y-%m-%d %H:%i:%S.%f") as f1,
       str_to_date("2003-01-02 10:11:12.0012", "%Y-%m-%d %H:%i:%S") as f2,
       str_to_date("2003-01-02", "%Y-%m-%d") as f3,
       str_to_date("02 10:11:12", "%d %H:%i:%S.%f") as f4,
       str_to_date("02 10:11:12", "%d %H:%i:%S") as f5,
       str_to_date("02 10", "%d %f") as f6;
select str_to_date("2003-01-02 10:11:12.0012ABCD", "%Y-%m-%d %H:%i:%S.%f") as f1,
       addtime("-01:01:01.01 GGG", "-23:59:59.1") as f2,
       microsecond("1997-12-31 23:59:59.01XXXX") as f3;
select str_to_date("2003-04-05  g", "%Y-%m-%d") as f1,
       str_to_date("2003-04-05 10:11:12.101010234567", "%Y-%m-%d %H:%i:%S.%f") as f2;
drop table t1;
SELECT TIME_FORMAT("24:00:00", '%r');
SELECT DATE_FORMAT('%Y-%m-%d %H:%i:%s', 1151414896);
SELECT DATE_FORMAT("0000-01-01",'%W %d %M %Y') as valid_date;
SELECT DATE_FORMAT("0000-02-28",'%W %d %M %Y') as valid_date;
SELECT DATE_FORMAT("2009-01-01",'%W %d %M %Y') as valid_date;
SELECT LEAST('%', GET_FORMAT(datetime, 'eur'), CAST(GET_FORMAT(datetime, 'eur') AS CHAR(65535)));
SELECT CAST(TIME_FORMAT(NULL, '%s') AS CHAR);
SELECT TIME_FORMAT(NULL, '%s')+0e0;
CREATE TABLE t1 (a varchar(10), PRIMARY KEY (a));
CREATE TABLE t2 (a varchar(10), b date, PRIMARY KEY(a,b));
CREATE TABLE t3 (a varchar(10), b TIME, PRIMARY KEY(a,b));
INSERT INTO t1 VALUES ('test1');
INSERT INTO t2 VALUES
('test1','2016-12-13'),('test1','2016-12-14'),('test1','2016-12-15');
INSERT INTO t3 VALUES
('test1','11:13:14'), ('test1','12:13:14'), ('test1','10:13:14');
SELECT *
FROM t1 LEFT JOIN t2
  ON t2.a = 'test1' AND t2.b = '20161213'
WHERE t1.a = 'test1';
SELECT *
FROM t1 LEFT JOIN t2 IGNORE INDEX(PRIMARY)
  ON t2.a = 'test1' AND t2.b = '20161213'
WHERE t1.a = 'test1';
SELECT b, b = '20161213',
       CASE b WHEN '20161213' then 'found' ELSE 'not found' END FROM t2;
SELECT b, b IN ('20161213'), b in ('20161213', 0) FROM t2;
SELECT b, b = '121314',
       CASE b WHEN '121314' then 'found' ELSE 'not found' END FROM t3;
SELECT b, b in ('121314'), b in ('121314', 0) FROM t3;
DROP TABLE t1, t2, t3;
PREPARE ps FROM "SELECT GET_FORMAT(DATE, ?) AS val";
DEALLOCATE PREPARE ps;
