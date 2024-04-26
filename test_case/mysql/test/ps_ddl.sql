
--
-- Testing the behavior of 'PREPARE', 'DDL', 'EXECUTE' scenarios
--
-- Background:
-- In a statement like "select * from t1", t1 can be:
-- - nothing (the table does not exist)
-- - a real table
-- - a temporary table
-- - a view
--
-- Changing the nature of "t1" between a PREPARE and an EXECUTE
-- can invalidate the internal state of a prepared statement, so that,
-- during the execute, the server should:
-- - detect state changes and fail to execute a statement,
--   instead of crashing the server or returning wrong results
-- - "RE-PREPARE" the statement to restore a valid internal state.
--
-- Also, changing the physical structure of "t1", by:
-- - changing the definition of t1 itself (DDL on tables, views)
-- - changing TRIGGERs associated with a table
-- - changing PROCEDURE, FUNCTION referenced by a TRIGGER body,
-- - changing PROCEDURE, FUNCTION referenced by a VIEW body,
-- impacts the internal structure of a prepared statement, and should
-- cause the same verifications at execute time to be performed.
--
-- This test provided in this file cover the different state transitions
-- between a PREPARE and an EXECUTE, and are organized as follows:
-- - Part  1: NOTHING -> TABLE
-- - Part  2: NOTHING -> TEMPORARY TABLE
-- - Part  3: NOTHING -> VIEW
-- - Part  4: TABLE -> NOTHING
-- - Part  5: TABLE -> TABLE (DDL)
-- - Part  6: TABLE -> TABLE (TRIGGER)
-- - Part  7: TABLE -> TABLE (TRIGGER dependencies)
-- - Part  8: TABLE -> TEMPORARY TABLE
-- - Part  9: TABLE -> VIEW
-- - Part 10: TEMPORARY TABLE -> NOTHING
-- - Part 11: TEMPORARY TABLE -> TABLE
-- - Part 12: TEMPORARY TABLE -> TEMPORARY TABLE (DDL)
-- - Part 13: TEMPORARY TABLE -> VIEW
-- - Part 14: VIEW -> NOTHING
-- - Part 15: VIEW -> TABLE
-- - Part 16: VIEW -> TEMPORARY TABLE
-- - Part 17: VIEW -> VIEW (DDL)
-- - Part 18: VIEW -> VIEW (VIEW dependencies)
-- - Part 19: Special tables (INFORMATION_SCHEMA)
-- - Part 20: Special tables (log tables)
-- - Part 21: Special tables (system tables)
-- - Part 22: Special tables (views temp tables)
-- - Part 23: Special statements
-- - Part 24: Testing the strength of TABLE_SHARE version

--disable_warnings
drop temporary table if exists t1, t2, t3;
drop table if exists t1, t2, t3;
drop procedure if exists p_verify_reprepare_count;
drop procedure if exists p1;
drop function if exists f1;
drop view if exists v1, v2;
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

-- can not be tested since prepare failed
--error ER_NO_SUCH_TABLE
prepare stmt from "select * from t1";

-- can not be tested

--echo =====================================================================
--echo Part 3: NOTHING -> VIEW transitions
--echo =====================================================================

-- can not be tested

--echo =====================================================================
--echo Part 4: TABLE -> NOTHING transitions
--echo =====================================================================

--echo -- Test 4-a: select ... from <table>
create table t1 (a int);

drop table t1;
create table t1 (a int);
drop table t2;

create table t1 (a int);

alter table t1 add column (b int);

drop table t1;

create table t1 (a int);
set @val=1;

-- Relevant trigger: execute should reprepare
create trigger t1_bi before insert on t1 for each row
  set @message= new.a;

set @val=2;
select @message;
set @val=3;
select @message;
set @val=4;
select @message;

-- Unrelated trigger: reprepare may or may not happen, implementation dependent
create trigger t1_bd before delete on t1 for each row
  set @message= old.a;

