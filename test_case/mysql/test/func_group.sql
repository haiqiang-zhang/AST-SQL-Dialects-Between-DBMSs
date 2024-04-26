--

--disable_warnings
drop table if exists t1,t2;

set @sav_dpi= @@div_precision_increment;
set div_precision_increment= 5;
create table t1 (grp int, a bigint unsigned, c char(10) not null);
insert into t1 values (1,1,"a");
insert into t1 values (2,2,"b");
insert into t1 values (2,3,"c");
insert into t1 values (3,4,"E");
insert into t1 values (3,5,"C");
insert into t1 values (3,6,"D");

-- Test of MySQL field extension with and without matching records.
--### Note: The two following statements may fail if the execution plan
--### or optimizer is changed. The result for column c is undefined.

--source include/turn_off_only_full_group_by.inc
select a,c,sum(a) from t1 group by a;
select a,c,sum(a) from t1 where a > 10 group by a;

select sum(a) from t1 where a > 10;
select a from t1 order by rand(10);
select distinct a from t1 order by rand(10);
select count(distinct a),count(distinct grp) from t1;
insert into t1 values (null,null,'');
select count(distinct a),count(distinct grp) from t1;

select sum(all a),count(all a),avg(all a),std(all a),variance(all a),bit_or(all a),bit_and(all a),min(all a),max(all a),min(all c),max(all c) from t1;
select grp, sum(a),count(a),avg(a),std(a),variance(a),bit_or(a),bit_and(a),min(a),max(a),min(c),max(c) from t1 group by grp;
select grp, sum(a)+count(a)+avg(a)+std(a)+variance(a)+bit_or(a)+bit_and(a)+min(a)+max(a)+min(c)+max(c) as sum from t1 group by grp;

create table t2 (grp int, a bigint unsigned, c char(10));
insert into t2 select grp,max(a)+max(grp),max(c) from t1 group by grp;

-- REPLACE ... SELECT does not yet work with PS
replace into t2 select grp, a, c from t1 limit 2,1;
select * from t2;

drop table t1,t2;

--
-- Problem with std()
--

CREATE TABLE t1 (id int(11),value1 float(10,2));
INSERT INTO t1 VALUES (1,0.00),(1,1.00), (1,2.00), (2,10.00), (2,11.00), (2,12.00);
CREATE TABLE t2 (id int(11),name char(20));
INSERT INTO t2 VALUES (1,'Set One'),(2,'Set Two');
select id, avg(value1), std(value1), variance(value1) from t1 group by id;
select name, avg(value1), std(value1), variance(value1) from t1, t2 where t1.id = t2.id group by t1.id;
drop table t1,t2;

--
-- Test of bug in left join & avg
--

create table t1 (id int not null);
create table t2 (id int not null,rating int null);
insert into t1 values(1),(2),(3);
insert into t2 values(1, 3),(2, NULL),(2, NULL),(3, 2),(3, NULL);
select t1.id, avg(rating) from t1 left join t2 on ( t1.id = t2.id ) group by t1.id;
select sql_small_result t2.id, avg(rating) from t2 group by t2.id;
select sql_big_result t2.id, avg(rating) from t2 group by t2.id;
select sql_small_result t2.id, avg(rating+0.0e0) from t2 group by t2.id;
select sql_big_result t2.id, avg(rating+0.0e0) from t2 group by t2.id;
drop table t1,t2;

--
-- test of count
--
create table t1 (a smallint(6) primary key, c char(10), b text);
INSERT INTO t1 VALUES (1,'1','1');
INSERT INTO t1 VALUES (2,'2','2');
INSERT INTO t1 VALUES (4,'4','4');

select count(*) from t1;
select count(*) from t1 where a = 1;
select count(*) from t1 where a = 100;
select count(*) from t1 where a >= 10;
select count(a) from t1 where a = 1;
select count(a) from t1 where a = 100;
select count(a) from t1 where a >= 10;
select count(b) from t1 where b >= 2;
select count(b) from t1 where b >= 10;
select count(c) from t1 where c = 10;
drop table t1;

--
-- Test of bug in COUNT(i)*(i+0)
--

CREATE TABLE t1 (d DATETIME, i INT);
INSERT INTO t1 VALUES (NOW(), 1);
SELECT COUNT(i), i, COUNT(i)*i FROM t1 GROUP BY i;
SELECT COUNT(i), (i+0), COUNT(i)*(i+0) FROM t1 GROUP BY i;
DROP TABLE t1;

--
-- Another SUM() problem with 3.23.2
--

create table t1 (
        num float(5,2),
        user char(20)
);
insert into t1 values (10.3,'nem'),(20.53,'monty'),(30.23,'sinisa');
insert into t1 values (30.13,'nem'),(20.98,'monty'),(10.45,'sinisa');
insert into t1 values (5.2,'nem'),(8.64,'monty'),(11.12,'sinisa');
select sum(num) from t1;
select sum(num) from t1 group by user;
drop table t1;

--
-- Test problem with MIN() optimization in case of null values
--

create table t1 (a1 int, a2 char(3), key k1(a1), key k2(a2));
insert into t1 values(10,'aaa'), (10,null), (10,'bbb'), (20,'zzz');
create table t2(a1 char(3), a2 int, a3 real, key k1(a1), key k2(a2, a1));
select * from t1;
select min(a2) from t1;
select max(t1.a1), max(t2.a2) from t1, t2;
select max(t1.a1) from t1, t2;
select max(t2.a2), max(t1.a1) from t1, t2;

insert into t2 values('AAA', 10, 0.5);
insert into t2 values('BBB', 20, 1.0);
select t1.a1, t1.a2, t2.a1, t2.a2 from t1,t2;

select max(t1.a1), max(t2.a1) from t1, t2 where t2.a2=9;
select max(t2.a1), max(t1.a1) from t1, t2 where t2.a2=9;
select t1.a1, t1.a2, t2.a1, t2.a2 from t1 left outer join t2 on t1.a1=10;
select max(t1.a2) from t1 left outer join t2 on t1.a1=10;
select max(t2.a1) from t2 left outer join t1 on t2.a2=10 where t2.a2=20;
select max(t2.a1) from t2 left outer join t1 on t2.a2=10 where t2.a2=10;
select max(t2.a1) from t1 left outer join t2 on t1.a2=t2.a1 and 1=0 where t2.a1='AAA';
select max(t1.a2),max(t2.a1) from t1 left outer join t2 on t1.a1=10;
drop table t1,t2;

