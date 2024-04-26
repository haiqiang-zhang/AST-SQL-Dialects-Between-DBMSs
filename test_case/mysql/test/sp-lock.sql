--

-- Thread stack overrun in debug mode on sparc
--source include/not_sparc_debug.inc

--echo -- 
--echo -- Test coverage for changes performed by the fix
--echo -- for Bug#30977 "Concurrent statement using stored function
--echo -- and DROP FUNCTION breaks SBR.
--echo --

--echo --
--echo -- 1) Verify that the preceding transaction is
--echo -- (implicitly) committed  before CREATE/ALTER/DROP
--echo -- PROCEDURE. Note, that this is already tested
--echo -- in implicit_commit.test, but here we use an alternative
--echo -- approach.
--echo --

--echo -- Start a transaction, create a savepoint, 
--echo -- then call a DDL operation on a procedure, and then check
--echo -- that the savepoint is no longer present.

--disable_warnings
drop table if exists t1;
drop procedure if exists p1;
drop procedure if exists p2;
drop procedure if exists p3;
drop procedure if exists p4;
drop function if exists f1;
create table t1 (a int);
create procedure p1() begin end;
alter procedure p1 comment 'changed comment';
drop procedure p1;
create function f1() returns int return 1;
alter function f1 comment 'new comment';
drop function f1;
create procedure p1() begin end;
create function f1() returns int return 1;
create procedure p2() begin end;
alter procedure p1 comment 'changed comment';
drop procedure p1;
create function f2() returns int return 1;
alter function f1 comment 'changed comment';
create procedure p2() begin end;
alter procedure p1 comment 'changed comment';
drop procedure p1;
create function f2() returns int return 1;
alter function f1 comment 'changed comment';
drop table t1;
create temporary table t1 (a int);
create procedure p2() begin end;
alter procedure p1 comment 'changed comment';
drop procedure p1;
create function f2() returns int return 1;
alter function f1 comment 'changed comment';

drop function f1;
drop procedure p1;
drop temporary table t1;
create procedure p1() begin end;
create function f1() returns int 
begin
  call p1();
select f1();
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored procedure metadata lock' and
info='drop procedure p1';
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored procedure metadata lock' and info='select f1()';
create procedure p1() begin end;
select f1();
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored procedure metadata lock' and
info='create procedure p1() begin end';
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored procedure metadata lock' and info='select f1()';
select f1();
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored procedure metadata lock' and
info='alter procedure p1 contains sql';
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored procedure metadata lock' and info='select f1()';
select f1();
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and
info='drop function f1';
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and info='select f1()';
create function f1() returns int return 1;
select f1();
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and
info='create function f1() returns int return 2';
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and info='select f1()';
select f1();
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and
info='alter function f1 contains sql';
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and info='select f1()';
drop function f1;
drop procedure p1;
create function f1() returns int return 1;
create table t1 (a int);
create table t2 (a int, b int);
create trigger t1_ai after insert on t1 for each row
  insert into t2 (a, b) values (new.a, f1());
insert into t1 (a) values (1);
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and
info='drop function f1';
create function f1() returns int return 1;
create view v1 as select f1() as a;
select * from v1;
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and
info='drop function f1';
create function f1() returns int
begin
  declare v_out int;
create procedure p1(out v_out int) set v_out=3;
select * from v1;
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored procedure metadata lock' and
info='drop procedure p1';
create function f2() returns int return 4;
create procedure p1(out v_out int) set v_out=f2();
drop trigger t1_ai;
create trigger t1_ai after insert on t1 for each row
  insert into t2 (a, b) values (new.a, (select max(a) from v1));
insert into t1 (a) values (3);
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and
info='drop function f2';

drop view v1;
drop function f1;
drop procedure p1;
drop table t1, t2;
create function f1() returns int return 7;
create table t1 (a int);
select * from t1;
select f1();
drop table t1;
drop function f1;
create function f1() returns varchar(20) return "f1()";
create function f2() returns varchar(20) return "f2()";
create view v1 as select f1() as a;
set @@session.autocommit=0;
select * from v1;
select f2();
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and
info='drop function f1';
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and
info='drop function f2';
drop function f1;
drop function f2;
drop view v1;
set @@session.autocommit=default;
create function f1() returns int return 1;
create function f2() returns int
begin
  if @var is null then
    call p1();
  end if;