set @val=5;
select @message;
set @val=6;
select @message;
set @val=7;
select @message;

-- Relevant trigger: execute should reprepare
drop trigger t1_bi;
create trigger t1_bi before insert on t1 for each row
  set @message= concat("new trigger: ", new.a);

set @val=8;
select @message;
set @val=9;
select @message;
set @val=10;
select @message;

-- Unrelated trigger: reprepare may or may not happen, implementation dependent
drop trigger t1_bd;

set @val=11;
select @message;

drop trigger t1_bi;

set @val=12;
select @message;
set @val=13;
select @message;
set @val=14;
select @message;

select * from t1 order by a;
drop table t1;

create table t1 (a int);
create trigger t1_ai after insert on t1 for each row
  call p1(new.a);
create procedure p1(a int) begin end;
set @var= 1;
drop procedure p1;
create procedure p1 (a int) begin end;
set @var= 2;
drop procedure p1;
drop trigger t1_ai;
create trigger t1_ai after insert on t1 for  each row
  select f1(new.a+1) into @var;
create function f1 (a int) returns int return a;
set @var=3;
select @var;
drop function f1;
create function f1 (a int) returns int return 0;
drop function f1;
drop trigger t1_ai;
create table t2 (a int unique);
create table t3 (a int unique);
create view v1 as select a from t2;
create trigger t1_ai after insert on t1 for each row
  insert into v1 (a) values (new.a);
insert into t1 (a) values (5);
select * from t2;
select * from t3;
drop view v1;
create view v1 as select a from t3;
insert into t1 (a) values (6);
select * from t2;
select * from t3;
set @var=7;
select * from t3;
select * from t2;
drop view v1;
create view v1 as select a from t2;
set @var=8;
select * from t2;
select * from t3;
drop view v1;
drop table t1,t2,t3;
create table t1 (a int);
create trigger t1_ai after insert on t1 for each row
  insert into t2 (a) values (new.a);
create table t2 (a int);
set @var=1;
alter table t2 add column comment varchar(255);
set @var=2;
select * from t1;
select * from t2;
drop table t1,t2;
create table t1 (a int);
create trigger t1_ai after insert on t1 for each row
  insert into t2 (a) values (new.a);
create table t2 (a int unique);
create trigger t2_ai after insert on t2 for each row
  insert into t3 (a) values (new.a);
create table t3 (a int unique);
create table t4 (a int unique);

insert into t1 (a) values (1);
select * from t1 join t2 on (t1.a=t2.a) join t3 on (t2.a=t3.a);
drop trigger t2_ai;
create trigger t2_ai after insert on t2 for each row
  insert into t4 (a) values (new.a);
insert into t1 (a) values (2);
select * from t1 join t2 on (t1.a=t2.a) join t4 on (t2.a=t4.a);
set @var=3;
select * from t1 join t2 on (t1.a=t2.a) join t4 on (t2.a=t4.a);
drop trigger t2_ai;
create trigger t2_ai after insert on t2 for each row
  insert into t3 (a) values (new.a);
set @var=4;
select * from t1 join t2 on (t1.a=t2.a) join t3 on (t2.a=t3.a);
select * from t1 join t2 on (t1.a=t2.a) join t4 on (t2.a=t4.a);

drop table t1, t2, t3, t4;
create table t1 (a int);

drop table t1;
create temporary table t1 (a int);

drop table t1;
create table t1 (a int);

create temporary table t1 AS SELECT 1;
drop temporary table t1;
drop table t1;

create table t1 (a int);

drop table t1;
create table t2 (a int);
create view t1 as select * from t2;

drop view t1;
drop table t2;

create temporary table t1 (a int);

drop temporary table t1;
create table t1 (a int);
insert into t1 (a) value (1);
create temporary table t1 (a int);

drop temporary table t1;

select * from t1;
drop table t1;
create table t1 (a int);
create temporary table t1 as select 1 as a;

drop temporary table t1;
drop table t1;

create temporary table t1 (a int);

