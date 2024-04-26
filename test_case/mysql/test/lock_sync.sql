
-- We need InnoDB to be able use TL_WRITE_ALLOW_WRITE type of locks in our tests.
-- This test requires statement/mixed mode binary logging.
-- Row-based mode puts weaker serializability requirements
-- so weaker locks are acquired for it.
--source include/have_binlog_format_mixed_or_statement.inc

-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc


--echo --
--echo -- Test how we handle locking in various cases when
--echo -- we read data from MyISAM tables.
--echo --
--echo -- In this test we mostly check that the SQL-layer correctly
--echo -- determines the type of thr_lock.c lock for a table being
--echo -- read.
--echo -- I.e. that it disallows concurrent inserts when the statement
--echo -- is going to be written to the binary log and therefore
--echo -- should be serialized, and allows concurrent inserts when
--echo -- such serialization is not necessary (e.g. when 
--echo -- the statement is not written to binary log).
--echo --

--echo -- Force concurrent inserts to be performed even if the table
--echo -- has gaps. This allows to simplify clean up in scripts
--echo -- used below (instead of backing up table being inserted
--echo -- into and then restoring it from backup at the end of the
--echo -- script we can simply delete rows which were inserted).
set @old_concurrent_insert= @@global.concurrent_insert;
set @@global.concurrent_insert= 2;
select @@global.concurrent_insert;
drop table if exists t0, t1, t2, t3, t4, t5;
drop view if exists v1, v2;
drop procedure if exists p1;
drop procedure if exists p2;
drop procedure if exists p3;
drop function if exists f1;
drop function if exists f2;
drop function if exists f3;
drop function if exists f4;
drop function if exists f5;
drop function if exists f6;
drop function if exists f7;
drop function if exists f8;
drop function if exists f9;
drop function if exists f10;
drop function if exists f11;
drop function if exists f12;
drop function if exists f13;
drop function if exists f14;
drop function if exists f15;
drop function if exists f16;
drop function if exists f17;
create table t1 (i int primary key);
insert into t1 values (1), (2), (3), (4), (5);
create table t2 (j int primary key);
insert into t2 values (1), (2), (3), (4), (5);
create table t3 (k int primary key);
insert into t3 values (1), (2), (3);
create table t4 (l int primary key);
insert into t4 values (1);
create table t5 (l int primary key);
insert into t5 values (1);
create view v1 as select i from t1;
create view v2 as select j from t2 where j in (select i from t1);
create procedure p1(k int) insert into t2 values (k);
create function f1() returns int
begin
  declare j int;
  select i from t1 where i = 1 into j;
create function f2() returns int
begin
  declare k int;
  select i from t1 where i = 1 into k;
  insert into t2 values (k + 5);
create function f3() returns int
begin
  return (select i from t1 where i = 3);
create function f4() returns int
begin
  if (select i from t1 where i = 3) then
    return 1;
    return 0;
  end if;
create function f5() returns int
begin
  insert into t2 values ((select i from t1 where i = 1) + 5);
create function f6() returns int
begin
  declare k int;
  select i from v1 where i = 1 into k;
create function f7() returns int
begin
  declare k int;
  select j from v2 where j = 1 into k;
create function f8() returns int
begin
  declare k int;
  select i from v1 where i = 1 into k;
  insert into t2 values (k+5);
create function f9() returns int
begin
  update v2 set j=j+10 where j=1;
create function f10() returns int
begin
  return f1();
create function f11() returns int
begin
  declare k int;
  set k= f1();
  insert into t2 values (k+5);
create function f12(p int) returns int
begin
  insert into t2 values (p);
create function f13(p int) returns int
begin
  return p;
create procedure p2(inout p int)
begin
  select i from t1 where i = 1 into p;
create function f14() returns int
begin
  declare k int;
  insert into t2 values (k+5);
create function f15() returns int
begin
  declare k int;
create function f16() returns int
begin
  create temporary table if not exists temp1 (a int);
  insert into temp1 select * from t1;
  drop temporary table temp1;
create function f17() returns int
begin
  declare j int;
  select i from t1 where i = 1 into j;
create procedure p3()
begin
  create temporary table if not exists temp1 (a int);
  insert into temp1 select * from t1;
  drop temporary table temp1;
create trigger t4_bi before insert on t4 for each row
begin
  declare k int;
  select i from t1 where i=1 into k;
  set new.l= k+1;
create trigger t4_bu before update on t4 for each row
begin
  if (select i from t1 where i=1) then
    set new.l= 2;
  end if;
create trigger t4_bd before delete on t4 for each row
begin
  if !(select i from v1 where i=1) then
    signal sqlstate '45000';
  end if;
create trigger t5_bi before insert on t5 for each row
begin
  set new.l= f1()+1;
create trigger t5_bu before update on t5 for each row
begin
  declare j int;
  set new.l= j + 1;