--
-- Test of group function and NULL values
--

CREATE TABLE t1 (a int, b int);
select count(b), sum(b), avg(b), std(b), min(b), max(b), bit_and(b), bit_or(b) from t1;
select a,count(b), sum(b), avg(b), std(b), min(b), max(b), bit_and(b), bit_or(b) from t1 group by a;
insert into t1 values (1,null);
select a,count(b), sum(b), avg(b), std(b), min(b), max(b), bit_and(b), bit_or(b) from t1 group by a;
insert into t1 values (1,null);
insert into t1 values (2,null);
select a,count(b), sum(b), avg(b), std(b), min(b), max(b), bit_and(b), bit_or(b) from t1 group by a;
select SQL_BIG_RESULT a,count(b), sum(b), avg(b), std(b), min(b), max(b), bit_and(b), bit_or(b) from t1 group by a;
insert into t1 values (2,1);
select a,count(b), sum(b), avg(b), std(b), min(b), max(b), bit_and(b), bit_or(b) from t1 group by a;
select SQL_BIG_RESULT a,count(b), sum(b), avg(b), std(b), min(b), max(b), bit_and(b), bit_or(b) from t1 group by a;
insert into t1 values (3,1);
select a,count(b), sum(b), avg(b), std(b), min(b), max(b), bit_and(b), bit_or(b) from t1 group by a;
select SQL_BIG_RESULT a,count(b), sum(b), avg(b), std(b), min(b), max(b), bit_and(b), bit_or(b), bit_xor(b) from t1 group by a;
drop table t1;

--
-- Bug #1972: test for bit_and(), bit_or() and negative values
-- 
create table t1 (col int);
insert into t1 values (-1), (-2), (-3);
select bit_and(col), bit_or(col) from t1;
select SQL_BIG_RESULT bit_and(col), bit_or(col) from t1 group by col;
drop table t1;

--
-- Bug #3376: avg() and an empty table
--

create table t1 (a int);
select avg(2) from t1;
drop table t1;

--
-- Tests to check MIN/MAX query optimization
--

-- Create database schema
create table t1(
  a1 char(3) primary key,
  a2 smallint,
  a3 char(3),
  a4 real,
  a5 date,
  key k1(a2,a3),
  key k2(a4,a1),
  key k3(a5,a1)
);
create table t2(
  a1 char(3) primary key,
  a2 char(17),
  a3 char(2),
  a4 char(3),
  key k1(a3, a2),
  key k2(a4)
);

-- Populate table t1
insert into t1 values('AME',0,'SEA',0.100,date'1942-02-19');
insert into t1 values('HBR',1,'SEA',0.085,date'1948-03-05');
insert into t1 values('BOT',2,'SEA',0.085,date'1951-11-29');
insert into t1 values('BMC',3,'SEA',0.085,date'1958-09-08');
insert into t1 values('TWU',0,'LAX',0.080,date'1969-10-05');
insert into t1 values('BDL',0,'DEN',0.080,date'1960-11-27');
insert into t1 values('DTX',1,'NYC',0.080,date'1961-05-04');
insert into t1 values('PLS',1,'WDC',0.075,date'1949-01-02');
insert into t1 values('ZAJ',2,'CHI',0.075,date'1960-06-15');
insert into t1 values('VVV',2,'MIN',0.075,date'1959-06-28');
insert into t1 values('GTM',3,'DAL',0.070,date'1977-09-23');
insert into t1 values('SSJ',null,'CHI',null,date'1974-03-19');
insert into t1 values('KKK',3,'ATL',null,null);
insert into t1 values('XXX',null,'MIN',null,null);
insert into t1 values('WWW',1,'LED',null,null);

-- Populate table t2
insert into t2 values('TKF','Seattle','WA','AME');
insert into t2 values('LCC','Los Angeles','CA','TWU');
insert into t2 values('DEN','Denver','CO','BDL');
insert into t2 values('SDC','San Diego','CA','TWU');
insert into t2 values('NOL','New Orleans','LA','GTM');
insert into t2 values('LAK','Los Angeles','CA','TWU');
insert into t2 values('AAA','AAA','AA','AME');

-- Show the table contents
--sorted_result
select * from t1;
select * from t2;

-- Queries with min/max functions 
-- which regular min/max optimization are applied to

explain 
select min(a1) from t1;
select min(a1) from t1;
select max(a4) from t1;
select max(a4) from t1;
select min(a5), max(a5) from t1;
select min(a5), max(a5) from t1;
select min(a3) from t1 where a2 = 2;
select min(a3) from t1 where a2 = 2;
select min(a1), max(a1) from t1 where a4 = 0.080;
select min(a1), max(a1) from t1 where a4 = 0.080;
select min(t1.a5), max(t2.a3) from t1, t2;
select min(t1.a5), max(t2.a3) from t1, t2;
select min(t1.a3), max(t2.a2) from t1, t2 where t1.a2 = 0 and t2.a3 = 'CA';
select min(t1.a3), max(t2.a2) from t1, t2 where t1.a2 = 0 and t2.a3 = 'CA';

-- Queries with min/max functions 
-- which extended min/max optimization are applied to

