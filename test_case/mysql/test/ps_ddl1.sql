
--
-- Testing the behavior of 'PREPARE', 'DDL', 'EXECUTE' scenarios
--
-- There are several subtests which are probably "superfluous" because a DDL
-- statement before the EXECUTE <prepared stmt handle> contained a keyword
-- or action (Example: Alter) which causes that all prepared statements using
-- the modified object are reprepared before execution.
-- Please do not delete these subtests if they disturb. Just disable them by
-- if (0)
-- {
--    <tests to disable>
-- }.
-- There might be future optimisations of the server which decrease the amount
-- of unneeded reprepares or skip unneeded prepare steps and than these subtests
-- might become valuable.
--    Example:
--    Every preceding ALTER TABLE seems to cause a reprepare.
--    But if the ALTER only changed the table comment ...
--
-- Created: 2008-04-18 mleich
--

--disable_warnings
drop temporary table if exists t1;
drop table if exists t1, t2;
drop procedure if exists p_verify_reprepare_count;
drop procedure if exists p1;
drop function if exists f1;
drop view if exists t1;
drop schema if exists mysqltest;
create procedure p_verify_reprepare_count(expected int)
begin
  declare old_reprepare_count int default @reprepare_count;

  select variable_value from
  performance_schema.session_status where
  variable_name='com_stmt_reprepare'
  into @reprepare_count;

  if old_reprepare_count + expected <> @reprepare_count then
    select concat("Expected: ", expected,
                   ", actual: ", @reprepare_count - old_reprepare_count)
    as "ERROR";
    select '' as "SUCCESS";
  end if;
set @reprepare_count= 0;
drop table if exists t1;
create table t1 (a int, b int);
alter table t1 add column c int;
alter table t1 drop column b;
alter table t1 comment "My best table";
drop table t1;
create table t1 (a int);
--   "truncate" must have the first position (= executed as last prepared
--   statement), because it recreates the table which has leads to reprepare
--   (is this really needed) of all statements.
prepare stmt1 from "truncate t1";
let ps_stmt_count= 10;
let $num= $ps_stmt_count;
{
   --disable_result_log
   eval execute stmt$num;
   dec $num;
drop table t1;
let $num= $ps_stmt_count;
{
   --error ER_NO_SUCH_TABLE
   eval execute stmt$num;
   dec $num;
let $num= $ps_stmt_count;
{
   eval deallocate prepare stmt$num;
   dec $num;
create table t1 (a int, b int);
insert into t1 values(1,1),(2,2),(3,3);
create table t2 like t1;
insert into t1 values(2,2);
let ps_stmt_count= 8;
let $num= $ps_stmt_count;
{
   --disable_result_log
   eval execute stmt$num;
   dec $num;
alter table t1 drop column b;
let $num= $ps_stmt_count;
{
   eval execute stmt$num;
   -- A reprepare is needed, because layout change of t1 affects statement.
   call p_verify_reprepare_count(1);
   dec $num;
let $num= $ps_stmt_count;
{
   eval execute stmt$num;
   dec $num;
alter table t2 add column c int;
let $num= $ps_stmt_count;
{
   eval deallocate prepare stmt$num;
   dec $num;
drop table t1;
drop table t2;
create table t1 (a int, b int, primary key(b),unique index t1_unq_idx(a));
insert into t1 set a = 0, b = 0;
insert into t1 select a + 1, b + 1 from t1;
insert into t1 select a + 2, b + 2 from t1;
insert into t1 select a + 4, b + 4 from t1;
insert into t1 select a + 8, b + 8 from t1;
let $possible_keys=
    query_get_value(explain select avg(a) from t1, possible_keys, 1);
let $extra=
    query_get_value(explain select avg(a) from t1, Extra, 1);

alter table t1 drop index t1_unq_idx;
let $possible_keys=
    query_get_value(explain select avg(a) from t1, possible_keys, 1);
let $extra=
    query_get_value(explain select avg(a) from t1, Extra, 1);
alter table t1 add unique index t1_unq_idx(a);
let $possible_keys=
    query_get_value(explain select avg(a) from t1, possible_keys, 1);
let $extra=
    query_get_value(explain select avg(a) from t1, Extra, 1);
drop table t1;
create table t1 (a int);

drop table t1;
create view t1 as select 1;

drop view t1;
create table t2 (a int);
create view t1 as select * from t2 with check option;
select * from t1;
drop view t1;
drop table t2;

create temporary table t1 as select 1 as a;
create procedure p1()
begin
  drop temporary table t1;
create function f1() returns int
begin
  call p1();
select * from t1;
select * from t1;
select * from t1;
select * from t1;
                   where exists (select f1() from t1)";
select * from t1;

drop function f1;
drop procedure p1;
create temporary table t1 as select 1 as a;
create procedure p1()
begin
  drop temporary table t1;
  create temporary table t1 as select 'abc' as a;
create function f1() returns int
begin
  call p1();
select * from t1;
drop procedure p1;
create schema mysqltest;
create procedure mysqltest.p1()
begin
   drop schema mysqltest;
   create schema mysqltest;
drop schema mysqltest;
drop temporary table t1;


-- Bug#36089 drop temp table in SP called by function, crash
-- Note: A non prepared "select 1 from t1 having count(*) = f1();
create temporary table t1 as select 1 as a;
drop temporary table t1;
}


--echo -- Cleanup
--echo --
--disable_warnings
drop temporary table if exists t1;
drop table if exists t1, t2;
drop procedure if exists p_verify_reprepare_count;
drop procedure if exists p1;
drop function if exists f1;
drop view if exists t1;
drop schema if exists mysqltest;
