drop procedure if exists p1|
drop procedure if exists p2|
--enable_warnings

--##################################################################### 
-- Test Dynamic SQL in stored procedures. #############################
--##################################################################### 
--
-- A. Basics
--
create procedure p1()
begin
  prepare stmt from "select 1";
drop procedure p1|
--
-- B. Recursion. Recusion is disabled in SP, and recursive use of PS is not
-- possible as well.
--
create procedure p1()
begin
  execute stmt;
set @SAVE_SP_RECURSION_LEVELS=@@max_sp_recursion_depth|
set @@max_sp_recursion_depth=100|
--error ER_PS_NO_RECURSION
execute stmt|
--error ER_PS_NO_RECURSION
execute stmt|
--error ER_PS_NO_RECURSION
execute stmt|
--error ER_PS_NO_RECURSION 
call p1()|
--error ER_PS_NO_RECURSION 
call p1()|
--error ER_PS_NO_RECURSION
call p1()|
set @@max_sp_recursion_depth=@SAVE_SP_RECURSION_LEVELS|
--error ER_SP_RECURSION_LIMIT 
call p1()|
--error ER_SP_RECURSION_LIMIT
call p1()|
--error ER_SP_RECURSION_LIMIT
call p1()|

drop procedure p1|
--
-- C. Create/drop a stored procedure in Dynamic SQL.
-- One cannot create stored procedure from a stored procedure because of
-- the way MySQL SP cache works: it's important that this limitation is not
-- possible to circumvent by means of Dynamic SQL.
--
create procedure p1()
begin
  prepare stmt from "create procedure p2() begin select 1;
drop procedure p1|
create procedure p1()
begin
  prepare stmt from "drop procedure p2";
drop procedure p1|
--
-- D. Create/Drop/Alter a table (a DDL that issues a commit) in Dynamic SQL.
-- (should work ok).
--
create procedure p1()
begin
  prepare stmt_drop from "drop table if exists t1";
  insert into t1 (a) values (1);
  select * from t1;
  insert into t1 (a,b) values (2,1);
drop procedure p1|
--
-- A more real example (a case similar to submitted by 24/7).
--
create procedure p1()
begin
  set @tab_name=concat("tab_", replace(curdate(), '-', '_'));
  set @drop_sql=concat("drop table if exists ", @tab_name);
  set @create_sql=concat("create table ", @tab_name, " (a int)");
  set @insert_sql=concat("insert into ", @tab_name, " values (1), (2), (3)");
  set @select_sql=concat("select * from ", @tab_name);
  select @tab_name;
  select @drop_sql;
  select @create_sql;
  select @insert_sql;
  select @select_sql;
drop procedure p1|
--
-- E. Calling a stored procedure with Dynamic SQL
-- from a stored function (currently disabled).
-- 
create procedure p1()
begin
  prepare stmt_drop from "drop table if exists t1";
drop function if exists f1|
--enable_warnings
create function f1(a int) returns int
begin
  call p1();

-- Every stored procedure that contains Dynamic SQL is marked as
-- such. Stored procedures that contain Dynamic SQL are not
-- allowed in a stored function or trigger, and here we get the
-- corresponding error message.

--error ER_STMT_NOT_ALLOWED_IN_SF_OR_TRG 
select f1(0)|
--error ER_STMT_NOT_ALLOWED_IN_SF_OR_TRG 
select f1(f1(0))|
--error ER_STMT_NOT_ALLOWED_IN_SF_OR_TRG 
select f1(f1(f1(0)))|
drop function f1|
drop procedure p1|
--
-- F. Rollback and cleanup lists management in Dynamic SQL.
--
create procedure p1()
begin
  drop table if exists t1;
  create table t1 (id integer not null primary key,
                   name varchar(20) not null);
  insert into t1 (id, name) values (1, 'aaa'), (2, 'bbb'), (3, 'ccc');
  select name from t1;
    "select name from t1 where name=(select name from t1 where id=2)";
  select name from t1 where name=(select name from t1 where id=2);