explain 
select min(a1) from t1 where a1 > 'KKK';
select min(a1) from t1 where a1 > 'KKK';
select min(a1) from t1 where a1 >= 'KKK';
select min(a1) from t1 where a1 >= 'KKK';
select max(a3) from t1 where a2 = 2 and a3 < 'SEA';
select max(a3) from t1 where a2 = 2 and a3 < 'SEA';
select max(a5) from t1 where a5 < date'1970-01-01';
select max(a5) from t1 where a5 < date'1970-01-01';
select max(a3) from t1 where a2 is null;
select max(a3) from t1 where a2 is null;
select max(a3) from t1 where a2 = 0 and a3 between 'K' and 'Q';
select max(a3) from t1 where a2 = 0 and a3 between 'K' and 'Q';
select min(a1), max(a1) from t1 where a1 between 'A' and 'P';
select min(a1), max(a1) from t1 where a1 between 'A' and 'P';
select max(a3) from t1 where a3 < 'SEA' and a2 = 2 and a3 <= 'MIN';
select max(a3) from t1 where a3 < 'SEA' and a2 = 2 and a3 <= 'MIN';
select max(a3) from t1 where a3 = 'MIN' and a2 = 2;
select max(a3) from t1 where a3 = 'MIN' and a2 = 2;
select max(a3) from t1 where a3 = 'DEN' and a2 = 2;
select max(a3) from t1 where a3 = 'DEN' and a2 = 2;
select max(t1.a3), min(t2.a2) from t1, t2 where t1.a2 = 2 and t1.a3 < 'MIN' and t2.a3 = 'CA';
select max(t1.a3), min(t2.a2) from t1, t2 where t1.a2 = 2 and t1.a3 < 'MIN' and t2.a3 = 'CA';
select max(a3) from t1 where a2 is null and a2 = 2;
select max(a3) from t1 where a2 is null and a2 = 2;
select max(a2) from t1 where a2 >= 1;
select max(a2) from t1 where a2 >= 1;
select min(a3) from t1 where a2 = 2 and a3 < 'SEA';
select min(a3) from t1 where a2 = 2 and a3 < 'SEA';
select min(a3) from t1 where a2 = 4;
select min(a3) from t1 where a2 = 4;
select min(a3) from t1 where a2 = 2 and a3 > 'SEA';
select min(a3) from t1 where a2 = 2 and a3 > 'SEA';
select (min(a4)+max(a4))/2 from t1;
select (min(a4)+max(a4))/2 from t1;
select min(a3) from t1 where 2 = a2;
select min(a3) from t1 where 2 = a2;
select max(a3) from t1 where a2 = 2 and 'SEA' > a3;
select max(a3) from t1 where a2 = 2 and 'SEA' > a3;
select max(a3) from t1 where a2 = 2 and 'SEA' < a3;
select max(a3) from t1 where a2 = 2 and 'SEA' < a3;
select min(a3) from t1 where a2 = 2 and a3 >= 'CHI';
select min(a3) from t1 where a2 = 2 and a3 >= 'CHI';
select min(a3) from t1 where a2 = 2 and a3 >= 'CHI' and a3 < 'SEA';
select min(a3) from t1 where a2 = 2 and a3 >= 'CHI' and a3 < 'SEA';
select min(a3) from t1 where a2 = 2 and a3 >= 'CHI' and a3 = 'MIN';
select min(a3) from t1 where a2 = 2 and a3 >= 'CHI' and a3 = 'MIN';
select min(a3) from t1 where a2 = 2 and a3 >= 'SEA' and a3 = 'MIN';
select min(a3) from t1 where a2 = 2 and a3 >= 'SEA' and a3 = 'MIN';
select min(t1.a1), min(t2.a4) from t1,t2 where t1.a1 < 'KKK' and t2.a4 < 'KKK';
select min(t1.a1), min(t2.a4) from t1,t2 where t1.a1 < 'KKK' and t2.a4 < 'KKK';

-- Queries to which max/min optimization is not applied
ANALYZE TABLE t1, t2;
select min(a1) from t1 where a1 > 'KKK' or a1 < 'XXX';
select min(a1) from t1 where a1 != 'KKK';
select max(a3) from t1 where a2 < 2 and a3 < 'SEA';
select max(t1.a3), min(t2.a2) from t1, t2 where t1.a2 = 2 and t1.a3 < 'MIN' and t2.a3 > 'CA';
select min(a4 - 0.01) from t1;
select max(a4 + 0.01) from t1;
select min(a3) from t1 where (a2 +1 ) is null;
select min(a3) from t1 where (a2 + 1) = 2;
select min(a3) from t1 where 2 = (a2 + 1);
select min(a2) from t1 where a2 < 2 * a2 - 8;
select min(a1) from t1  where a1 between a3 and 'KKK';
select min(a4) from t1  where (a4 + 0.01) between 0.07 and 0.08;
select concat(min(t1.a1),min(t2.a4)) from t1, t2 where t2.a4 <> 'AME';
drop table t1, t2;

-- Moved to func_group_innodb
----disable_warnings
--create table t1 (USR_ID integer not null, MAX_REQ integer not null, constraint PK_SEA_USER primary key (USR_ID)) engine=InnoDB;


create table t1 (a char(10));
insert into t1 values ('a'),('b'),('c');
select coercibility(max(a)) from t1;
drop table t1;

--
-- Bug #6658 MAX(column) returns incorrect coercibility
--
create table t1 (a char character set latin2);
insert into t1 values ('a'),('b');
select charset(max(a)), coercibility(max(a)),
       charset(min(a)), coercibility(min(a)) from t1;
create table t2 select max(a),min(a) from t1;
drop table t2;
create table t2 select concat(a) from t1;
drop table t2,t1;

--
-- aggregate functions on static tables
--
create table t1 (a int);
insert into t1 values (1);
select max(a) as b from t1 having b=1;
select a from t1 having a=1;
drop table t1;

--
-- Bug #3435: variance(const), stddev(const) and an empty table
--

create table t1 (a int);
select variance(2) from t1;
select stddev(2) from t1;
drop table t1;


--
-- cleunup() of optimized away count(*) and max/min
--
create table t1 (a int);
insert into t1 values (1),(2);
drop table t1;

create table t1 (a int, primary key(a));
insert into t1 values (1),(2);
drop table t1;

--
-- Bug #5406 min/max optimization for empty set
--

CREATE TABLE t1 (a int primary key);
INSERT INTO t1 VALUES (1),(2),(3),(4);

SELECT MAX(a) FROM t1 WHERE a > 5;
SELECT MIN(a) FROM t1 WHERE a < 0;

DROP TABLE t1;

--
-- Bug #5555 GROUP BY enum_field" returns incorrect results
--
 
