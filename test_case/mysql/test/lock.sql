
--
-- Testing of table locking
--

-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc

--
-- BUG#5390 - problems with merge tables
-- Supplement test for the after-fix optimization
-- Check that a dropped table is correctly removed from a lock.
create table t1 (c1 int);
create table t2 (c1 int);
create table t3 (c1 int);
drop table t2, t3, t1;
create table t1 (c1 int);
create table t2 (c1 int);
create table t3 (c1 int);
alter table t2 add column c2 int;
drop table t1, t2, t3;

-- Bug7241 - Invalid response when DELETE .. USING and LOCK TABLES used.
--
create table t1 ( a int(11) not null auto_increment, primary key(a));
create table t2 ( a int(11) not null auto_increment, primary key(a));
delete from t1 using t1,t2 where t1.a=t2.a;
delete t1 from t1,t2 where t1.a=t2.a;
delete from t2 using t1,t2 where t1.a=t2.a;
delete t2 from t1,t2 where t1.a=t2.a;
drop table t1,t2;
drop table t2,t1;


--
-- Bug#18884 "lock table + global read lock = crash"
-- The bug is not repeatable, just add the test case.
--
create table t1 (a int);
drop table t1;


--
-- Test LOCK TABLE on system tables.  See bug#9953: CONVERT_TZ requires
-- mysql.time_zone_name to be locked.
--

CREATE TABLE t1 (i INT);

-- If at least one system table is locked for WRITE, then all other
-- tables should be system tables locked also for WRITE.
--error ER_WRONG_LOCK_OF_SYSTEM_TABLE
LOCK TABLES mysql.time_zone READ, mysql.time_zone_name WRITE, t1 READ;

DROP TABLE t1;
drop view if exists v_bug5719;
drop table if exists t1, t2, t3;
create table t1 (a int);
create temporary table t2 (a int);
create table t3 (a int);
create view v_bug5719 as select 1;
select * from t1;
select * from t2;
select * from t3;
select * from v_bug5719;
drop view v_bug5719;
select * from t1;
create or replace view v_bug5719 as select * from t1;
select * from v_bug5719;
select * from t1;
select * from t2;
select * from t3;
drop table t1;
select * from v_bug5719;
create table t1 (a int);
drop table t1;
select * from t3;
select * from v_bug5719;
drop view v_bug5719;
create view v_bug5719 as select * from t2;
drop table t2, t3;
CREATE TABLE t1 (
table1_rowid SMALLINT NOT NULL
);
CREATE TABLE t2 (
table2_rowid SMALLINT NOT NULL
);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1);
DELETE FROM t1 
WHERE EXISTS 
( 
SELECT 'x' 
FROM t2
WHERE t1.table1_rowid = t2.table2_rowid
) ;
SELECT * FROM t1 WHERE 1 IN (SELECT * FROM t2 FOR UPDATE);
DROP TABLE t1,t2;

create table t1 (a int);
create table t2 (a int);
create temporary table t1 (a int);
drop temporary table t1;
select * from t1;
drop table t1, t2;
drop table if exists t1;
drop view if exists v1;
create table t1 (c1 int);
create view v1 as select * from t1;
insert into t1 values (33);
select * from t1;
drop table t1;
drop view v1;

create table t1 (a int);
set autocommit= 0;
insert into t1 values (1);
drop table t1;

create table t1 (a int);
insert into t1 values (1);
drop table t1;
drop tables if exists t1, t2;
drop view if exists v1;
drop function if exists f1;
create table t1 (i int);
create table t2 (j int);
create view v1 as select * from t2;
alter table t2 add column k int;
create trigger t2_bi before insert on t2 for each row set @a:=1;
drop table t2;
drop view v1;
create function f1 () returns int
begin
  insert into t2 values (1);
create table t2 (j int);
create view v1 as select f1() from t1;
alter table t2 add column k int;
create trigger t2_bi before insert on t2 for each row set @a:=1;
drop table t2;
drop view v1;
drop function f1;
create trigger t1_ai after insert on t1 for each row insert into t2 values (1);
create table t2 (j int);
alter table t2 add column k int;
create trigger t2_bi before insert on t2 for each row set @a:=1;
drop table t2;
drop trigger t1_ai;
drop tables t1;
create table t1 (i int);
alter table t1 add column j int;
drop table t1;
create temporary table t1 (i int);
alter table t1 add column j int;
drop table t1;

CREATE TABLE t1 (a INT);
DROP TABLE t1;

CREATE TABLE t1(a INT);
DROP TABLE t1;

CREATE TABLE t1 (f1 INT, f2 INT) ENGINE = MEMORY;
CREATE TRIGGER t1_ai AFTER INSERT ON t1 FOR EACH ROW 
  UPDATE LOW_PRIORITY t1 SET f2 = 7;
INSERT INTO t1(f1) VALUES(0);

DROP TABLE t1;
CREATE TABLE t1 (id INT);
CREATE TABLE t2 (id INT);
DROP TABLE t1, t2;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a INT);
DROP TABLE t1;

-- Check that all connections opened by test cases in this file are really
-- gone so execution of other tests won't be affected by their presence.
--source include/wait_until_count_sessions.inc

call mtr.add_suppression("Can't open and lock privilege tables: Table 'user' was not locked with LOCK TABLES");
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (c1 INT);
DROP TABLE t1;
