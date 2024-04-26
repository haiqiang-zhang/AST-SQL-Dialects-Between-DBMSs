drop table if exists t1,t2,t3;

-- Set timezone to GMT-3, to make it possible to use "interval 3 hour"
set time_zone="+03:00";

select from_days(to_days("960101")),to_days(960201)-to_days("19960101"),to_days(date_add(curdate(), interval 1 day))-to_days(curdate()),weekday("1997-11-29");
select period_add("9602",-12),period_diff(199505,"9404") ;

select now()-now(),weekday(curdate())-weekday(now()),unix_timestamp()-unix_timestamp(now());
select from_unixtime(unix_timestamp("1994-03-02 10:11:12")),from_unixtime(unix_timestamp("1994-03-02 10:11:12"),"%Y-%m-%d %h:%i:%s"),from_unixtime(unix_timestamp("1994-03-02 10:11:12"))+0;
select sec_to_time(9001),sec_to_time(9001)+0,time_to_sec("15:12:22"),
  sec_to_time(time_to_sec("0:30:47")/6.21);
select sec_to_time(time_to_sec('-838:59:59'));
select now()-curdate()*1000000-curtime();
select strcmp(current_timestamp(),concat(current_date()," ",current_time()));
select strcmp(localtime(),concat(current_date()," ",current_time()));
select strcmp(localtimestamp(),concat(current_date()," ",current_time()));
select date_format("1997-01-02 03:04:05", "%M %W %D %Y %y %m %d %h %i %s %w");
select date_format("1997-01-02", concat("%M %W %D ","%Y %y %m %d %h %i %s %w"));
select dayofmonth("1997-01-02"),dayofmonth(19970323);
select month("1997-01-02"),year("98-02-03"),dayofyear("1997-12-31");
select month("2001-02-00"),year("2001-00-00");
select DAYOFYEAR("1997-03-03"), WEEK("1998-03-03"), QUARTER(980303);
select HOUR("1997-03-03 23:03:22"), MINUTE("23:03:22"), SECOND(230322);

-- Test of week and yearweek
select week(19980101),week(19970101),week(19980101,1),week(19970101,1);
select week(19981231),week(19971231),week(19981231,1),week(19971231,1);
select week(19950101),week(19950101,1);
select yearweek('1981-12-31',1),yearweek('1982-01-01',1),yearweek('1982-12-31',1),yearweek('1983-01-01',1);
select yearweek('1987-01-01',1),yearweek('1987-01-01');
select week("2000-01-01",0) as '2000', week("2001-01-01",0) as '2001', week("2002-01-01",0) as '2002',week("2003-01-01",0) as '2003', week("2004-01-01",0) as '2004', week("2005-01-01",0) as '2005', week("2006-01-01",0) as '2006';
select week("2000-01-06",0) as '2000', week("2001-01-06",0) as '2001', week("2002-01-06",0) as '2002',week("2003-01-06",0) as '2003', week("2004-01-06",0) as '2004', week("2005-01-06",0) as '2005', week("2006-01-06",0) as '2006';
select week("2000-01-01",1) as '2000', week("2001-01-01",1) as '2001', week("2002-01-01",1) as '2002',week("2003-01-01",1) as '2003', week("2004-01-01",1) as '2004', week("2005-01-01",1) as '2005', week("2006-01-01",1) as '2006';
select week("2000-01-06",1) as '2000', week("2001-01-06",1) as '2001', week("2002-01-06",1) as '2002',week("2003-01-06",1) as '2003', week("2004-01-06",1) as '2004', week("2005-01-06",1) as '2005', week("2006-01-06",1) as '2006';
select yearweek("2000-01-01",0) as '2000', yearweek("2001-01-01",0) as '2001', yearweek("2002-01-01",0) as '2002',yearweek("2003-01-01",0) as '2003', yearweek("2004-01-01",0) as '2004', yearweek("2005-01-01",0) as '2005', yearweek("2006-01-01",0) as '2006';
select yearweek("2000-01-06",0) as '2000', yearweek("2001-01-06",0) as '2001', yearweek("2002-01-06",0) as '2002',yearweek("2003-01-06",0) as '2003', yearweek("2004-01-06",0) as '2004', yearweek("2005-01-06",0) as '2005', yearweek("2006-01-06",0) as '2006';
select yearweek("2000-01-01",1) as '2000', yearweek("2001-01-01",1) as '2001', yearweek("2002-01-01",1) as '2002',yearweek("2003-01-01",1) as '2003', yearweek("2004-01-01",1) as '2004', yearweek("2005-01-01",1) as '2005', yearweek("2006-01-01",1) as '2006';
select yearweek("2000-01-06",1) as '2000', yearweek("2001-01-06",1) as '2001', yearweek("2002-01-06",1) as '2002',yearweek("2003-01-06",1) as '2003', yearweek("2004-01-06",1) as '2004', yearweek("2005-01-06",1) as '2005', yearweek("2006-01-06",1) as '2006';
select week(19981231,2), week(19981231,3), week(20000101,2), week(20000101,3);
select week(20001231,2),week(20001231,3);

select week(19981231,0) as '0', week(19981231,1) as '1', week(19981231,2) as '2', week(19981231,3) as '3', week(19981231,4) as '4', week(19981231,5) as '5', week(19981231,6) as '6', week(19981231,7) as '7';
select week(20000101,0) as '0', week(20000101,1) as '1', week(20000101,2) as '2', week(20000101,3) as '3', week(20000101,4) as '4', week(20000101,5) as '5', week(20000101,6) as '6', week(20000101,7) as '7';
select week(20000106,0) as '0', week(20000106,1) as '1', week(20000106,2) as '2', week(20000106,3) as '3', week(20000106,4) as '4', week(20000106,5) as '5', week(20000106,6) as '6', week(20000106,7) as '7';
select week(20001231,0) as '0', week(20001231,1) as '1', week(20001231,2) as '2', week(20001231,3) as '3', week(20001231,4) as '4', week(20001231,5) as '5', week(20001231,6) as '6', week(20001231,7) as '7';
select week(20010101,0) as '0', week(20010101,1) as '1', week(20010101,2) as '2', week(20010101,3) as '3', week(20010101,4) as '4', week(20010101,5) as '5', week(20010101,6) as '6', week(20010101,7) as '7';