CREATE TABLE t1 (
  id int(10) unsigned NOT NULL auto_increment,
  val enum('one','two','three') NOT NULL default 'one',
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
 
INSERT INTO t1 VALUES
(1,'one'),(2,'two'),(3,'three'),(4,'one'),(5,'two');
 
select val, count(*) from t1 group by val;
drop table t1;

CREATE TABLE t1 (
  id int(10) unsigned NOT NULL auto_increment,
  val set('one','two','three') NOT NULL default 'one',
  PRIMARY KEY  (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

INSERT INTO t1 VALUES
(1,'one'),(2,'two'),(3,'three'),(4,'one'),(5,'two');

select val, count(*) from t1 group by val;
drop table t1;

--
-- Bug #5615: type of aggregate function column wrong when using group by
--

create table t1(a int, b datetime);
insert into t1 values (1, NOW()), (2, NOW());
create table t2 select MAX(b) from t1 group by a;
drop table t1, t2;

--
-- Bug 7833:  Wrong datatype of aggregate column is returned
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create table t1(f1 datetime);
insert into t1 values (now());
create table t2 select f2 from (select max(now()) f2 from t1) a;
drop table t2;
create table t2 select f2 from (select now() f2 from t1) a;
drop table t2, t1;
SET sql_mode = default;
--

CREATE TABLE t1(
  id int PRIMARY KEY,
  a  int,
  b  int,
  INDEX i_b_id(a,b,id),
  INDEX i_id(a,id)
);
INSERT INTO t1 VALUES 
  (1,1,4), (2,2,1), (3,1,3), (4,2,1), (5,1,1);
SELECT MAX(id) FROM t1 WHERE id < 3 AND a=2 AND b=6;
DROP TABLE t1;

-- change the order of the last two index definitions

CREATE TABLE t1(
  id int PRIMARY KEY,
  a  int,
  b  int,
  INDEX i_id(a,id),
  INDEX i_b_id(a,b,id)
);
INSERT INTO t1 VALUES 
  (1,1,4), (2,2,1), (3,1,3), (4,2,1), (5,1,1);
SELECT MAX(id) FROM t1 WHERE id < 3 AND a=2 AND b=6;
DROP TABLE t1;


--
-- Bug #12882  	min/max inconsistent on empty table
--
-- Test case moved to func_group_innodb
--
-- Bug #18206: min/max optimization cannot be applied to partial index
--

CREATE TABLE t1 (id int PRIMARY KEY, b char(3), INDEX(b));
INSERT INTO t1 VALUES (1,'xx'), (2,'aa');
SELECT * FROM t1;

SELECT MAX(b) FROM t1 WHERE b < 'ppppp';
SELECT MAX(b) FROM t1 WHERE b < 'pp';
DROP TABLE t1;

CREATE TABLE t1 (id int PRIMARY KEY, b char(16), INDEX(b(4)));
INSERT INTO t1 VALUES (1, 'xxxxbbbb'), (2, 'xxxxaaaa');
SELECT MAX(b) FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (id int , b varchar(512), INDEX(b(250))) COLLATE latin1_bin;
INSERT INTO t1 VALUES
  (1,CONCAT(REPEAT('_', 250), "qq")), (1,CONCAT(REPEAT('_', 250), "zz")),
  (1,CONCAT(REPEAT('_', 250), "aa")), (1,CONCAT(REPEAT('_', 250), "ff"));

SELECT MAX(b) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1),(1,2),(2,3);

SELECT (SELECT COUNT(DISTINCT t1.b)) FROM t1 GROUP BY t1.a;
SELECT (SELECT COUNT(DISTINCT 12)) FROM t1 GROUP BY t1.a;
SELECT AVG(2), BIT_AND(2), BIT_OR(2), BIT_XOR(2), COUNT(*), COUNT(12),
       COUNT(DISTINCT 12), MIN(2),MAX(2),STD(2), VARIANCE(2),SUM(2),
       GROUP_CONCAT(2),GROUP_CONCAT(DISTINCT 2);
DROP TABLE t1;

-- End of 4.1 tests

--
-- decimal-related tests
--
create table t2 (ff double);
insert into t2 values (2.2);
select cast(sum(distinct ff) as decimal(5,2)) from t2;
select cast(sum(distinct ff) as signed) from t2;
select cast(variance(ff) as decimal(10,3)) from t2;
select cast(min(ff) as decimal(5,2)) from t2;

create table t1 (df decimal(5,1));
insert into t1 values(1.1);
insert into t1 values(2.2);
select cast(sum(distinct df) as signed) from t1;
select cast(min(df) as signed) from t1;
select 1e8 * sum(distinct df) from t1;
select 1e8 * min(df) from t1;

create table t3 (ifl int);
insert into t3 values(1), (2);
select cast(min(ifl) as decimal(5,2)) from t3;

drop table t1, t2, t3;


--
-- BUG#3190, WL#1639: Standard Deviation STDDEV - 2 different calculations
--

CREATE TABLE t1 (id int(11),value1 float(10,2));
INSERT INTO t1 VALUES (1,0.00),(1,1.00), (1,2.00), (2,10.00), (2,11.00), (2,12.00), (2,13.00);
select id, stddev_pop(value1), var_pop(value1), stddev_samp(value1), var_samp(value1) from t1 group by id;
DROP TABLE t1;

--
-- BUG#8464 decimal AVG returns incorrect result
--

CREATE TABLE t1 (col1 decimal(16,12));
INSERT INTO t1 VALUES (-5.00000000001),(-5.00000000002),(-5.00000000003),(-5.00000000000),(-5.00000000001),(-5.00000000002);
insert into t1 select * from t1;
select col1,count(col1),sum(col1),avg(col1) from t1 group by col1;
DROP TABLE t1;

--
-- BUG#8465 decimal MIN and MAX return incorrect result
--

create table t1 (col1 decimal(16,12));
insert into t1 values (-5.00000000001);
insert into t1 values (-5.00000000001);
select col1,sum(col1),max(col1),min(col1) from t1 group by col1;
delete from t1;
insert into t1 values (5.00000000001);
insert into t1 values (5.00000000001);
select col1,sum(col1),max(col1),min(col1) from t1 group by col1;
DROP TABLE t1;

--
-- Test that new VARCHAR correctly works with COUNT(DISTINCT)
--

CREATE TABLE t1 (a VARCHAR(400)) charset latin1;
INSERT INTO t1 (a) VALUES ("A"), ("a"), ("a "), ("a   "),
                          ("B"), ("b"), ("b "), ("b   ");
SELECT COUNT(DISTINCT a) FROM t1;
DROP TABLE t1;

--
-- Test for buf #9210: GROUP BY with expression if a decimal type
--

CREATE TABLE t1 (a int, b int, c int);
INSERT INTO t1 (a, b, c) VALUES
  (1,1,1), (1,1,2), (1,1,3),
  (1,2,1), (1,2,2), (1,2,3),
  (1,3,1), (1,3,2), (1,3,3),
  (2,1,1), (2,1,2), (2,1,3),
  (2,2,1), (2,2,2), (2,2,3),
  (2,3,1), (2,3,2), (2,3,3),
  (3,1,1), (3,1,2), (3,1,3),
  (3,2,1), (3,2,2), (3,2,3),
  (3,3,1), (3,3,2), (3,3,3);

SELECT b/c as v, a FROM t1 ORDER BY v, a;
SELECT b/c as v, SUM(a) FROM t1 GROUP BY v;
SELECT SUM(a) FROM t1 GROUP BY b/c;

DROP TABLE t1;
set div_precision_increment= @sav_dpi;

--
-- Bug #20868: Client connection is broken on SQL query error
--
CREATE TABLE t1 (a INT PRIMARY KEY, b INT);
INSERT INTO t1 VALUES (1,1), (2,2);

CREATE TABLE t2 (a INT PRIMARY KEY, b INT);
INSERT INTO t2 VALUES (1,1), (3,3);

-- SUM(c.a)'s aggregation query is outer query, whose SELECT list thus
-- contains aggregate (SUM) and column (t.a).
--source include/turn_off_only_full_group_by.inc

SELECT
  (SELECT SUM(c.a) FROM t1 ttt, t2 ccc 
   WHERE ttt.a = ccc.b AND ttt.a = t.a GROUP BY ttt.a) AS minid   
FROM t1 t, t2 c WHERE t.a = c.b;
DROP TABLE t1,t2;

--
-- Bug #10966: Variance functions return wrong data type
--

create table t1 select variance(0);
drop table t1;
create table t1 select stddev(0);
drop table t1;
 

--
-- Bug#22555: STDDEV yields positive result for groups with only one row
--

create table bug22555 (i smallint primary key auto_increment, s1 smallint, s2 smallint, e decimal(30,10), o double);
insert into bug22555 (s1, s2, e, o) values (53, 78, 11.4276528, 6.828112), (17, 78, 5.916793, 1.8502951), (18, 76, 2.679231, 9.17975591), (31, 62, 6.07831, 0.1), (19, 41, 5.37463, 15.1), (83, 73, 14.567426, 7.959222), (92, 53, 6.10151, 13.1856852), (7, 12, 13.92272, 3.442007), (92, 35, 11.95358909, 6.01376678), (38, 84, 2.572, 7.904571);
select std(s1/s2) from bug22555 group by i;
select std(e) from bug22555 group by i;
select std(o) from bug22555 group by i;
drop table bug22555;

create table bug22555 (i smallint, s1 smallint, s2 smallint, o1 double, o2 double, e1 decimal, e2 decimal);
insert into bug22555 values (1,53,78,53,78,53,78),(2,17,78,17,78,17,78),(3,18,76,18,76,18,76);
select i, count(*) from bug22555 group by i;
select std(s1/s2) from bug22555 where i=1;
select std(s1/s2) from bug22555 where i=2;
select std(s1/s2) from bug22555 where i=3;
select std(s1/s2) from bug22555 where i=1 group by i;
select std(s1/s2) from bug22555 where i=2 group by i;
select std(s1/s2) from bug22555 where i=3 group by i;
select std(s1/s2) from bug22555 group by i order by i;
select i, count(*), std(o1/o2) from bug22555 group by i order by i;
select i, count(*), std(e1/e2) from bug22555 group by i order by i;
set @saved_div_precision_increment=@@div_precision_increment;
set div_precision_increment=19;
select i, count(*), variance(s1/s2) from bug22555 group by i order by i;
select i, count(*), variance(o1/o2) from bug22555 group by i order by i;
select i, count(*), variance(e1/e2) from bug22555 group by i order by i;
select i, count(*), std(s1/s2) from bug22555 group by i order by i;
select i, count(*), std(o1/o2) from bug22555 group by i order by i;
select i, count(*), std(e1/e2) from bug22555 group by i order by i;
set div_precision_increment=20;
select i, count(*), variance(s1/s2) from bug22555 group by i order by i;
select i, count(*), variance(o1/o2) from bug22555 group by i order by i;
select i, count(*), variance(e1/e2) from bug22555 group by i order by i;
select i, count(*), std(s1/s2) from bug22555 group by i order by i;
select i, count(*), std(o1/o2) from bug22555 group by i order by i;
select i, count(*), std(e1/e2) from bug22555 group by i order by i;
set @@div_precision_increment=@saved_div_precision_increment;
insert into bug22555 values (1,53,78,53,78,53,78),(2,17,78,17,78,17,78),(3,18,76,18,76,18,76);
insert into bug22555 values (1,53,78,53,78,53,78),(2,17,78,17,78,17,78),(3,18,76,18,76,18,76);
insert into bug22555 values (1,53,78,53,78,53,78),(2,17,78,17,78,17,78),(3,18,76,18,76,18,76);

select i, count(*), std(s1/s2) from bug22555 group by i order by i;
select i, count(*), round(std(o1/o2), 16) from bug22555 group by i order by i;
select i, count(*), std(e1/e2) from bug22555 group by i order by i;
select std(s1/s2) from bug22555;
select std(o1/o2) from bug22555;
select std(e1/e2) from bug22555;
set @saved_div_precision_increment=@@div_precision_increment;
set div_precision_increment=19;
select i, count(*), std(s1/s2) from bug22555 group by i order by i;
select i, count(*), round(std(o1/o2), 16) from bug22555 group by i order by i;
select i, count(*), std(e1/e2) from bug22555 group by i order by i;
select round(std(s1/s2), 17) from bug22555;
select std(o1/o2) from bug22555;
select round(std(e1/e2), 17) from bug22555;
set div_precision_increment=20;
select i, count(*), std(s1/s2) from bug22555 group by i order by i;
select i, count(*), round(std(o1/o2), 16) from bug22555 group by i order by i;
select i, count(*), std(e1/e2) from bug22555 group by i order by i;
select round(std(s1/s2), 17) from bug22555;
select std(o1/o2) from bug22555;
select round(std(e1/e2), 17) from bug22555;
set @@div_precision_increment=@saved_div_precision_increment;
drop table bug22555;

create table bug22555 (s smallint, o double, e decimal);
insert into bug22555 values (1,1,1),(2,2,2),(3,3,3),(6,6,6),(7,7,7);
select var_samp(s), var_pop(s) from bug22555;
select var_samp(o), var_pop(o) from bug22555;
select var_samp(e), var_pop(e) from bug22555;
drop table bug22555;

create table bug22555 (s smallint, o double, e decimal);
insert into bug22555 values (null,null,null),(null,null,null);
select var_samp(s) as 'null', var_pop(s) as 'null' from bug22555;
select var_samp(o) as 'null', var_pop(o) as 'null' from bug22555;
select var_samp(e) as 'null', var_pop(e) as 'null' from bug22555;
insert into bug22555 values (1,1,1);
select var_samp(s) as 'null', var_pop(s) as '0' from bug22555;
select var_samp(o) as 'null', var_pop(o) as '0' from bug22555;
select var_samp(e) as 'null', var_pop(e) as '0' from bug22555;
insert into bug22555 values (2,2,2);
select var_samp(s) as '0.5', var_pop(s) as '0.25' from bug22555;
select var_samp(o) as '0.5', var_pop(o) as '0.25' from bug22555;
select var_samp(e) as '0.5', var_pop(e) as '0.25' from bug22555;
drop table bug22555;


--
-- Bug #21976: Unnecessary warning with count(decimal)
--

create table t1 (a decimal(20));
insert into t1 values (12345678901234567890);
select count(a) from t1;
select count(distinct a) from t1;
drop table t1;

--
-- Bug #23184: SELECT causes server crash
-- 
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8);
INSERT INTO t1 SELECT a, b+8       FROM t1;
INSERT INTO t1 SELECT a, b+16      FROM t1;
INSERT INTO t1 SELECT a, b+32      FROM t1;
INSERT INTO t1 SELECT a, b+64      FROM t1;
INSERT INTO t1 SELECT a, b+128     FROM t1;
INSERT INTO t1 SELECT a, b+256     FROM t1;
INSERT INTO t1 SELECT a, b+512     FROM t1;
INSERT INTO t1 SELECT a, b+1024    FROM t1;
INSERT INTO t1 SELECT a, b+2048    FROM t1;
INSERT INTO t1 SELECT a, b+4096    FROM t1;
INSERT INTO t1 SELECT a, b+8192    FROM t1;
INSERT INTO t1 SELECT a, b+16384   FROM t1;
INSERT INTO t1 SELECT a, b+32768   FROM t1;
SELECT a,COUNT(DISTINCT b) AS cnt FROM t1 GROUP BY a HAVING cnt > 50;
SELECT a,SUM(DISTINCT b) AS sumation FROM t1 GROUP BY a HAVING sumation > 50;
SELECT a,AVG(DISTINCT b) AS average FROM t1 GROUP BY a HAVING average > 50;

DROP TABLE t1;

--
-- Bug #27573: MIN() on an indexed column which is always NULL sets _other_ 
-- results to NULL
--
CREATE TABLE t1 ( a INT, b INT, KEY(a) );
INSERT INTO t1 VALUES (NULL, 1), (NULL, 2);
SELECT MIN(a), MIN(b) FROM t1;

CREATE TABLE t2( a INT, b INT, c INT, KEY(a, b) );
INSERT INTO t2 ( a, b, c ) VALUES ( 1, NULL, 2 ), ( 1, 3, 4 ), ( 1, 4, 4 );
SELECT MIN(b), MIN(c) FROM t2 WHERE a = 1;

CREATE TABLE t3 (a INT, b INT, c int, KEY(a, b));
INSERT INTO t3 VALUES (1, NULL, 1), (2, NULL, 2),  (2, NULL, 2),  (3, NULL, 3);
SELECT MIN(a), MIN(b) FROM t3 where a = 2;

CREATE TABLE t4 (a INT, b INT, c int, KEY(a, b));
INSERT INTO t4 VALUES (1, 1, 1), (2, NULL, 2),  (2, NULL, 2),  (3, 1, 3);
SELECT MIN(a), MIN(b) FROM t4 where a = 2;
SELECT MIN(b), min(c) FROM t4 where a = 2;

CREATE TABLE t5( a INT, b INT, KEY( a, b) );
INSERT INTO t5 VALUES( 1, 1 ), ( 1, 2 );
SELECT MIN(a), MIN(b) FROM t5 WHERE a = 1;
SELECT MIN(a), MIN(b) FROM t5 WHERE a = 1 and b > 1;

DROP TABLE t1, t2, t3, t4, t5;

--
-- Bug #31156: mysqld: item_sum.cc:918: 
--  virtual bool Item_sum_distinct::setup(THD*): Assertion
--

CREATE TABLE t1 (a INT);
INSERT INTO t1 values (),(),();
SELECT (SELECT SLEEP(0) FROM t1 ORDER BY AVG(DISTINCT a) ) as x FROM t1 
  GROUP BY x;
SELECT 1 FROM t1 GROUP BY (SELECT SLEEP(0) FROM t1 ORDER BY AVG(DISTINCT a) );

DROP TABLE t1;

--
-- Bug #30715: Assertion failed: item_field->field->real_maybe_null(), file
-- .\opt_sum.cc, line
--

CREATE TABLE t1 (a int, b date NOT NULL, KEY k1 (a,b));
SELECT MIN(b) FROM t1 WHERE a=1 AND b>'2007-08-01';
DROP TABLE t1;

--
-- Bug #31794: no syntax error on SELECT id FROM t HAVING count(*)>2;
--

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4);
SELECT a FROM t1 HAVING COUNT(*)>2;
SELECT COUNT(*), a FROM t1;

