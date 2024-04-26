--  - It is possible to execute DDL statements in prelocking-free stored
--    procedure
--  - The same procedure can be called in prelocking-free mode and 
--    in prelocked mode (from within a function).

--disable_warnings
drop database if exists mysqltest;
drop table if exists t1, t2, t3, t4;
drop procedure if exists sp1;
drop procedure if exists sp2;
drop procedure if exists sp3;
drop procedure if exists sp4;
drop function if exists f1;
drop function if exists f2;
drop function if exists f3;

-- BUG#8072 

create database mysqltest;
use mysqltest//
create procedure sp1 () 
begin
  drop table if exists t1;
  select 1 as "my-col";

select database();
select database();

use test;
select database();
select database();

drop procedure mysqltest.sp1;
drop database mysqltest;

-- BUG#8766

delimiter //;
create procedure sp1() 
begin 
  create table t1 (a int);
  insert into t1 values (10);

create procedure sp2()
begin
  create table t2(a int);
  insert into t2 values(1);

create function f1() returns int
begin 
  return (select max(a) from t1);

create procedure sp3()
begin 
  call sp1();
  select 'func', f1();
select 't1',a from t1;

drop table t1;
select 't1',a from t1;
select 't2',a from t2;
drop table t1, t2;
select 't1',a from t1;

drop table t1;

drop procedure sp1;
drop procedure sp2;
drop procedure sp3;
drop function f1;
create procedure sp1()
begin
  create temporary table t2(a int);
  insert into t2 select * from t1;

create procedure sp2()
begin
  create temporary table t1 (a int);
  insert into t1 values(1);
  select 't1', a from t1;
  select 't2', a from t2;
  drop table t1;
  drop table t2;

drop procedure sp1;
drop procedure sp2;

-- Miscelaneous tests
create table t1 (a int);
insert into t1 values(1),(2);
create table t2 as select * from t1;
create table t3 as select * from t1;
create table t4 as select * from t1;
create procedure sp1(a int)
begin
  select a;
end //

create function f1() returns int
begin
  return (select max(a) from t1);
end //

delimiter ;
create procedure sp2(a int)
begin
  select * from t3;
  select a;
end //

create procedure sp3()
begin 
  select * from t1;
end //

create procedure sp4()
begin 
  select * from t2;
end //

delimiter ;

drop procedure sp1;
drop procedure sp2;
drop procedure sp3;
drop procedure sp4;
drop function f1;

-- Test that prelocking state restoration works with cursors
--disable_warnings
drop view if exists v1;

create function f1(ab int) returns int
begin
  declare i int;
  set i= (select max(a) from t1 where a < ab) ;
end //

create function f2(ab int) returns int
begin
  declare i int;
  set i= (select max(a) from t2 where a < ab) ;
end //

create view v1 as 
  select t3.a as x, t4.a as y, f2(3) as z
  from t3, t4 where t3.a = t4.a //

create procedure sp1()
begin
  declare a int;
  set a= (select f1(4) + count(*) A from t1, v1);
end //


create function f3() returns int
begin
  call sp1();
end //

call sp1() //

select f3() //
select f3() //

call sp1() //

-- ---------------
drop procedure sp1//
drop function f3//

create procedure sp1() 
begin 
  declare x int;

create function f3() returns int
begin
  call sp1();
end //

call sp1() //
call sp1() //

select f3() //
call sp1() //

delimiter ;
drop view v1;
drop table t1,t2,t3,t4;
drop function f1;
drop function f2;
drop function f3;
drop procedure sp1;

--
-- Bug#15683 "crash, Function on nested VIEWs, Prepared statement"
-- Check that when creating the prelocking list a nested view 
-- is not merged until it's used.
--
--disable_warnings
drop table if exists t1;
drop view if exists v1, v2, v3;
drop function if exists bug15683;
create table t1 (f1 bigint, f2 varchar(20), f3 bigint);
insert into t1 set f1 = 1, f2 = 'schoenenbourg', f3 = 1;
create view v1 as select 1 from t1 union all select 1;
create view v2 as select 1 from v1;
create view v3 as select 1 as f1 from v2;
create function bug15683() returns bigint
begin
return (select count(*) from v3);
drop table t1;
drop view v1, v2, v3;
drop function bug15683;


--
-- Bug#19634 "Re-execution of multi-delete which involve trigger/stored 
--            function crashes server"
--
--disable_warnings
drop table if exists t1, t2, t3;
drop function if exists bug19634;
create table t1 (id int, data int);
create table t2 (id int);
create table t3 (data int);
create function bug19634() returns int return (select count(*) from t3);

create trigger t1_bi before delete on t1 for each row insert into t3 values (old.data);

drop function bug19634;
drop table t1, t2, t3;

--
-- Bug #27907 Misleading error message when opening/locking tables
--

--disable_warnings
drop table if exists bug_27907_logs;
drop table if exists bug_27907_t1;

create table bug_27907_logs (a int);
create table bug_27907_t1 (a int);

create trigger bug_27907_t1_ai after insert on bug_27907_t1
for each row
begin
  insert into bug_27907_logs (a) values (1);

drop table bug_27907_logs;

--
-- was failing before with error ER_NOT_LOCKED
--
--error ER_NO_SUCH_TABLE
insert into bug_27907_t1(a) values (1);

drop table bug_27907_t1;
drop table if exists t1;
drop function if exists f_bug22427;
create table t1 (i int);
insert into t1 values (1);
create function f_bug22427() returns int return (select max(i) from t1);
select f_bug22427();
create table if not exists t1 select f_bug22427() as i;
create table t1 select f_bug22427() as i;
drop table t1;
drop function f_bug22427;
DROP table IF EXISTS t1,t2;
CREATE TABLE t1 (c1 INT);
CREATE TABLE t2 (c2 INT);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (2);
CREATE TRIGGER t1_ai AFTER INSERT ON t1 FOR EACH ROW
BEGIN
UPDATE t2 SET c2= c2 + 1;
INSERT INTO t1 VALUES (3);
INSERT INTO t2 values(4);
SELECT * FROM t1;
SELECT * FROM t2;
DROP TRIGGER t1_ai;
DROP TABLE t1, t2;

CREATE TABLE t1 SELECT 1 AS fld1, 'A' AS fld2;
CREATE TABLE t2 (fld3 INT, fld4 CHAR(1));

CREATE VIEW v1 AS SELECT * FROM t1;

CREATE TRIGGER t1_au AFTER UPDATE ON t1
FOR EACH ROW INSERT INTO t2 VALUES (new.fld1, new.fld2);
CREATE FUNCTION f1() RETURNS INT
BEGIN
 UPDATE v1 SET fld2='B' WHERE fld1=1;
END !
DELIMITER ;
SELECT f1();

DROP FUNCTION f1;
DROP VIEW v1;
DROP TABLE t1,t2;
CREATE FUNCTION f1() RETURNS INT RETURN 1;
CREATE TEMPORARY TABLE tmp1(a INT);
DROP TEMPORARY TABLES tmp1, tmp2;
DROP FUNCTION f1;