drop procedure p1|
--
-- H. Executing a statement prepared externally in SP.
--
prepare stmt from "select * from t1"|
create procedure p1()
begin
  execute stmt;
drop procedure p1|
--
-- I. Use of an SP variable in Dynamic SQL is not possible and
-- this limitation is necessary for correct binary logging: prepared
-- statements do not substitute SP variables with their values for binlog, so
-- SP variables must be not accessible in Dynamic SQL.
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION'|
create procedure p1()
begin
  declare a char(10);
  set a="sp-variable";
  set @a="mysql-variable";
drop procedure p1|
SET sql_mode = default|
--
-- J. Use of placeholders in Dynamic SQL.
-- 
create procedure p1()
begin
  prepare stmt from 'select ? as a';
set @a=1|
call p1()|
call p1()|
drop procedure p1|
--
-- K. Use of continue handlers with Dynamic SQL.
--
drop table if exists t1|
drop table if exists t2|
create table t1 (id integer primary key auto_increment,
                 stmt_text char(35), status varchar(20))|
insert into t1 (stmt_text) values
  ("select 1"), ("flush tables"), ("handler t1 open as ha"), 
  ("analyze table t1"), ("check table t1"), ("checksum table t1"),
  ("check table t1"), ("optimize table t1"), ("repair table t1"),
  ("describe extended select * from t1"),
  ("help help"), ("show databases"), ("show tables"),
  ("show table status"), ("show open tables"), ("show storage engines"),
  ("insert into t1 (id) values (1)"), ("update t1 set status=''"),
  ("delete from t1"), ("truncate t1"), ("call p1()"), ("foo bar"),
  ("create view v1 as select 1"), ("alter view v1 as select 2"),
  ("drop view v1"),("create table t2 (a int)"),("alter table t2 add (b int)"),
  ("drop table t2")|
create procedure p1()
begin
  declare v_stmt_text varchar(255);
    set @status='not supported';
    set @status='syntax error';
    if not done then
      fetch c into v_id, v_stmt_text;
      set @id=v_id, @stmt_text=v_stmt_text;
      set @status="supported";
      prepare stmt from @stmt_text;
      execute update_stmt using @status, @id;
    end if;
select * from t1|
drop procedure p1|
drop table t1|
--
-- Bug#7115 "Prepared Statements: packet error if execution within stored
-- procedure".
--
prepare stmt from 'select 1'| 
create procedure p1() execute stmt|
call p1()|
call p1()|
drop procedure p1|
--
-- Bug#10975 "Prepared statements: crash if function deallocates"
-- Check that a prepared statement that is currently in use 
-- can't be deallocated.
--
-- a) Prepared statements and stored procedure cache:
--
-- TODO: add when the corresponding bug (Bug #12093 "SP not found on second
-- PS execution if another thread drops other SP in between") is fixed.
--
-- b) attempt to deallocate a prepared statement that is being executed
--error ER_STMT_NOT_ALLOWED_IN_SF_OR_TRG 
create function f1() returns int
begin
  deallocate prepare stmt;

-- b)-2 a crash (#1) spotted by Sergey Petrunia during code review
create procedure p1()
begin
  prepare stmt from 'select 1 A';
drop procedure p1|

--
-- Bug#10605 "Stored procedure with multiple SQL prepared statements
-- disconnects client"
--
--disable_warnings
drop table if exists t1, t2|
--enable_warnings
create procedure p1 (a int) language sql deterministic
begin
  declare rsql varchar(100);
  drop table if exists t1, t2;
  set @rsql= "create table t1 (a int)";
  select @rsql;
  set @rsql= null;
  set @rsql= "create table t2 (a int)";
  select @rsql;
  drop table if exists t1, t2;
set @a:=0|
call p1(@a)|
select @a|
call p1(@a)|
select @a|
drop procedure if exists p1|

-- End of the test
delimiter ;