SELECT a FROM t1 HAVING COUNT(*)>2;
SELECT COUNT(*), a FROM t1;

DROP TABLE t1;

--
-- Bug #33133: Views are not transparent
--

set SQL_MODE=ONLY_FULL_GROUP_BY;

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4);
CREATE VIEW v1 AS SELECT a,(a + 1) AS y FROM t1;

DROP VIEW v1;
DROP TABLE t1;
SET SQL_MODE=DEFAULT;

--
-- Bug #34512: CAST( AVG( double ) AS DECIMAL ) returns wrong results
--

CREATE TABLE t1(a DOUBLE);
INSERT INTO t1 VALUES (10), (20);
SELECT AVG(a), CAST(AVG(a) AS DECIMAL) FROM t1;

DROP TABLE t1;

--
-- Bug #37348: Crash in or immediately after JOIN::make_sum_func_list
--

CREATE TABLE derived1 (a bigint(21));
INSERT INTO derived1 VALUES (2);


CREATE TABLE D (
  pk int(11) NOT NULL AUTO_INCREMENT,
  int_nokey int(11) DEFAULT NULL,
  int_key int(11) DEFAULT NULL,
  filler blob,
  PRIMARY KEY (pk),
  KEY int_key (int_key)
);

INSERT INTO D VALUES 
  (39,40,4,repeat('  X', 42)),
  (43,56,4,repeat('  X', 42)),
  (47,12,4,repeat('  X', 42)),
  (71,28,4,repeat('  X', 42)),
  (76,54,4,repeat('  X', 42)),
  (83,45,4,repeat('  X', 42)),
  (105,53,12,NULL);