drop temporary table t1;
create temporary table t1 (a int, b int);

select * from t1;
drop temporary table t1;

create temporary table t1 (a int);
create table t2 (a int);

drop temporary table t1;
create view t1 as select * from t2;

drop view t1;
drop table t2;

create table t2 (a int);
create view t1 as select * from t2;
drop view t1;

drop table t2;

create table t2 (a int);
create view t1 as select * from t2;

drop view t1;
create table t1 (a int);

drop table t2;
drop table t1;
create table t2 (a int);
insert into t2 (a) values (1);
create view t1 as select * from t2;

create temporary table t1 (a int);

drop view t1;

drop table t2;
drop temporary table t1;
create table t2 (a int);
insert into t2 (a) values (1);
create algorithm = temptable view t1 as select * from t2;

create temporary table t1 (a int);

drop view t1;

drop table t2;
drop temporary table t1;
create view t1 as select table_name from information_schema.views where table_schema != 'sys';

create temporary table t1 (a int);

drop view t1;

drop temporary table t1;

create table t2 (a int);
insert into t2 values (10), (20), (30);

create view t1 as select a, 2*a as b, 3*a as c from t2;
select * from t1;

drop view t1;
create view t1 as select a, 2*a as b, 5*a as c from t2;
select * from t1;
alter view t1 as select a, 3*a as b, 4*a as c from t2;
select * from t1;
drop view t1;
create view t1 as select a, 5*a as b, 6*a as c from t2;
drop view t1;
create view t1 as select a, 6*a as b, 7*a as c from t2;
alter view t1 as select a, 7*a as b, 8*a as c from t2;

drop table t2;
drop view t1;

create table t1(a int);
insert into t1 values (1), (2), (3);

create view v1 as select a from t1;

drop view v1;
create view v1 as select 2*a from t1;

-- Miss v1.
lock tables t1 read;

drop table t1;
drop view v1;

create table t1(a int);
insert into t1 values (1), (2), (3);

create view v1 as select a from t1;

alter view v1 as select 2*a from t1;

-- Miss v1.
lock tables t1 read;

drop table t1;
drop view v1;
create table t1 (a int);
insert into t1 (a) values (1), (2), (3);
create function f1() returns int return (select max(a) from t1);
create view v1 as select f1();
drop function f1;
create function f1() returns int return 2;

create table t2 (a int);
insert into t2 (a) values (4), (5), (6);

drop function f1;
create function f1() returns int
begin
  declare x int;
create procedure p1(out x int) select max(a) from t1 into x;
drop procedure p1;
create procedure p1(out x int) select max(a) from t2 into x;

drop view v1;
create view v2 as select a from t1;
create view v1 as select * from v2;
drop view v2;
create view v2 as select a from t2;
drop view v2;
create table v2 as select * from t1;
drop table v2;
create table v2 (a int unique) as select * from t2;
set @var= 7;
create trigger v2_bi before insert on v2 for each row set @message="v2_bi";
set @var=8;
select @message;
drop trigger v2_bi;
set @message=null;
set @var=9;
select @message;
create trigger v2_bi after insert on v2 for each row set @message="v2_ai";
set @var= 10;
select @message;
select * from v1;
drop table if exists t1, t2, v1, v2;
drop view if exists v1, v2;
drop function f1;
drop procedure p1;

-- Using a temporary table internally should not confuse the prepared
-- statement code, and should not raise ER_PS_INVALIDATED errors
prepare stmt from
 "select ROUTINE_SCHEMA, ROUTINE_NAME, ROUTINE_TYPE
 from INFORMATION_SCHEMA.ROUTINES where
 routine_name='p1'";

create procedure p1() select "hi there";

drop procedure p1;
create procedure p1() select "hi there, again";

drop procedure p1;

create table test.t1(f1 int);
insert into test.t1 values (10);

drop table test.t1;
create table test.t1(f1 int primary key, f2 int, key(f2));
insert into test.t1 values (20, 20);
insert into test.t1 values (30, 20);