let $con_aux1= con1;
let $con_aux2= con2;
let $table= t1;
let $statement= select * from t1;
let $restore_table= ;
let $statement= update t2, t1 set j= j - 1 where i = j;
let $restore_table= t2;
let $statement= delete t2 from t1, t2 where i = j;
let $restore_table= t2;
let $statement= call p1((select i + 5 from t1 where i = 1));
let $restore_table= t2;
let $statement= create table t0 select * from t1;
let $restore_table= ;
drop table t0;
let $statement= create table t0 select j from t2 where j in (select i from t1);
let $restore_table= ;
drop table t0;
let $statement= delete from t2 where j in (select i from t1);
let $restore_table= t2;
let $statement= delete t2 from t3, t2 where k = j and j in (select i from t1);
let $restore_table= t2;
let $statement= do (select i from t1 where i = 1);
let $restore_table= ;
let $statement= insert into t2 select i+5 from t1;
let $restore_table= t2;
let $statement= insert into t2 values ((select i+5 from t1 where i = 4));
let $restore_table= t2;
let $statement= load data infile '../../std_data/rpl_loaddata.dat' into table t2 (@a, @b) set j= @b + (select i from t1 where i = 1);
let $restore_table= t2;

let $statement= replace into t2 select i+5 from t1;
let $restore_table= t2;
let $statement= replace into t2 values ((select i+5 from t1 where i = 4));
let $restore_table= t2;
let $statement= select * from t2 where j in (select i from t1);
let $restore_table= ;
let $statement= set @a:= (select i from t1 where i = 1);
let $restore_table= ;
let $statement= show tables from test where Tables_in_test = 't2' and (select i from t1 where i = 1);
let $restore_table= ;
let $statement= show columns from t2 where (select i from t1 where i = 1);
let $restore_table= ;
let $statement= update t2 set j= j-10 where j in (select i from t1);
let $restore_table= t2;
let $statement= update t2, t3 set j= j -10 where j=k and j in (select i from t1);
let $restore_table= t2;
let $statement= select * from v1;
let $restore_table= ;
let $statement= select * from v2;
let $restore_table= ;
let $statement= select * from t2 where j in (select i from v1);
let $restore_table= ;
let $statement= select * from t3 where k in (select j from v2);
let $restore_table= ;
let $statement= update t2 set j= j-10 where j in (select i from v1);
let $restore_table= t2;
let $statement= update t3 set k= k-10 where k in (select j from v2);
let $restore_table= t2;
let $statement= update t2, v1 set j= j-10 where j = i;
let $restore_table= t2;
let $statement= update v2 set j= j-10 where j = 3;
let $restore_table= t2;
let $statement= select f1();
let $restore_table= ;
let $statement= set @a:= f1();
let $restore_table= ;
let $statement= insert into t2 values (f1() + 5);
let $restore_table= t2;
let $statement= select f2();
let $restore_table= t2;
let $statement= set @a:= f2();
let $restore_table= t2;
let $statement= select f3();
let $restore_table= ;
let $statement= set @a:= f3();
let $restore_table= ;
let $statement= select f4();
let $restore_table= ;
let $statement= set @a:= f4();
let $restore_table= ;
let $statement= insert into t2 values (f3() + 5);
let $restore_table= t2;
let $statement= insert into t2 values (f4() + 6);
let $restore_table= t2;
let $statement= select f5();
let $restore_table= t2;
let $statement= set @a:= f5();
let $restore_table= t2;
let $statement= select f6();
let $restore_table= t2;
let $statement= set @a:= f6();
let $restore_table= t2;
let $statement= select f7();
let $restore_table= t2;
let $statement= set @a:= f7();
let $restore_table= t2;
let $statement= insert into t3 values (f6() + 5);
let $restore_table= t3;
let $statement= insert into t3 values (f7() + 5);
let $restore_table= t3;
let $statement= select f8();
let $restore_table= t2;
let $statement= select f9();
let $restore_table= t2;
let $statement= select f10();
let $restore_table= ;
let $statement= insert into t2 values (f10() + 5);
let $restore_table= t2;
let $statement= select f11();
let $restore_table= t2;
let $statement= select f12((select i+10 from t1 where i=1));
let $restore_table= t2;
let $statement= insert into t2 values (f13((select i+10 from t1 where i=1)));
let $restore_table= t2;
let $statement= select f16();
let $restore_table= ;
let $statement= set @a:= f16();
let $restore_table= ;
let $statement= select f17();
let $restore_table= ;
let $statement= set @a:= f17();
let $restore_table= ;
let $statement= call p2(@a);
let $restore_table= ;
let $statement= select f14();
let $restore_table= t2;
let $statement= select f15();
let $restore_table= ;
let $statement= insert into t2 values (f15()+5);
let $restore_table= t2;
let $statement= insert into t4 values (2);
let $restore_table= t4;
let $statement= update t4 set l= 2 where l = 1;
let $restore_table= t4;
let $statement= delete from t4 where l = 1;
let $restore_table= t4;
let $statement= insert into t5 values (2);
let $restore_table= t5;
let $statement= update t5 set l= 2 where l = 1;
let $restore_table= t5;
drop function f1;
drop function f2;
drop function f3;
drop function f4;
drop function f5;
drop function f6;
drop function f7;
drop function f8;
drop function f9;
drop function f10;
drop function f11;
drop function f12;
drop function f13;
drop function f14;
drop function f15;
drop function f16;
drop function f17;
drop view v1, v2;
drop procedure p1;
drop procedure p2;
drop procedure p3;
drop table t1, t2, t3, t4, t5;