-- D.pk is used in SELECT list of top query (inside subquery), is
-- not a column of "GROUP BY int_nokey".
--error ER_WRONG_FIELD_WITH_GROUP
SELECT 
  (SELECT COUNT( int_nokey ) 
   FROM derived1 AS X 
   WHERE 
     X.int_nokey < 61 
   GROUP BY pk 
   LIMIT 1) 
FROM D AS X 
WHERE X.int_key < 13  
GROUP BY int_nokey LIMIT 1;

DROP TABLE derived1;
DROP TABLE D;

--
-- Bug #39656: Behaviour different for agg functions with & without where -
-- ONLY_FULL_GROUP_BY
--

CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1), (1,2), (1,3);

SET SQL_MODE='ONLY_FULL_GROUP_BY';

SELECT COUNT(*) FROM t1;
SELECT COUNT(*) FROM t1 where a=1;
SELECT COUNT(*),a FROM t1;

SELECT COUNT(*) FROM t1 a JOIN t1 b ON a.a= b.a;
SELECT COUNT(*), (SELECT count(*) FROM t1 inr WHERE inr.a = outr.a) 
  FROM t1 outr;

SELECT COUNT(*) FROM t1 a JOIN t1 outr 
  ON a.a= (SELECT count(*) FROM t1 inr WHERE inr.a = outr.a);