drop table test.t1;

create table t1 (a int);

create algorithm=temptable view v1 as select a*a as a2 from t1;

insert into t1 values (1), (2), (3);

insert into t1 values (4), (5), (6);

drop table t1;
drop view v1;


create table t1 (a int);

drop table t1;
create table t1 (a1 int, a2 int);

alter table t1 drop column b;

alter table t1 drop column b;

drop table t1;

create procedure p1() begin end;

drop procedure p1;
create procedure p1(x int, y int) begin end;

drop procedure p1;

create function f1() returns int return 0;

drop function f1;
create function f1(x int, y int) returns int return x+y;

drop function f1;

create table t1 (a int);

create trigger t1_bi before insert on t1 for each row set @message= "t1_bi";

drop trigger t1_bi;

create trigger t1_bi before insert on t1 for each row set @message= "t1_bi (2)";

drop trigger t1_bi;

drop table t1;

create table t1 (a int);

alter table t1 add column b varchar(50) default NULL;

alter table t1 change b c int;

alter table t1 change a a varchar(10);

alter table t1 change a a varchar(20);

alter table t1 change a a varchar(20) NOT NULL;

alter table t1 change c c int DEFAULT 20;
create unique index t1_a_idx on t1 (a);

drop index t1_a_idx on t1;
create index t1_a_idx on t1 (a);
drop table t1;
drop table if exists t_27420_100;
drop table if exists t_27420_101;
drop view if exists v_27420;

create table t_27420_100(a int);
insert into t_27420_100 values (1), (2);

create table t_27420_101(a int);
insert into t_27420_101 values (1), (2);

create view v_27420 as select t_27420_100.a X, t_27420_101.a Y
  from t_27420_100, t_27420_101
  where t_27420_100.a=t_27420_101.a;

drop view v_27420;
create table v_27420(X int, Y int);

drop table v_27420;
create table v_27420 (a int, b int, filler char(200));

drop table t_27420_100;
drop table t_27420_101;
drop table v_27420;
drop table if exists t_27430_1;
drop table if exists t_27430_2;

create table t_27430_1 (a int not null, oref int not null, key(a));
insert into t_27430_1 values
  (1, 1),
  (1, 1234),
  (2, 3),
  (2, 1234),
  (3, 1234);

create table t_27430_2 (a int not null, oref int not null);
insert into t_27430_2 values
  (1, 1),
  (2, 2),
  (1234, 3),
  (1234, 4);

drop table t_27430_1, t_27430_2;

create table t_27430_1 (a int, oref int, key(a));
insert into t_27430_1 values
  (1, 1),
  (1, NULL),
  (2, 3),
  (2, NULL),
  (3, NULL);

create table t_27430_2 (a int, oref int);
insert into t_27430_2 values
  (1, 1),
  (2,2),
  (NULL, 3),
  (NULL, 4);

drop table t_27430_1;
drop table t_27430_2;
drop table if exists t_27690_1;
drop view if exists v_27690_1;
drop table if exists v_27690_2;

create table t_27690_1 (a int, b int);
insert into t_27690_1 values (1,1),(2,2);

create table v_27690_1 as select * from t_27690_1;
create table v_27690_2 as select * from t_27690_1;

drop table v_27690_1;

create view v_27690_1 as select A.a, A.b from t_27690_1 A, t_27690_1 B;

drop table t_27690_1;
drop view v_27690_1;
drop table v_27690_2;

create function f1() returns int return 10;

drop function f1;
create function f1() returns int return 10;

-- might pass or fail, implementation dependent
execute stmt;

drop function f1;
create function f1() returns int return 20;

drop function f1;
drop table if exists t_12093;
drop function if exists f_12093;
drop function if exists f_12093_unrelated;
drop procedure if exists p_12093;
drop view if exists v_12093_unrelated;

