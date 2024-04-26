
--
-- Test of --lower-case-table-names
--

--disable_warnings
drop table if exists t1,t2,t3,t4;
drop table if exists t0,t5,t6,t7,t8,t9;
drop database if exists mysqltest;
drop view if exists v0, v1, v2, v3, v4;

create table T1 (id int primary key, Word varchar(40) not null, Index(Word));
create table t4 (id int primary key, Word varchar(40) not null);
INSERT INTO T1 VALUES (1, 'a'), (2, 'b'), (3, 'c');
INSERT INTO T4 VALUES(1,'match');
SELECT * FROM t1;
SELECT T1.id from T1 LIMIT 1;
SELECT T2.id from t1 as T2 LIMIT 1;
SELECT * from t1 left join t4 on (test.t1.id= TEST.t4.id) where TEST.t1.id >= test.t4.id;
SELECT T2.id from t1 as t2 LIMIT 1;
ALTER TABLE T2 ADD new_col int not null;
ALTER TABLE T2 RENAME T3;
drop table t3,t4;
create table t1 (a int);
select count(*) from T1;
select count(*) from t1;
select count(T1.a) from t1;
select count(bags.a) from t1 as Bags;
drop table t1;

--
-- Test all caps database name
--
create database mysqltest;
use MYSQLTEST;
create table t1 (a int);
select T1.a from MYSQLTEST.T1;
select t1.a from MYSQLTEST.T1;
select mysqltest.t1.* from MYSQLTEST.t1;
select MYSQLTEST.t1.* from MYSQLTEST.t1;
select MYSQLTEST.T1.* from MYSQLTEST.T1;
select MYSQLTEST.T1.* from T1;
alter table t1 rename to T1;
select MYSQLTEST.t1.* from MYSQLTEST.t1;
drop database mysqltest;
use test;

--
-- multiupdate/delete & --lower-case-table-names
--
create table t1 (a int);
create table t2 (a int);
delete p1.*,P2.* from t1 as p1, t2 as p2 where p1.a=P2.a;
delete P1.*,p2.* from t1 as P1, t2 as P2 where P1.a=p2.a;
update t1 as p1, t2 as p2 SET p1.a=1,P2.a=1 where p1.a=P2.a;
update t1 as P1, t2 as P2 SET P1.a=1,p2.a=1 where P1.a=p2.a;
drop table t1,t2;

--
-- aliases case insensitive
--
create table t1 (a int);
create table t2 (a int);
select * from t1 c, t2 C;
select C.a, c.a from t1 c, t2 C;
drop table t1, t2;

--
-- Bug #9761: CREATE TABLE ... LIKE ... not handled correctly when
-- lower_case_table_names is set

create table t1 (a int);
create table t2 like T1;
drop table t1, t2;

-- End of 4.1 tests


--

--Replace default engine value with static engine string 
--replace_result $DEFAULT_ENGINE ENGINE
-- Bug#20404: SHOW CREATE TABLE fails with Turkish I
--
set names utf8mb3;
drop table if exists İ,İİ;
create table İ (s1 int);
drop table İ;
create table İİ (s1 int);
drop table İİ;
set names latin1;

--

--Replace default engine value with static engine string 
--replace_result $DEFAULT_ENGINE ENGINE
-- Bug#21317: SHOW CREATE DATABASE does not obey to lower_case_table_names
--
create database mysql_TEST;
drop database mysql_TEST;

-- Additional test coverage
SET GLOBAL log_output= 'TABLE';
SELECT @@general_log;
SELECT @@lower_case_table_names;
ALTER TABLE mysql.general_log DISCARD TABLESPACE;
ALTER TABLE MYSQL.general_log DISCARD TABLESPACE;
ALTER TABLE mysql.GENERAL_LOG DISCARD TABLESPACE;
SET GLOBAL log_output= DEFAULT;