select yearweek(20001231,0), yearweek(20001231,1), yearweek(20001231,2), yearweek(20001231,3), yearweek(20001231,4), yearweek(20001231,5), yearweek(20001231,6), yearweek(20001231,7);

set default_week_format = 6;
select week(20001231), week(20001231,6);
set default_week_format = 0;

set default_week_format = 2;
select week(20001231),week(20001231,2),week(20001231,0);
set default_week_format = 0;

select date_format('1998-12-31','%x-%v'),date_format('1999-01-01','%x-%v');
select date_format('1999-12-31','%x-%v'),date_format('2000-01-01','%x-%v');

select dayname("1962-03-03"),dayname("1962-03-03")+0;
select monthname("1972-03-04"),monthname("1972-03-04")+0;
select time_format(19980131000000,'%H|%I|%k|%l|%i|%p|%r|%S|%T');
select time_format(19980131010203,'%H|%I|%k|%l|%i|%p|%r|%S|%T');
select time_format(19980131131415,'%H|%I|%k|%l|%i|%p|%r|%S|%T');
select time_format(19980131010015,'%H|%I|%k|%l|%i|%p|%r|%S|%T');
select date_format(concat('19980131',131415),'%H|%I|%k|%l|%i|%p|%r|%S|%T| %M|%W|%D|%Y|%y|%a|%b|%j|%m|%d|%h|%s|%w');
select date_format(19980021000000,'%H|%I|%k|%l|%i|%p|%r|%S|%T| %M|%W|%D|%Y|%y|%a|%b|%j|%m|%d|%h|%s|%w');
select date_add("1997-12-31 23:59:59",INTERVAL 1 SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL 1 MINUTE);
select date_add("1997-12-31 23:59:59",INTERVAL 1 HOUR);
select date_add("1997-12-31 23:59:59",INTERVAL 1 DAY);
select date_add("1997-12-31 23:59:59",INTERVAL 1 MONTH);
select date_add("1997-12-31 23:59:59",INTERVAL 1 YEAR);
select date_add("1997-12-31 23:59:59",INTERVAL "1:1" MINUTE_SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL "1:1" HOUR_MINUTE);
select date_add("1997-12-31 23:59:59",INTERVAL "1:1" DAY_HOUR);
select date_add("1997-12-31 23:59:59",INTERVAL "1 1" YEAR_MONTH);
select date_add("1997-12-31 23:59:59",INTERVAL "1:1:1" HOUR_SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL "1 1:1" DAY_MINUTE);
select date_add("1997-12-31 23:59:59",INTERVAL "1 1:1:1" DAY_SECOND);

select date_sub("1998-01-01 00:00:00",INTERVAL 1 SECOND);
select date_sub("1998-01-01 00:00:00",INTERVAL 1 MINUTE);
select date_sub("1998-01-01 00:00:00",INTERVAL 1 HOUR);
select date_sub("1998-01-01 00:00:00",INTERVAL 1 DAY);
select date_sub("1998-01-01 00:00:00",INTERVAL 1 MONTH);
select date_sub("1998-01-01 00:00:00",INTERVAL 1 YEAR);
select date_sub("1998-01-01 00:00:00",INTERVAL "1:1" MINUTE_SECOND);
select date_sub("1998-01-01 00:00:00",INTERVAL "1:1" HOUR_MINUTE);
select date_sub("1998-01-01 00:00:00",INTERVAL "1:1" DAY_HOUR);
select date_sub("1998-01-01 00:00:00",INTERVAL "1 1" YEAR_MONTH);
select date_sub("1998-01-01 00:00:00",INTERVAL "1:1:1" HOUR_SECOND);
select date_sub("1998-01-01 00:00:00",INTERVAL "1 1:1" DAY_MINUTE);
select date_sub("1998-01-01 00:00:00",INTERVAL "1 1:1:1" DAY_SECOND);

select date_add("1997-12-31 23:59:59",INTERVAL 100000 SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL -100000 MINUTE);
select date_add("1997-12-31 23:59:59",INTERVAL 100000 HOUR);
select date_add("1997-12-31 23:59:59",INTERVAL -100000 DAY);
select date_add("1997-12-31 23:59:59",INTERVAL 100000 MONTH);
select date_add("1997-12-31 23:59:59",INTERVAL -100000 YEAR);
select date_add("1997-12-31 23:59:59",INTERVAL "10000:1" MINUTE_SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL "-10000:1" HOUR_MINUTE);
select date_add("1997-12-31 23:59:59",INTERVAL "10000:1" DAY_HOUR);
select date_add("1997-12-31 23:59:59",INTERVAL "-100 1" YEAR_MONTH);
select date_add("1997-12-31 23:59:59",INTERVAL "10000:99:99" HOUR_SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL " -10000 99:99" DAY_MINUTE);
select date_add("1997-12-31 23:59:59",INTERVAL "10000 99:99:99" DAY_SECOND);
select "1997-12-31 23:59:59" + INTERVAL 1 SECOND;
select INTERVAL 1 DAY + "1997-12-31";
select "1998-01-01 00:00:00" - INTERVAL 1 SECOND;