set @@global.concurrent_insert= @old_concurrent_insert;
DROP TABLE IF EXISTS t1, t2;

CREATE TABLE t1(id INT);
CREATE TABLE t2(id INT);
SELECT * FROM t1;
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for table metadata lock" 
  AND info = "ALTER TABLE t1 ADD COLUMN j INT";
INSERT INTO t2 SELECT * FROM t1;

DROP TABLE t1, t2;

CREATE EVENT e1 ON SCHEDULE EVERY 5 HOUR DO SELECT 1;
CREATE EVENT e2 ON SCHEDULE EVERY 5 HOUR DO SELECT 2;
SET DEBUG_SYNC="before_lock_dictionary_tables_takes_lock SIGNAL drop WAIT_FOR query";
SET DEBUG_SYNC="now WAIT_FOR drop";
SELECT event_name FROM information_schema.events, performance_schema.global_variables
  WHERE definer = VARIABLE_VALUE;
SET DEBUG_SYNC="now SIGNAL query";
DROP EVENT e2;
SET DEBUG_SYNC="RESET";
DROP TABLE IF EXISTS t1;
DROP VIEW IF EXISTS v1;
DROP FUNCTION IF EXISTS f1;

CREATE TABLE t1(a INT);
CREATE FUNCTION f1() RETURNS INTEGER RETURN 1;
CREATE VIEW v1 AS SELECT * FROM t1 WHERE f1() = 1;
DROP FUNCTION f1;
SET DEBUG_SYNC= 'open_tables_after_open_and_process_table SIGNAL opened WAIT_FOR dropped EXECUTE 2';
SET DEBUG_SYNC= 'now WAIT_FOR opened';
SET DEBUG_SYNC= 'now SIGNAL dropped';
SET DEBUG_SYNC= 'now WAIT_FOR opened';
let $wait_condition= SELECT COUNT(*)=1 FROM information_schema.processlist
  WHERE state= 'Waiting for table flush' AND info= 'FLUSH TABLES';
SET DEBUG_SYNC= 'now SIGNAL dropped';
SET DEBUG_SYNC= 'RESET';
DROP VIEW v1;
DROP TABLE t1;
set low_priority_updates=1;
drop table if exists t1;
drop table if exists t2;
set debug_sync='RESET';
create table t1 (a int, b int, unique key t1$a (a));
create table t2 (j int, k int);
select * from t1, t2;
set debug_sync='after_lock_tables_takes_lock SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
set low_priority_updates=1;
let $ID= `select connection_id()`;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table level lock" and id = $ID;
select * from t1;
set debug_sync='now SIGNAL go';
drop tables t1, t2;
set low_priority_updates=default;
set debug_sync='RESET';
CREATE TABLE t1 (i INT) ENGINE=InnoDB;
CREATE TABLE t2 (j INT) ENGINE=InnoDB;
SET DEBUG_SYNC="after_open_table_mdl_shared SIGNAL locked WAIT_FOR go";
SET DEBUG_SYNC="now WAIT_FOR locked";
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "RENAME TABLE t1 TO t3, t2 TO t1, t3 TO t2";
SET DEBUG_SYNC="now SIGNAL go";
SELECT * FROM t1;
SET DEBUG_SYNC="RESET";
DROP TABLES t1, t2;

CREATE TABLE t1 (fld1 INT) ENGINE=InnoDB;
SET DEBUG_SYNC= 'before_lock_tables_takes_lock SIGNAL before_thr_lock WAIT_FOR do_thr_lock EXECUTE 3';
SET DEBUG_SYNC= 'ha_admin_open_ltable SIGNAL opti_recreate WAIT_FOR opti_analyze';
SET DEBUG_SYNC= 'now WAIT_FOR before_thr_lock';
SET DEBUG_SYNC= 'now SIGNAL do_thr_lock';
SET DEBUG_SYNC= 'now WAIT_FOR before_thr_lock';
SET DEBUG_SYNC= 'now SIGNAL do_thr_lock';
SET DEBUG_SYNC= 'now WAIT_FOR opti_recreate';
SET DEBUG_SYNC= 'alter_table_inplace_after_lock_downgrade SIGNAL lock_downgraded
WAIT_FOR finish_alter';
SET DEBUG_SYNC= 'now WAIT_FOR lock_downgraded';
SET DEBUG_SYNC= 'now SIGNAL opti_analyze';
SET DEBUG_SYNC= 'now WAIT_FOR before_thr_lock';
SET DEBUG_SYNC= 'now SIGNAL finish_alter';
SET DEBUG_SYNC= 'now SIGNAL do_thr_lock';
DROP TABLE t1;
SET DEBUG_SYNC= 'RESET';