SET SQL_MODE=default;
DROP TABLE t1;

CREATE TABLE t1 (
  pk INT NOT NULL,
  i INT,
  PRIMARY KEY (pk)
);
INSERT INTO t1 VALUES (1,11),(2,12),(3,13);
SELECT MAX(pk) as max, i
FROM t1
ORDER BY max;
SELECT MAX(pk) as max, i
FROM t1
ORDER BY max;
SELECT MAX(pk) as max, i
FROM t1
WHERE pk<2
ORDER BY max;
DROP TABLE t1;
create table t1 (f1 year, f2 year, f3 date, f4 datetime);
insert into t1 values
  (98,1998,19980101,"1998-01-01 00:00:00"),
  ('00',2000,20000101,"2000-01-01 00:00:01"),
  (02,2002,20020101,"2002-01-01 23:59:59"),
  (60,2060,20600101,"2060-01-01 11:11:11"),
  (70,1970,19700101,"1970-11-11 22:22:22"),
  (NULL,NULL,NULL,NULL);
select min(f1),max(f1) from t1;
select min(f2),max(f2) from t1;
select min(f3),max(f3) from t1;
select min(f4),max(f4) from t1;
select a.f1 as a, b.f1 as b, a.f1 > b.f1 as gt,
       a.f1 < b.f1 as lt, a.f1<=>b.f1 as eq
from t1 a, t1 b;
select a.f1 as a, b.f2 as b, a.f1 > b.f2 as gt,
       a.f1 < b.f2 as lt, a.f1<=>b.f2 as eq
from t1 a, t1 b;
select a.f1 as a, b.f3 as b, a.f1 > b.f3 as gt,
       a.f1 < b.f3 as lt, a.f1<=>b.f3 as eq
from t1 a, t1 b;
select a.f1 as a, b.f4 as b, a.f1 > b.f4 as gt,
       a.f1 < b.f4 as lt, a.f1<=>b.f4 as eq
from t1 a, t1 b;
select *, f1 = f2 from t1;
drop table t1;

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1), (2);

SELECT MAX((SELECT 1 FROM t1 ORDER BY @var LIMIT 1)) m FROM t1 t2, t1 
       ORDER BY t1.a;
DROP TABLE t1;

SELECT MAX(TIMESTAMP(RAND(0)));
SELECT MIN(TIMESTAMP(RAND(0)));

SELECT MIN(GET_LOCK('aaaaaaaaaaaaaaaaa',0) / '0b1111111111111111111111111111111111111111111111111111111111111111111111111' ^ (RAND()));
SELECT MIN(GET_LOCK('aaaaaaaaaaaaaaaaa',0) / '0b1111111111111111111111111111111111111111111111111111111111111111111111111' ^ (RAND()));
SELECT MIN(GET_LOCK('aaaaaaaaaaaaaaaaa',0) / '0b1111111111111111111111111111111111111111111111111111111111111111111111111' ^ (RAND()));
SELECT MIN(GET_LOCK('aaaaaaaaaaaaaaaaa',0) / '0b1111111111111111111111111111111111111111111111111111111111111111111111111' ^ (RAND()));
SELECT RELEASE_LOCK('aaaaaaaaaaaaaaaaa');

CREATE TABLE t1 (a BIGINT UNSIGNED);
INSERT INTO t1 VALUES (18446668621106209655);
SELECT MAX(LENGTH(a)), LENGTH(MAX(a)), MIN(a), MAX(a), CONCAT(MIN(a)), CONCAT(MAX(a)) FROM t1;
DROP TABLE t1;

CREATE TABLE t1(f1 YEAR);
INSERT INTO t1 VALUES (0000),(2001);
DROP TABLE t1;

CREATE TABLE t1(a int, KEY(a));
INSERT INTO t1 VALUES (1), (2);
SELECT 1 FROM t1 ORDER BY AVG(DISTINCT a);
DROP TABLE t1;
CREATE TABLE t1(c1 TIME NOT NULL);
INSERT INTO t1 VALUES('837:59:59');
INSERT INTO t1 VALUES('838:59:59');
SELECT MAX(c1) FROM t1;
DROP TABLE t1;
CREATE TABLE t1(c1 TIME NOT NULL);
INSERT INTO t1 VALUES('-00:00:01');
SELECT MAX(c1),MIN(c1) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (col_int_nokey int(11));
INSERT INTO t1 VALUES (7),(8),(NULL);
SELECT AVG(DISTINCT col_int_nokey) FROM t1;
SELECT AVG(DISTINCT outr.col_int_nokey) FROM t1 AS outr LEFT JOIN t1 AS outr2 ON
outr.col_int_nokey = outr2.col_int_nokey;
DROP TABLE t1;
CREATE TABLE t1 (a int, KEY (a));
INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
SELECT MAX(a) FROM t1 WHERE a NOT BETWEEN 3 AND 9;