select date_sub("1998-01-02",INTERVAL 31 DAY);
select date_add("1997-12-31",INTERVAL 1 SECOND);
select date_add("1997-12-31",INTERVAL 1 DAY);
select date_add(NULL,INTERVAL 100000 SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL NULL SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL NULL MINUTE_SECOND);
select date_add("9999-12-31 23:59:59",INTERVAL 1 SECOND);
select date_sub("0000-00-00 00:00:00",INTERVAL 1 SECOND);
select date_add('1998-01-30',Interval 1 month);
select date_add('1998-01-30',Interval '2:1' year_month);
select date_add('1996-02-29',Interval '1' year);
select extract(YEAR FROM "1999-01-02 10:11:12");
select extract(YEAR_MONTH FROM "1999-01-02");
select extract(DAY FROM "1999-01-02");
select extract(DAY_HOUR FROM "1999-01-02 10:11:12");
select extract(DAY_MINUTE FROM "02 10:11:12");
select extract(DAY_SECOND FROM "225 10:11:12");
select extract(HOUR FROM "1999-01-02 10:11:12");
select extract(HOUR_MINUTE FROM "10:11:12");
select extract(HOUR_SECOND FROM "10:11:12");
select extract(MINUTE FROM "10:11:12");
select extract(MINUTE_SECOND FROM "10:11:12");
select extract(SECOND FROM "1999-01-02 10:11:12");
select extract(MONTH FROM "2001-02-00");