create table t_12093 (a int);
create function f_12093() returns int return (select count(*) from t_12093);
create procedure p_12093(a int) select * from t_12093;

create function f_12093_unrelated() returns int return 2;
create procedure p_12093_unrelated() begin end;
create view v_12093_unrelated as select * from t_12093;

let $my_drop = drop function f_12093_unrelated;
let $my_drop = drop procedure p_12093_unrelated;
let $my_drop = drop view v_12093_unrelated;
drop table t_12093;
drop function f_12093;
drop procedure p_12093;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;
drop table if exists t1;
drop table if exists t2;
create table t1 (a int);
drop table t2;
drop table t2;
drop table t2;
create temporary table t2 (a int);
drop temporary table t2;
drop table t2;
drop table t2;
--    We cannot print the error message because it contains a random filename.
--    Example: 1050: Table '<some_path>/var/tmp/#sql_6979_0' already exists
--    Therefore we mangle it via
--    "--error ER_TABLE_EXISTS_ERROR,9999" (9999 is currently not used)
--    to "Got one of the listed errors".
create view t2 as select 1;
drop view t2;
drop table t1;
create table t1 (x varchar(20));
select * from t2;
drop table t2;
drop table t2;
alter table t1 add column y decimal(10,3);
select * from t2;
drop table t2;
drop table t1;
create table t1 (a int);
insert into t1 (a) values (1);
drop table t2;
select * from t2;
select * from t2;
drop table t2;
create temporary table t2 (a varchar(10));
select * from t2;
drop table t1;
create table t1 (x int);
drop table t1;
drop temporary table t2;
drop table t2;

create table t1 (a int);
drop table t2;
drop table t2;
drop table t1;
create table t1 (x char(17));
drop table t2;
drop table t2;
alter table t1 add column y time;
select * from t2;
drop table t2;
drop table t1;
drop table t2;

create table t1 (a int);
create table t2 (a int);
drop table t1;
create table t1 (x int);
drop table t1, t2;

create table t1 (a int);
create table t2 (a int);
drop table t1;
create table t1 (x int);

drop table t1, t2;

create table t1 (a int);
create table t2 (a int);
drop table t1;
create table t1 (x int);
drop table t1, t2;

create table t1 (a int);
create table t2 (a int);
drop table t1;
create table t1 (x int);
drop table t1, t2;

create table t1 (a int);
create table t2 (a int);
drop table t1;
create table t1 (x int);
drop table t1, t2;

create table t1 (a int);
create table t2 (a int);
drop table t1;
create table t1 (x int);
drop table t1, t2;

create table t1 (a int);
create table t2 (a int);
create table t3 (a int);
drop table t1;
create table t1 (x int);
drop table t1, t2, t3;

create table t1 (a int);
create table t2 (a int);
create table t3 (a int);
drop table t1;
create table t1 (x int);
drop table t1, t2, t3;

create table t1 (a varchar(20));
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;
create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;

create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;
drop table if exists t1;
drop procedure if exists p1;
create procedure p1(a int) begin end;
create table t1 (a int);
drop table t1;
create table t1 (x int);
drop table t1;
drop procedure p1;
drop table if exists t1;
drop view if exists v1;
create table t1 (a int);
drop view v1;
drop table t1;
create table t1 (x int);
drop view v1;
drop table t1;

create view v1 as select 1;
drop view v1;
drop temporary table if exists t1, t2, t3;
drop table if exists t1, t2, t3, v1, v2;
drop procedure if exists p_verify_reprepare_count;
drop procedure if exists p1;
drop function if exists f1;
drop view if exists v1, v2;
CREATE TABLE t1 (a INT);
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW
  SET @a:= (SELECT COUNT(*) FROM t1);
CREATE TEMPORARY TABLE t1 (b int);
DROP TEMPORARY TABLE t1;
DROP TABLE t1;
CREATE TEMPORARY TABLE t1 (i INT);
DROP TEMPORARY TABLE tm;
DROP TEMPORARY TABLES tm, t1;