DROP TABLE t1;

CREATE TABLE t1 (
  a BLOB,
  b INT)
engine=innodb;

INSERT INTO t1 VALUES ('a', 0);

SELECT 0 FROM t1
WHERE 0 = (SELECT group_concat(b)
           FROM t1 t GROUP BY t1.a)
;
DROP TABLE t1;

-- Query in reported bug
CREATE TABLE e1(pk INT, col_date DATE);
CREATE TABLE b1(i INT);
CREATE TABLE bb4(col_int_key INT, KEY(col_int_key)) ENGINE=MYISAM;
INSERT INTO bb4 VALUES(4);

UPDATE IGNORE e1 AS outr1, b1 AS outr2 SET outr1.col_date =
JSON_SET(outr1.col_date, CONCAT('$','[',1,']','.','cdate'), '2007-07-12')
WHERE outr1.pk <= ANY ( SELECT DISTINCT innr1.col_int_key AS y FROM bb4
AS innr2 LEFT JOIN bb4 AS innr1 ON (innr2.col_int_key <> innr1.col_int_key)
WHERE innr1.col_int_key= 4);

DROP TABLE e1, b1, bb4;

-- Simplified query triggering the same assertion failure
CREATE TABLE t1(pk INT, KEY(pk)) ENGINE=MYISAM;

SELECT MIN(i2.pk) FROM t1 i1 LEFT JOIN t1 i2 ON (i1.pk != i2.pk)
WHERE i2.pk = 1;

DROP TABLE t1;

CREATE TABLE t1 (
  col_int_key int(11) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int int(11) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) ENGINE=MyISAM;

CREATE TABLE t2 (
  col_int_key int(11) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int int(11) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) ENGINE=MyISAM;

INSERT INTO t2 VALUES (4,1,2);

CREATE TABLE t3 (
  col_int int(11) DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) ENGINE=MyISAM;

INSERT INTO t3 VALUES (3,9,1);

CREATE TABLE t4 (
  col_int_key int(11) DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key)
) ENGINE=MyISAM;

SELECT (
  SELECT MIN(subquery1_t1.col_int_key)
  FROM t3 AS subquery1_t1
    RIGHT JOIN t1 AS subquery1_t2
      STRAIGHT_JOIN t4 AS subquery1_t3
      ON (subquery1_t3.pk = subquery1_t2.col_int_key)
    ON (subquery1_t3.col_int_key = subquery1_t2.col_int)
  WHERE subquery1_t1.col_int_key >= table1.col_int
    AND subquery1_t3.pk > table1.pk
)
FROM t2 AS table1;

DROP TABLE t1, t2, t3, t4;

CREATE TABLE t1 (
  id BIGINT NOT NULL AUTO_INCREMENT,
  f1 BIGINT,
  PRIMARY KEY(id),
  INDEX ix_fd2 (f1)
);
INSERT INTO t1 VALUES (NULL, 1), (NULL, 2), (NULL, 3);
CREATE FUNCTION f1 (par INT) RETURNS INT
    DETERMINISTIC
    SQL SECURITY INVOKER
BEGIN
   RETURN par + 1;
SELECT f1(MAX(f1)) FROM t1;

DROP TABLE t1;
DROP FUNCTION f1;

CREATE TABLE t1 (f1 INTEGER,f2 INTEGER);
INSERT INTO t1 VALUES (1,10),(1,20),(2,NULL),(2,NULL),(3,50);
SELECT f1, STD(f2) FROM t1 GROUP BY f1 WITH ROLLUP HAVING STD(f2) IS NULL;
SELECT f1, STD(f2) FROM t1 GROUP BY f1 WITH ROLLUP HAVING STD(f2) IS NOT NULL;
DROP TABLE t1;

CREATE TABLE t1 (
  i8 BIGINT UNIQUE,
  dc DECIMAL(10,4) UNIQUE,
  f8 DOUBLE UNIQUE,
  vc VARCHAR(10) UNIQUE
);
INSERT INTO t1 VALUES(123456, 123456.7890, 123456, '123456');

SET @i8=123456;
SET @dc='123456.7890';
SET @f8=123456.0E0;
SET @vc='123456';

SELECT MAX(i8) FROM t1 WHERE i8 > 123456;
SELECT MAX(dc) FROM t1 WHERE dc > 123456.7890;
SELECT MAX(f8) FROM t1 WHERE f8 > 123456e0;
SELECT MAX(vc) FROM t1 WHERE vc > '123456';

DROP TABLE t1;

CREATE TABLE tr (c1 INT);
INSERT INTO tr VALUES (1);

-- Generates a integer sequence from 1 to 2 and repeats
DELIMITER |;
CREATE FUNCTION seq_1_to_2() RETURNS INT
BEGIN
  DECLARE limit_value, return_value INT;
  SET limit_value = 2;
  SELECT c1 INTO return_value FROM tr;
  IF (return_value < limit_value) THEN
     UPDATE tr SET c1 = c1 + 1;
     UPDATE tr SET c1 = 1;
  END IF;

CREATE TABLE t1 (c1 INT);
INSERT INTO t1 VALUES (10);
INSERT INTO t1 VALUES (11);

SELECT seq_1_to_2() as seq, COUNT(*) FROM t1 GROUP BY seq;
SELECT FLOOR(seq_1_to_2() * 2) AS val, COUNT(*) FROM t1 GROUP BY val;
SELECT val, COUNT(*) FROM (SELECT FLOOR(seq_1_to_2())+1 val FROM t1) x
  GROUP BY x.val;

DROP TABLE t1, tr;
DROP FUNCTION seq_1_to_2;

CREATE TABLE t1(value double);

INSERT INTO t1 VALUES
(9.33174e+07),
(4.5e+95),
(7.31463e+09),
(1.79769e+308),
(-2.59078e+12),
(2.34165e+21),
(-1.79769e+308),
(0.0);
SELECT STDDEV(value) from t1;

DROP TABLE t1;

CREATE TABLE t2(grp int, value double);

INSERT INTO t2 VALUES
(0, 9.33174e+07),
(1, 4.5e+95),
(0, 7.31463e+09),
(1, 1.79769e+308),
(0, -2.59078e+12),
(1, 2.34165e+21),
(0, -1.79769e+308),
(1, 0.0);
SELECT VARIANCE(value) FROM t2 GROUP BY grp;

DROP TABLE t2;