--
-- test EXTRACT QUARTER (Bug #18100)
--

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

--
-- Test big intervals (Bug #3498)
--
SELECT "1900-01-01 00:00:00" + INTERVAL 2147483648 SECOND;
SELECT "1900-01-01 00:00:00" + INTERVAL "1:2147483647" MINUTE_SECOND;
SELECT "1900-01-01 00:00:00" + INTERVAL "100000000:214748364700" MINUTE_SECOND;
SELECT "1900-01-01 00:00:00" + INTERVAL 1<<31 MINUTE;
SELECT "1900-01-01 00:00:00" + INTERVAL 1<<20 HOUR;

SELECT "1900-01-01 00:00:00" + INTERVAL 1<<38 SECOND;
SELECT "1900-01-01 00:00:00" + INTERVAL 1<<33 MINUTE;
SELECT "1900-01-01 00:00:00" + INTERVAL 1<<30 HOUR;
SELECT "1900-01-01 00:00:00" + INTERVAL "1000000000:214748364700" MINUTE_SECOND;

--
-- Bug #614 (multiple extracts in where)
--

create table t1 (ctime varchar(20));
insert into t1 values ('2001-01-12 12:23:40');
select ctime, hour(ctime) from t1;
select ctime from t1 where extract(MONTH FROM ctime) = 1 AND extract(YEAR FROM ctime) = 2001;
drop table t1;

--
-- Test bug with monthname() and NULL
--

create table t1 (id int);
create table t2 (id int, date date);
insert into t1 values (1);
insert ignore into t2 values (1, "0000-00-00");
insert into t1 values (2);
insert into t2 values (2, "2000-01-01");
select monthname(date) from t1 inner join t2 on t1.id = t2.id;
select monthname(date) from t1 inner join t2 on t1.id = t2.id order by t1.id;
drop table t1,t2;

--
-- Test bug with month() and year() on text fields with wrong information

CREATE TABLE t1 (updated text) ENGINE=Innodb;
INSERT INTO t1 VALUES ('');
SELECT month(updated) from t1;
SELECT year(updated) from t1;
drop table t1;

--
-- Check that functions work identically on 0000-00-00 as a constant and on a
-- column
--

create table t1 (d date, dt datetime, t timestamp, c char(10));
insert ignore into t1 values ("0000-00-00", "0000-00-00", "0000-00-00", "0000-00-00");
select dayofyear("0000-00-00"),dayofyear(d),dayofyear(dt),dayofyear(t),dayofyear(c) from t1;
select dayofmonth("0000-00-00"),dayofmonth(d),dayofmonth(dt),dayofmonth(t),dayofmonth(c) from t1;
select month("0000-00-00"),month(d),month(dt),month(t),month(c) from t1;
select quarter("0000-00-00"),quarter(d),quarter(dt),quarter(t),quarter(c) from t1;
select week("0000-00-00"),week(d),week(dt),week(t),week(c) from t1;
select year("0000-00-00"),year(d),year(dt),year(t),year(c) from t1;
select yearweek("0000-00-00"),yearweek(d),yearweek(dt),yearweek(t),yearweek(c) from t1;
select to_days("0000-00-00"),to_days(d),to_days(dt),to_days(t),to_days(c) from t1;
select extract(MONTH FROM "0000-00-00"),extract(MONTH FROM d),extract(MONTH FROM dt),extract(MONTH FROM t),extract(MONTH FROM c) from t1;
drop table t1;


--
-- Test problem with TIMESTAMP and BETWEEN
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 ( start datetime default NULL);
INSERT INTO t1 VALUES ('2002-10-21 00:00:00'),('2002-10-28 00:00:00'),('2002-11-04 00:00:00');
CREATE TABLE t2 ( ctime1 timestamp NOT NULL, ctime2 timestamp NOT NULL);
INSERT INTO t2 VALUES (20021029165106,20021105164731);
CREATE TABLE t3 (ctime1 char(19) NOT NULL, ctime2 char(19) NOT NULL);
INSERT INTO t3 VALUES ("2002-10-29 16:51:06","2002-11-05 16:47:31");

-- The following statement should be fixed to return a row in 4.1
select * from t1, t2 where t1.start between t2.ctime1 and t2.ctime2;
select * from t1, t2 where t1.start >= t2.ctime1 and t1.start <= t2.ctime2;
select * from t1, t3 where t1.start between t3.ctime1 and t3.ctime2;
drop table t1,t2,t3;
SET sql_mode = default;
select @a:=FROM_UNIXTIME(1);
select unix_timestamp(@a);
select unix_timestamp('1969-12-01 19:00:01');

--
-- Tests for bug #6439 "unix_timestamp() function returns wrong datetime 
-- values for too big argument", bug #7515 "from_unixtime(0) now
-- returns NULL instead of the epoch" and bug #9191
-- "TIMESTAMP/from_unixtime() no longer accepts 2^31-1."
-- unix_timestamp() should return error for too big or negative argument.
-- It should return Epoch value for zero argument since it seems that many
-- users rely on this fact, from_unixtime() should work with values
-- up to INT_MAX32 because of the same reason.
--
select from_unixtime(-1);
SELECT FROM_UNIXTIME(-0.000001);
select from_unixtime(0);


--
-- Bug #28759: DAYNAME() and MONTHNAME() return binary string
--

SELECT CHARSET(DAYNAME(19700101));
SELECT CHARSET(MONTHNAME(19700101));
SELECT LOWER(DAYNAME(19700101));
SELECT LOWER(MONTHNAME(19700101));
SELECT COERCIBILITY(MONTHNAME('1970-01-01')),COERCIBILITY(DAYNAME('1970-01-01'));

--
-- Test types from + INTERVAL
--

CREATE TABLE t1 (datetime datetime, timestamp timestamp, date date, time time);
INSERT INTO t1 values ("2001-01-02 03:04:05", "2002-01-02 03:04:05", "2003-01-02", "06:07:08");
SELECT * from t1;
select date_add("1997-12-31",INTERVAL 1 SECOND);
select date_add("1997-12-31",INTERVAL "1 1" YEAR_MONTH);

select date_add(datetime, INTERVAL 1 SECOND) from t1;
select date_add(datetime, INTERVAL 1 YEAR) from t1;

select date_add(date,INTERVAL 1 SECOND) from t1;
select date_add(date,INTERVAL 1 MINUTE) from t1;
select date_add(date,INTERVAL 1 HOUR) from t1;
select date_add(date,INTERVAL 1 DAY) from t1;
select date_add(date,INTERVAL 1 MONTH) from t1;
select date_add(date,INTERVAL 1 YEAR) from t1;
select date_add(date,INTERVAL "1:1" MINUTE_SECOND) from t1;
select date_add(date,INTERVAL "1:1" HOUR_MINUTE) from t1;
select date_add(date,INTERVAL "1:1" DAY_HOUR) from t1;
select date_add(date,INTERVAL "1 1" YEAR_MONTH) from t1;
select date_add(date,INTERVAL "1:1:1" HOUR_SECOND) from t1;
select date_add(date,INTERVAL "1 1:1" DAY_MINUTE) from t1;
select date_add(date,INTERVAL "1 1:1:1" DAY_SECOND) from t1;
select date_add(date,INTERVAL "1" WEEK) from t1;
select date_add(date,INTERVAL "1" QUARTER) from t1;
select timestampadd(MINUTE, 1, date) from t1;
select timestampadd(WEEK, 1, date) from t1;
select timestampadd(SQL_TSI_SECOND, 1, date) from t1;

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

-- bug 16226
SELECT TIMESTAMPDIFF(day,'2006-01-10 14:30:28','2006-01-11 14:30:27');
SELECT TIMESTAMPDIFF(day,'2006-01-10 14:30:28','2006-01-11 14:30:28');
SELECT TIMESTAMPDIFF(day,'2006-01-10 14:30:28','2006-01-11 14:30:29');
SELECT TIMESTAMPDIFF(day,'2006-01-10 14:30:28','2006-01-12 14:30:27');
SELECT TIMESTAMPDIFF(day,'2006-01-10 14:30:28','2006-01-12 14:30:28');
SELECT TIMESTAMPDIFF(day,'2006-01-10 14:30:28','2006-01-12 14:30:29');

SELECT TIMESTAMPDIFF(week,'2006-01-10 14:30:28','2006-01-17 14:30:27');
SELECT TIMESTAMPDIFF(week,'2006-01-10 14:30:28','2006-01-17 14:30:28');
SELECT TIMESTAMPDIFF(week,'2006-01-10 14:30:28','2006-01-17 14:30:29');
SELECT TIMESTAMPDIFF(week,'2006-01-10 14:30:28','2006-01-24 14:30:27');
SELECT TIMESTAMPDIFF(week,'2006-01-10 14:30:28','2006-01-24 14:30:28');
SELECT TIMESTAMPDIFF(week,'2006-01-10 14:30:28','2006-01-24 14:30:29');

SELECT TIMESTAMPDIFF(month,'2006-01-10 14:30:28','2006-02-10 14:30:27');
SELECT TIMESTAMPDIFF(month,'2006-01-10 14:30:28','2006-02-10 14:30:28');
SELECT TIMESTAMPDIFF(month,'2006-01-10 14:30:28','2006-02-10 14:30:29');
SELECT TIMESTAMPDIFF(month,'2006-01-10 14:30:28','2006-03-10 14:30:27');
SELECT TIMESTAMPDIFF(month,'2006-01-10 14:30:28','2006-03-10 14:30:28');
SELECT TIMESTAMPDIFF(month,'2006-01-10 14:30:28','2006-03-10 14:30:29');

SELECT TIMESTAMPDIFF(year,'2006-01-10 14:30:28','2007-01-10 14:30:27');
SELECT TIMESTAMPDIFF(year,'2006-01-10 14:30:28','2007-01-10 14:30:28');
SELECT TIMESTAMPDIFF(year,'2006-01-10 14:30:28','2007-01-10 14:30:29');
SELECT TIMESTAMPDIFF(year,'2006-01-10 14:30:28','2008-01-10 14:30:27');
SELECT TIMESTAMPDIFF(year,'2006-01-10 14:30:28','2008-01-10 14:30:28');
SELECT TIMESTAMPDIFF(year,'2006-01-10 14:30:28','2008-01-10 14:30:29');

-- end of bug

select date_add(time,INTERVAL 1 SECOND) from t1;
drop table t1;

-- test for last_day
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

select date_add(last_day("1997-12-1"), INTERVAL 1 DAY);
select length(last_day("1997-12-1"));
select last_day("1997-12-1")+0;
select last_day("1997-12-1")+0.0;

-- Test SAPDB UTC_% functions. This part is TZ dependant (It is supposed that
-- TZ variable set to GMT-3

select strcmp(date_sub(localtimestamp(), interval 3 hour), utc_timestamp())=0;
select strcmp(date_format(date_sub(localtimestamp(), interval 3 hour),"%T"), utc_time())=0;
select strcmp(date_format(date_sub(localtimestamp(), interval 3 hour),"%Y-%m-%d"), utc_date())=0;
select strcmp(date_format(utc_timestamp(),"%T"), utc_time())=0;
select strcmp(date_format(utc_timestamp(),"%Y-%m-%d"), utc_date())=0;
select strcmp(concat(utc_date(),' ',utc_time()),utc_timestamp())=0;

SET @TMP='2007-08-01 12:22:49';
CREATE TABLE t1 (d DATETIME);
INSERT INTO t1 VALUES ('2007-08-01 12:22:59');
INSERT INTO t1 VALUES ('2007-08-01 12:23:01');
INSERT INTO t1 VALUES ('2007-08-01 12:23:20');
SELECT count(*) FROM t1 WHERE d>FROM_DAYS(TO_DAYS(@TMP)) AND d<=FROM_DAYS(TO_DAYS(@TMP)+1);
DROP TABLE t1;

--
-- Bug #10568
--

select last_day('2005-00-00');
select last_day('2005-00-01');
select last_day('2005-01-00');

--
-- Bug #18501: monthname and NULLs
--

select monthname(str_to_date(null, '%m')), monthname(str_to_date(null, '%m')),
       monthname(str_to_date(1, '%m')), monthname(str_to_date(0, '%m'));

--
-- Bug #16327: problem with timestamp < 1970
--

set time_zone='-6:00';
create table t1(a timestamp);
insert into t1 values (19691231190001);
select * from t1;
drop table t1;

--
-- Bug#16377 result of DATE/TIME functions were compared as strings which
--           can lead to a wrong result.
-- Now wrong dates should be compared only with CAST()
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

--
-- Bug #16546
-- 

create table t1 select now() - now(), curtime() - curtime(), 
                       sec_to_time(1) + 0, from_unixtime(1) + 0;
drop table t1;

--
-- Bug #11655: Wrong time is returning from nested selects - maximum time exists
--
-- check if SEC_TO_TIME() handles out-of-range values correctly
SELECT SEC_TO_TIME(3300000);
SELECT SEC_TO_TIME(3300000)+0;
SELECT SEC_TO_TIME(3600 * 4294967296);

-- check if TIME_TO_SEC() handles out-of-range values correctly
SELECT TIME_TO_SEC('916:40:00');

-- check if ADDTIME() handles out-of-range values correctly
SELECT ADDTIME('500:00:00', '416:40:00');
SELECT ADDTIME('916:40:00', '416:40:00');

-- check if SUBTIME() handles out-of-range values correctly
SELECT SUBTIME('916:40:00', '416:40:00');
SELECT SUBTIME('-916:40:00', '416:40:00');

-- check if MAKETIME() handles out-of-range values correctly
SELECT MAKETIME(916,0,0);
SELECT MAKETIME(4294967296, 0, 0);
SELECT MAKETIME(-4294967296, 0, 0);
SELECT MAKETIME(0, 4294967296, 0);
SELECT MAKETIME(0, 0, 4294967296);
SELECT MAKETIME(CAST(-1 AS UNSIGNED), 0, 0);

-- check if EXTRACT() handles out-of-range values correctly
SELECT EXTRACT(HOUR FROM '100000:02:03');

-- check if we get proper warnings if both input string truncation
-- and out-of-range value occur
CREATE TABLE t1(f1 TIME);
INSERT IGNORE INTO t1 VALUES('916:00:00 a');
SELECT * FROM t1;
DROP TABLE t1;

--
-- Bug #20927: sec_to_time treats big unsigned as signed
--
-- check if SEC_TO_TIME() handles BIGINT UNSIGNED values correctly
SELECT SEC_TO_TIME(CAST(-1 AS UNSIGNED));

--
-- 21913: DATE_FORMAT() Crashes mysql server if I use it through
--        mysql-connector-j driver.
--

SET NAMES latin1;
SET character_set_results = NULL;

CREATE TABLE testBug8868 (field1 DATE, field2 VARCHAR(32) CHARACTER SET BINARY);
INSERT INTO testBug8868 VALUES ('2006-09-04', 'abcd');

SELECT DATE_FORMAT(field1,'%b-%e %l:%i%p') as fmtddate, field2 FROM testBug8868;

DROP TABLE testBug8868;

SET NAMES DEFAULT;

--
-- Bug #31160: MAKETIME() crashes server when returning NULL in ORDER BY using 
-- filesort
--
CREATE TABLE t1 (
  a TIMESTAMP
);
INSERT INTO t1 VALUES (now()), (now());
SELECT 1 FROM t1 ORDER BY MAKETIME(1, 1, a);
DROP TABLE t1;
--

(select time_format(timediff(now(), DATE_SUB(now(),INTERVAL 5 DAY)),'%H') As H)
union
(select time_format(timediff(now(), DATE_SUB(now(),INTERVAL 5 DAY)),'%H') As H);

--
-- Bug #23653: crash if last_day('0000-00-00')
--

select last_day('0000-00-00');

--
-- Bug 23616: datetime functions with double argumets
--

select isnull(week(now() + 0)), isnull(week(now() + 0.2)),
  week(20061108), week(20061108.01), week(20061108085411.000002);

--
-- Bug #10590: %h, %I, and %l format specifies should all return results in
-- the 0-11 range
--
select time_format('100:00:00', '%H %k %h %I %l');

--
-- Bug #12562: Make SYSDATE behave like it does in Oracle: always the current
--             time, regardless of magic to make NOW() always the same for the
--             entirety of a statement.
SET @old_log_bin_trust_function_creators= @@global.log_bin_trust_function_creators;
SET GLOBAL log_bin_trust_function_creators = 1;

create table t1 (a timestamp default '2005-05-05 01:01:01',
                 b timestamp default '2005-05-05 01:01:01');
drop function if exists t_slow_sysdate;
create function t_slow_sysdate() returns timestamp
begin
  do sleep(2);
//

insert into t1 set a = sysdate(), b = t_slow_sysdate();

create trigger t_before before insert on t1
for each row begin
  set new.b = t_slow_sysdate();
end
//

delimiter ;

insert into t1 set a = sysdate();

select a != b from t1;

drop trigger t_before;
drop function t_slow_sysdate;
drop table t1;

SET GLOBAL log_bin_trust_function_creators = 0;

create table t1 (a datetime, i int, b datetime);
insert into t1 select sysdate(), sleep(1), sysdate() from dual;
select a != b from t1;
drop table t1;
create procedure t_sysdate()
begin
  select sysdate() into @a;
  do sleep(2);
  select sysdate() into @b;
  select @a != @b;
drop procedure t_sysdate;
SET @@global.log_bin_trust_function_creators= @old_log_bin_trust_function_creators;

--
-- Bug #13534: timestampdiff() returned incorrect results across leap years
--
select timestampdiff(month,'2004-09-11','2004-09-11');
select timestampdiff(month,'2004-09-11','2005-09-11');
select timestampdiff(month,'2004-09-11','2006-09-11');
select timestampdiff(month,'2004-09-11','2007-09-11');
select timestampdiff(month,'2005-09-11','2004-09-11');
select timestampdiff(month,'2005-09-11','2003-09-11');

select timestampdiff(month,'2004-02-28','2005-02-28');
select timestampdiff(month,'2004-02-29','2005-02-28');
select timestampdiff(month,'2004-02-28','2005-02-28');
select timestampdiff(month,'2004-03-29','2005-03-28');
select timestampdiff(month,'2003-02-28','2004-02-29');
select timestampdiff(month,'2003-02-28','2005-02-28');

select timestampdiff(month,'1999-09-11','2001-10-10');
select timestampdiff(month,'1999-09-11','2001-9-11');

select timestampdiff(year,'1999-09-11','2001-9-11');
select timestampdiff(year,'2004-02-28','2005-02-28');
select timestampdiff(year,'2004-02-29','2005-02-28');

--
-- Bug #18618: BETWEEN for dates with the second argument being a constant
--             expression and the first and the third arguments being fields 
--

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


-- Restore timezone to default
set time_zone= @@global.time_zone;

--
-- Bug #22229: bug in DATE_ADD()
--

select str_to_date('10:00 PM', '%h:%i %p') + INTERVAL 10 MINUTE;

--
-- Bug #21103: DATE column not compared as DATE
--

create table t1 (field DATE);
insert into t1 values ('2006-11-06');
select * from t1 where field < '2006-11-06 04:08:36.0';
select * from t1 where field = '2006-11-06 04:08:36.0';
select * from t1 where field = '2006-11-06';
select * from t1 where CAST(field as DATETIME) < '2006-11-06 04:08:36.0';
select * from t1 where CAST(field as DATE) < '2006-11-06 04:08:36.0';
drop table t1;

--
-- Bug #25643: SEC_TO_TIME function problem
--
CREATE TABLE t1 (a int, t1 time, t2 time, d date, PRIMARY KEY  (a));
INSERT INTO t1 VALUES (1, '10:00:00', NULL, NULL), 
       (2, '11:00:00', '11:15:00', '1972-02-06');
SELECT t1, t2, SEC_TO_TIME( TIME_TO_SEC( t2 ) - TIME_TO_SEC( t1 ) ), QUARTER(d) 
  FROM t1;
SELECT t1, t2, SEC_TO_TIME( TIME_TO_SEC( t2 ) - TIME_TO_SEC( t1 ) ), QUARTER(d)
  FROM t1 ORDER BY a DESC;
DROP TABLE t1;

--
-- Bug #20293: group by cuts off value from time_format
--
-- Check if using GROUP BY with TIME_FORMAT() produces correct results

--sorted_result
SELECT TIME_FORMAT(SEC_TO_TIME(a),"%H:%i:%s") FROM (SELECT 3020399 AS a UNION SELECT 3020398 ) x GROUP BY 1;

--
-- Bug#28875 Conversion between ASCII and LATIN1 charsets does not function
--
set names latin1;
create table t1 (a varchar(15) character set ascii not null);
insert into t1 values ('070514-000000');

-- Conversion of date_format() result to ASCII
-- is safe with the default locale en_US
--replace_column 1 --
select concat(a,ifnull(min(date_format(now(), '%Y-%m-%d')),' ull')) from t1;
set names swe7;
select concat(a,ifnull(min(date_format(now(), '%Y-%m-%d')),' ull')) from t1;
set names latin1;
set lc_time_names=fr_FR;
select concat(a,ifnull(min(date_format(now(), '%Y-%m-%d')),' ull')) from t1;
set lc_time_names=en_US;
drop table t1;

--
-- Bug#32180: DATE_ADD treats datetime numeric argument as DATE
--            instead of DATETIME
--

select DATE_ADD('20071108181000', INTERVAL 1 DAY);
select DATE_ADD(20071108181000,   INTERVAL 1 DAY);
select DATE_ADD('20071108',       INTERVAL 1 DAY);
select DATE_ADD(20071108,         INTERVAL 1 DAY);

--
-- Bug#32770: LAST_DAY() returns a DATE, but somehow internally keeps
--            track of the TIME.
--

select LAST_DAY('2007-12-06 08:59:19.05') - INTERVAL 1 SECOND;

-- Bug#33834: FRAC_SECOND: Applicability not clear in documentation
--
-- Test case removed since FRAC_SECOND was deprecated and
-- removed as part of WL#5154
--

--
-- Bug #36466:
--   Adding days to day_microsecond changes interpretation of microseconds
--

-- show that we treat fractions of seconds correctly (zerofill from right to
-- six places) even if we left out fields on the left.
select date_add('1000-01-01 00:00:00', interval '1.03:02:01.05' day_microsecond);
select date_add('1000-01-01 00:00:00', interval '1.02' day_microsecond);
SET TIMESTAMP=-147490000;
SET TIMESTAMP=2147483648;
SET TIMESTAMP=2147483646;
SET TIMESTAMP=2147483647;
SET TIMESTAMP=0;
SET TIMESTAMP=-1;
SET TIMESTAMP=1;
SET TIMESTAMP=0;

--
-- Bug #18997
--

select date_sub("0050-01-01 00:00:01",INTERVAL 2 SECOND);
select date_sub("0199-01-01 00:00:01",INTERVAL 2 SECOND);
select date_add("0199-12-31 23:59:59",INTERVAL 2 SECOND);
select date_sub("0200-01-01 00:00:01",INTERVAL 2 SECOND);
select date_sub("0200-01-01 00:00:01",INTERVAL 1 SECOND);
select date_sub("0200-01-01 00:00:01",INTERVAL 2 SECOND);
select date_add("2001-01-01 23:59:59",INTERVAL -2000 YEAR);
select date_sub("50-01-01 00:00:01",INTERVAL 2 SECOND);
select date_sub("90-01-01 00:00:01",INTERVAL 2 SECOND);
select date_sub("0069-01-01 00:00:01",INTERVAL 2 SECOND);
select date_sub("0169-01-01 00:00:01",INTERVAL 2 SECOND);


--
-- Bug #55565: debug assertion when ordering by expressions with user
-- variable assignments
--

CREATE TABLE t1(a DOUBLE NOT NULL);
INSERT INTO t1 VALUES (0),(9.216e-096);
SELECT 1 FROM t1 ORDER BY @x:=makedate(a,a);
DROP TABLE t1;

CREATE TABLE t1(a CHAR(10) NOT NULL);
INSERT INTO t1 VALUES (''),('');
SELECT COUNT(*) FROM t1 GROUP BY TIME_TO_SEC(a);
DROP TABLE t1;

SELECT STR_TO_DATE(SPACE(2),'1');

SET GLOBAL SQL_MODE='';
DO  STR_TO_DATE((''), FROM_DAYS(@@GLOBAL.SQL_MODE));
SET GLOBAL SQL_MODE=DEFAULT;

SELECT FORMAT(YEAR(STR_TO_DATE('',GET_FORMAT(TIME,''))),1);

SET @@global.sql_mode='';
SELECT CAST((MONTH(FROM_UNIXTIME(@@GLOBAL.SQL_MODE))) AS BINARY(1025));
SET @@global.sql_mode=DEFAULT;

SELECT ADDDATE(MONTH(FROM_UNIXTIME(NULL)),INTERVAL 1 HOUR);

SELECT DATE_FORMAT('0000-00-11', '%W');
SELECT DATE_FORMAT('0000-00-11', '%a');
SELECT DATE_FORMAT('0000-00-11', '%w');

SELECT MAKEDATE(11111111,1);
SELECT WEEK(DATE_ADD(FROM_DAYS(1),INTERVAL 1 MONTH), 1);

DO WEEK((DATE_ADD((CAST(0 AS DATE)), INTERVAL 1 YEAR_MONTH)), 5);
SELECT SUBTIME('0000-01-00 00:00','00:00');
SELECT LEAST(TIMESTAMP('0000-01-00','0'),'2011-10-24') > 0;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
SET sql_mode = default;

CREATE TABLE t1(c1 DATE NOT NULL PRIMARY KEY, c2 DATE NULL, c3 INT,
INDEX idx2(c2)) ENGINE=InnoDB;
SET TIMESTAMP=1235553613;
INSERT INTO t1 VALUES(NOW(),NOW(),3),
(ADDTIME(NOW(),'1 01:01:01'),ADDTIME(NOW(),'1 01:01:01'),4),
(ADDTIME(NOW(),'2 01:01:01'),ADDTIME(NOW(),'2 01:01:01'),5),
(ADDTIME(NOW(),'3 01:01:01'),ADDTIME(NOW(),'3 01:01:01'),6);
SELECT * FROM t1;

-- bug was that 3 rows were returned
SELECT * FROM t1 WHERE c1 > ADDTIME(NOW(),'1 01:01:01') ORDER BY c1 DESC;

drop table t1;
CREATE TABLE t1 (`date_date` datetime NOT NULL);
INSERT INTO t1 VALUES ('2008-01-03 00:00:00'), ('2008-01-03 00:00:00');
SELECT * FROM t1 WHERE date_date >= subtime(now(), "00:30:00");
SELECT * FROM t1 WHERE date_date <= addtime(date_add("2000-1-1", INTERVAL "1:1:1" HOUR_SECOND), "00:20:00");
DROP TABLE t1;

SELECT WEEK(STR_TO_DATE(NULL,0));
SELECT SUBDATE(STR_TO_DATE(NULL,0), INTERVAL 1 HOUR);
SELECT MONTHNAME(0), MONTHNAME(0) IS NULL, MONTHNAME(0) + 1;
SET default_storage_engine=NULL;
SET time_zone='+03:00';
CREATE TABLE t1 (a DATETIME NOT NULL);
INSERT INTO t1 VALUES ('2009-09-20 07:32:39.06');
INSERT IGNORE INTO t1 VALUES ('0000-00-00 00:00:00.00');
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT CAST(UNIX_TIMESTAMP(a) AS DECIMAL(25,3)) AS c1 FROM v1 ORDER BY 1;
DROP VIEW v1;
DROP TABLE t1;
SET time_zone=DEFAULT;

SELECT min(timestampadd(month, 1>'', from_days('%Z')));

create table t1(a time);
insert into t1 values ('00:00:00'),('00:01:00');
select 1 from t1 where 1 < some (select cast(a as datetime) from t1);
drop table t1;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
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
SELECT * FROM t1 WHERE TIMESTAMPDIFF(MONTH, a, TIMESTAMP'0000-00-01 00:00:00') IS NULL;
SELECT * FROM t1 WHERE TIMESTAMPDIFF(MONTH, a, DATE('0000-00-01')) IS NULL;
SELECT * FROM t1 WHERE TIMESTAMPDIFF(MONTH, a, DATE'0000-00-01') IS NULL;
DROP TABLE t1;
SET sql_mode = default;
CREATE TABLE t1 (a VARCHAR(32) NOT NULL);
INSERT INTO t1 VALUES ('a');
SELECT 1 FROM t1 GROUP BY @a:=UNIX_TIMESTAMP(a);
SELECT a, UNIX_TIMESTAMP(a), UNIX_TIMESTAMP('a') FROM t1;
DELETE FROM t1;
INSERT INTO t1 VALUES ('5000-01-01 00:00:00');
SELECT a, UNIX_TIMESTAMP(a), UNIX_TIMESTAMP('5000-01-01 00:00:00') FROM t1;
DROP TABLE t1;
SET @savmode=@@SESSION.SQL_MODE;
SET SESSION SQL_MODE='';
SELECT UNIX_TIMESTAMP(COUNT(1));
SELECT CONCAT(UNIX_TIMESTAMP(COUNT(1)), '|');
SET SESSION SQL_MODE=@savmode;

CREATE TABLE t1 AS SELECT IF(0, coalesce(NULL), now(0)) + 0;

DROP TABLE t1;

DO maketime(~0, 49, 0.123456789);

DO is_used_lock(ifnull(now(), CASE 1 WHEN 1 THEN NULL END));

SET @@TIMESTAMP= UNIX_TIMESTAMP('2014-05-27 10:20:30.123456');

CREATE VIEW v1 AS SELECT NOW(6), CURTIME(4), LOCALTIME(3), CURRENT_TIME(2),
CURRENT_TIMESTAMP(0), LOCALTIMESTAMP(1), UTC_TIME(4), UTC_TIMESTAMP(4);
SELECT * FROM v1;
CREATE VIEW v2 AS SELECT LOCATE(".", SYSDATE(6)) != 0;
SELECT * FROM v2;
DROP VIEW v1, v2;
SET @@TIMESTAMP= DEFAULT;
                      EXP(39988664861.65638662152600787509),
                      ((STD(@f))LIKE(1))));
                      COERCIBILITY(BIT_COUNT(RTRIM((~(
                      INET6_NTOA(0xa04810f0839d318fa075bd)))))),
                      ((ST_ASWKT(1))OR(1))));
