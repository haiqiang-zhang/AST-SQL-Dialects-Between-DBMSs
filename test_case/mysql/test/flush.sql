drop table if exists t1,t2;
drop database if exists mysqltest;

create temporary table t1(n int not null primary key);
create table t2(n int);
insert into t2 values(3);
let $1=100;
 dec $1;
select * from t1;
drop table t2;
create database mysqltest;
create table mysqltest.t1(n int);
insert into mysqltest.t1 values (23);
select * from mysqltest.t1;

-- test if dirty close releases global read lock
connection con1;
create table t1 (n int);
insert into t1 values (345);
select * from t1;
drop table t1;

--
-- Bug#9459 - deadlock with flush with lock, and lock table write
--
create table t1 (c1 int);
create table t2 (c1 int);
create table t3 (c1 int);
drop table t1, t2, t3;

-- End of 4.1 tests

--
-- Test of deadlock problem when doing FLUSH TABLE with read lock
-- (Bug was in NTPL threads in Linux when using different mutex while
--  waiting for a condtion variable)

create table t1 (c1 int);
create table t2 (c1 int);
drop table t1, t2;

--
-- Bug#32528 Global read lock with a low priority write lock causes a server crash
--

--disable_warnings
drop table if exists t1, t2;

set session low_priority_updates=1;

create table t1 (a int);
create table t2 (b int);

drop table t1, t2;

set session low_priority_updates=default;

--
-- Bug #26380: LOCK TABLES + FLUSH LOGS causes deadlock
--
set @old_general_log= @@general_log;
set @old_read_only= @@read_only;
set global general_log= on;

set global read_only=1;

set global general_log= @old_general_log;
set global read_only= @old_read_only;
drop tables if exists t1, t2;
create table t1 (i int);
create temporary table t2 (j int);
drop tables t1, t2;
drop table if exists t1, t2, t3;
create table t1 (a int);
create table t2 (a int);
create table t3 (a int);
select * from t1;
select * from t2;
select * from t3;
insert into t1 (a) values (1);
insert into t2 (a) values (1);
insert into t3 (a) values (1);
insert into t2 (a) values (1);
insert into t1 (a) values (1);
insert into t2 (a) values (1);
select * from t1;
select * from t2;
select * from t3;
insert into t1 (a) values (2);
insert into t2 (a) values (2);
insert into t3 (a) values (2);
insert into t3 (a) values (2);
select * from t1;
select * from t2;
insert into t2 (a) values (3);
select * from t1;
set global read_only=1;
set global read_only=0;
drop table t1, t2, t3;
drop view if exists v1, v2, v3;
drop table if exists t1, v1;
create table t1 (a int);
create view v1 as select 1;
create view v2 as select * from t1;
create view v3 as select * from v2;
create temporary table v1 (a int);
drop view v1;
create table v1 (a int);
drop temporary table v1;
drop view v2, v3;
drop table t1, v1;
drop table if exists t1;
create table t1 (a int, key a (a));
insert into t1 (a) values (1), (2), (3);
drop table t1;
drop table if exists t1;

create table t1 (a int);
select * from t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush"
  and info = "flush table t1";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush"
  and info = "select * from t1";
select * from t1;
select * from t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush"
  and info = "flush tables";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush"
  and info = "select * from t1";
select * from t1;
drop table t1;
drop table if exists t1, t2;
create table t1 (i int);
create table t2 (i int);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table flush"
  and info = "flush tables with read lock";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock"
  and info = "insert into t2 values (1)";
drop tables t1, t2;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a INT);

-- All these triggered the assertion
--error ER_TABLE_NOT_LOCKED_FOR_WRITE
FLUSH TABLES;
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW SET @a= 1;
ALTER TABLE t1 COMMENT 'test';
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT PRIMARY KEY, value INT);
INSERT INTO t1 VALUES (1, 1);
CREATE TRIGGER t1_au AFTER UPDATE ON t1 FOR EACH ROW SET @var = "a";
UPDATE t1 SET value= value + 1 WHERE id = 1;
DROP TABLE t1;