create procedure p1()
begin
  select f1() into @var;
select f1();
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and
info like 'alter function f1 comment%';
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and
info='select f1() into @var';
drop function f1;
drop function f2;
drop procedure p1;
create function f1() returns int return 1;
select f1();
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and
info like 'alter function f1 comment%';
create function f2() returns int
begin
  if @var is null then
    call p1();
  end if;
create procedure p1()
begin
  select f1() into @var;
  select f2() into @var;
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='Waiting for stored function metadata lock' and
info='select f1() into @var';
drop function f1;
drop function f2;
drop procedure p1;
create function f1() returns int return get_lock("30977", 100000);
create function f2() returns int return 2;
create function f3() returns varchar(255) 
begin
  declare res varchar(255);
    information_schema.routines where routine_name='f1';
  select f1() into @var;
  select f2() into @var;
select get_lock("30977", 0);
let $wait_condition=select count(*)=1 from information_schema.processlist
where state='User lock' and info='select f1() into @var';
create function f4() returns int return  4;
drop function f4;
select release_lock("30977");
select @var;
drop function f1;
drop function f2;
drop function f3;
create function f1() returns int
begin
  call p1();
create procedure p1() 
begin
  create view v1 as select 1;
  drop view v1;
  select f1() into @var;
  set @exec_count=@exec_count+1;
set @exec_count=0;
select @exec_count;
set @@session.max_sp_recursion_depth=5;
set @exec_count=0;
select @exec_count;
drop procedure p1;
drop function f1;
set @@session.max_sp_recursion_depth=default;
CREATE PROCEDURE p1()
BEGIN
  SHOW CREATE PROCEDURE p1;
  SELECT get_lock("test", 100000);
SELECT get_lock("test", 10);
let $wait_condition=SELECT COUNT(*)=1 FROM information_schema.processlist 
  WHERE state='User lock' and info='SELECT get_lock("test", 100000)';
DROP PROCEDURE p1;
CREATE PROCEDURE p1() BEGIN END;
SELECT release_lock("test");
DROP PROCEDURE p1;
DROP DATABASE IF EXISTS db1;
DROP FUNCTION IF EXISTS f1;
CREATE DATABASE db1;
CREATE FUNCTION db1.f1() RETURNS INTEGER RETURN 1;
SELECT db1.f1();
let $wait_condition= SELECT COUNT(*)= 1 FROM information_schema.processlist
  WHERE state= 'Waiting for stored function metadata lock'
  AND info='DROP DATABASE db1';
CREATE DATABASE db1;
CREATE PROCEDURE db1.p1() BEGIN END;
CREATE FUNCTION f1() RETURNS INTEGER
BEGIN
  CALL db1.p1();
SELECT f1();
let $wait_condition= SELECT COUNT(*)= 1 FROM information_schema.processlist
  WHERE state= 'Waiting for stored procedure metadata lock'
  AND info='DROP DATABASE db1';
CREATE DATABASE db1;
CREATE TABLE db1.t1 (a INT);
CREATE FUNCTION db1.f1() RETURNS INTEGER RETURN 1;
SELECT db1.f1();
let $wait_condition= SELECT COUNT(*)= 1 FROM information_schema.processlist
  WHERE state= 'Waiting for stored function metadata lock'
  AND info='DROP DATABASE db1';
SELECT * FROM db1.t1;
CREATE DATABASE db1;
CREATE FUNCTION db1.f1() RETURNS INTEGER RETURN 1;
CREATE FUNCTION db1.f2() RETURNS INTEGER RETURN 2;
SELECT db1.f2();
let $wait_condition= SELECT COUNT(*)= 1 FROM information_schema.processlist
  WHERE state= 'Waiting for stored function metadata lock'
  AND info='DROP DATABASE db1';
let $wait_condition= SELECT COUNT(*)= 1 FROM information_schema.processlist
  WHERE state= 'Waiting for schema metadata lock'
  AND info='ALTER FUNCTION db1.f1 COMMENT "test"';
DROP FUNCTION f1;