SELECT PERIOD_ADD(-11924, 2892462180);
SELECT PERIOD_DIFF(200024, 200012);
SELECT PERIOD_DIFF(200012, 200024);
select period_add(-9223372036854775808,29880);
select period_diff(-9223372036854775808,201902);
SELECT MAKEDATE(1, 8.381922e+307);

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
                    convert((1) using utf8mb3),
                    (!(cast((555) AS char(20)))))) AS a1 FROM t0022)
SELECT cte1.a1
FROM cte1 WHERE cte1.a1 = from_unixtime(1537000917);

DROP TABLE t0022;

-- Used to fail with "out of range value". The values were one digit
-- too wide for column x, and two digits too wide for column y.
CREATE TABLE t AS
  SELECT CAST(TO_DAYS('9999-12-31') AS CHAR) AS x,
         TO_DAYS('9999-12-31') * -4.0 AS y;
SELECT * FROM t;
DROP TABLE t;

CREATE TABLE t1 (
  i1 INT,
  d1 DATETIME
);

let $query = INSERT INTO t1 SELECT MAX(1), NOW() FROM t1;

SELECT i1, EXTRACT(HOUR FROM TIMEDIFF(NOW(), d1)) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (f1 INTEGER);
CREATE VIEW v1 AS SELECT (SELECT 'v' FROM DUAL) AS field1 FROM t1 GROUP BY field1
HAVING TIME(field1) != 0 AND  TIMESTAMP(field1) != 0;
DROP VIEW v1;
DROP TABLE t1;

SELECT CAST(1 AS YEAR) UNION SELECT CAST(1 AS YEAR);
SELECT YEAR('1999-09-11') UNION SELECT YEAR('1999-09-11');
