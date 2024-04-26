

--
-- Basic triggers test
--

-- Create additional connections used through test
connect (addconroot1, localhost, root,,);

create table t1 (i int);

-- let us test some very simple trigger
create trigger trg before insert on t1 for each row set @a:=1;
set @a:=0;
select @a;
insert into t1 values (1);
select @a;
drop trigger trg;

-- let us test simple trigger reading some values 
create trigger trg before insert on t1 for each row set @a:=new.i;
insert into t1 values (123);
select @a;
drop trigger trg;

drop table t1;

-- Let us test before insert trigger
-- Such triggers can be used for setting complex default values
create table t1 (i int not null, j int);
create trigger trg before insert on t1 for each row 
begin 
  if isnull(new.j) then
    set new.j:= new.i * 10;
  end if;
insert into t1 (i) values (1)|
insert into t1 (i,j) values (2, 3)|
select * from t1|
drop trigger trg|
drop table t1|
delimiter ;

-- After insert trigger
-- Useful for aggregating data
create table t1 (i int not null primary key);
create trigger trg after insert on t1 for each row 
  set @a:= if(@a,concat(@a, ":", new.i), new.i);
set @a:="";
insert into t1 values (2),(3),(4),(5);
select @a;
drop trigger trg;
drop table t1;

-- Before update trigger
-- (In future we will achieve this via proper error handling in triggers)
create table t1 (aid int not null primary key, balance int not null default 0);
insert into t1 values (1, 1000), (2,3000);
create trigger trg before update on t1 for each row 
begin
  declare loc_err varchar(255);
  if abs(new.balance - old.balance) > 1000 then
    set new.balance:= old.balance;
    set loc_err := concat("Too big change for aid = ", new.aid);
    set @update_failed:= if(@update_failed, concat(@a, ":", loc_err), loc_err);
  end if;
set @update_failed:=""|
update t1 set balance=1500|
select @update_failed;
select * from t1|
drop trigger trg|
drop table t1|
delimiter ;

-- After update trigger
create table t1 (i int);
insert into t1 values (1),(2),(3),(4);
create trigger trg after update on t1 for each row 
  set @total_change:=@total_change + new.i - old.i;
set @total_change:=0;
update t1 set i=3;
select @total_change;
drop trigger trg;
drop table t1;

-- Before delete trigger
-- This can be used for aggregation too :)
create table t1 (i int);
insert into t1 values (1),(2),(3),(4);
create trigger trg before delete on t1 for each row 
  set @del_sum:= @del_sum + old.i;
set @del_sum:= 0;
delete from t1 where i <= 3;
select @del_sum;
drop trigger trg;
drop table t1;

-- After delete trigger. 
-- Just run out of imagination.
create table t1 (i int);
insert into t1 values (1),(2),(3),(4);
create trigger trg after delete on t1 for each row set @del:= 1;
set @del:= 0;
delete from t1 where i <> 0;
select @del;
drop trigger trg;
drop table t1;

-- Several triggers on one table
create table t1 (i int, j int);
create trigger trg1 before insert on t1 for each row 
begin
  if new.j > 10 then
    set new.j := 10;
  end if;
create trigger trg2 before update on t1 for each row 
begin
  if old.i % 2 = 0 then
    set new.j := -1;
  end if;
create trigger trg3 after update on t1 for each row 
begin
  if new.j = -1 then
    set @fired:= "Yes";
  end if;
set @fired:="";
insert into t1 values (1,2),(2,3),(3,14);
select @fired;
select * from t1;
update t1 set j= 20;
select @fired;
select * from t1;

drop trigger trg1;
drop trigger trg2;
drop trigger trg3;
drop table t1;


-- Let us test how triggers work for special forms of INSERT such as
-- REPLACE and INSERT ... ON DUPLICATE KEY UPDATE
create table t1 (id int not null primary key, data int);
create trigger t1_bi before insert on t1 for each row
  set @log:= concat(@log, "(BEFORE_INSERT: new=(id=", new.id, ", data=", new.data,"))");
create trigger t1_ai after insert on t1 for each row
  set @log:= concat(@log, "(AFTER_INSERT: new=(id=", new.id, ", data=", new.data,"))");
create trigger t1_bu before update on t1 for each row
  set @log:= concat(@log, "(BEFORE_UPDATE: old=(id=", old.id, ", data=", old.data,
                                        ") new=(id=", new.id, ", data=", new.data,"))");
create trigger t1_au after update on t1 for each row
  set @log:= concat(@log, "(AFTER_UPDATE: old=(id=", old.id, ", data=", old.data,
                                       ") new=(id=", new.id, ", data=", new.data,"))");
create trigger t1_bd before delete on t1 for each row
  set @log:= concat(@log, "(BEFORE_DELETE: old=(id=", old.id, ", data=", old.data,"))");
create trigger t1_ad after delete on t1 for each row
  set @log:= concat(@log, "(AFTER_DELETE: old=(id=", old.id, ", data=", old.data,"))");
set @log:= "";
insert into t1 values (1, 1);
select @log;
set @log:= "";
insert ignore t1 values (1, 2);
select @log;
set @log:= "";
insert into t1 (id, data) values (1, 3), (2, 2) on duplicate key update data= data + 1;
select @log;
--          not the DELETE and INSERT triggers")
-- We define REPLACE as INSERT which DELETEs old rows which conflict with
-- row being inserted. So for the first record in statement below we will
-- call before insert trigger, then delete will be executed (and both delete
-- triggers should fire). Finally after insert trigger will be called.
-- For the second record we will just call both on insert triggers.
set @log:= "";
select @log;
drop trigger t1_bd;
drop trigger t1_ad;
set @log:= "";
select @log;

-- This also drops associated triggers
drop table t1;


--
-- Let us test triggers which access other tables.
--
-- Trivial trigger which inserts data into another table
create table t1 (id int primary key, data varchar(10), fk int);
create table t2 (event varchar(100));
create table t3 (id int primary key);
create trigger t1_ai after insert on t1 for each row 
  insert into t2 values (concat("INSERT INTO t1 id=", new.id, " data='", new.data, "'"));
insert into t1 (id, data) values (1, "one"), (2, "two");
select * from t1;
select * from t2;
drop trigger t1_ai;
create trigger t1_bi before insert on t1 for each row
begin
  if exists (select id from t3 where id=new.fk) then
    insert into t2 values (concat("INSERT INTO t1 id=", new.id, " data='", new.data, "' fk=", new.fk));
    insert into t2 values (concat("INSERT INTO t1 FAILED id=", new.id, " data='", new.data, "' fk=", new.fk));
    set new.id= NULL;
  end if;
insert into t3 values (1);
insert into t1 values (4, "four", 1), (5, "five", 2);
select * from t1;
select * from t2;
drop table t1, t2, t3;
create table t1 (id int primary key, data varchar(10));
create table t2 (seq int);
insert into t2 values (10);
create function f1 () returns int return (select max(seq) from t2);
create trigger t1_bi before insert on t1 for each row
begin
  if new.id > f1() then
    set new.id:= f1();
  end if;
insert into t1 values (1, "first");
insert into t1 values (f1(), "max");
select * from t1;
drop table t1, t2;
drop function f1;
create table t1 (id int primary key, fk_t2 int);
create table t2 (id int primary key, fk_t3 int);
create table t3 (id int primary key);
insert into t1 values (1,1), (2,1), (3,2);
insert into t2 values (1,1), (2,2);
insert into t3 values (1), (2);
create trigger t3_ad after delete on t3 for each row
  delete from t2 where fk_t3=old.id;
create trigger t2_ad after delete on t2 for each row
  delete from t1 where fk_t2=old.id;
delete from t3 where id = 1;
select * from t1 left join (t2 left join t3 on t2.fk_t3 = t3.id) on t1.fk_t2 = t2.id;
drop table t1, t2, t3;
create table t1 (id int primary key, copy int);
create table t2 (id int primary key, data int);
insert into t2 values (1,1), (2,2);
create trigger t1_bi before insert on t1 for each row
  set new.copy= (select data from t2 where id = new.id);
create trigger t1_bu before update on t1 for each row
  set new.copy= (select data from t2 where id = new.id);
insert into t1 values (1,3), (2,4), (3,3);
update t1 set copy= 1 where id = 2;
select * from t1;
drop table t1, t2;

--
-- Test of wrong column specifiers in triggers
--
create table t1 (i int);
create table t3 (i int);
create trigger trg before insert on t1 for each row set @a:= old.i;
create trigger trg before delete on t1 for each row set @a:= new.i;
create trigger trg before update on t1 for each row set old.i:=1;
create trigger trg before delete on t1 for each row set new.i:=1;
create trigger trg after update on t1 for each row set new.i:=1;
create trigger trg before update on t1 for each row set new.j:=1;
create trigger trg before update on t1 for each row set @a:=old.j;


--
-- Let us test various trigger creation errors
-- Also quickly test table namespace (bug#5892/6182)
--
--error ER_NO_SUCH_TABLE
create trigger trg before insert on t2 for each row set @a:=1;

create trigger trg before insert on t1 for each row set @a:=1;
create trigger trg after insert on t1 for each row set @a:=1;
create trigger trg before insert on t3 for each row set @a:=1;
create trigger trg2 before insert on t3 for each row set @a:=1;
drop trigger trg2;
drop trigger trg;
drop trigger trg;

create view v1 as select * from t1;
create trigger trg before insert on v1 for each row set @a:=1;
drop view v1;

drop table t1;
drop table t3;

create temporary table t1 (i int);
create trigger trg before insert on t1 for each row set @a:=1;
drop table t1;



--
-- Tests for various trigger-related bugs
--

-- Test for bug #5887 "Triggers with string literals cause errors".
-- New .FRM parser was not handling escaped strings properly.
create table t1 (x1col char);
create trigger tx1 before insert on t1 for each row set new.x1col = 'x';
insert into t1 values ('y');
drop trigger tx1;
drop table t1;

--
-- Test for bug #5890 "Triggers fail for DELETE without WHERE".
-- If we are going to delete all rows in table but DELETE triggers exist
-- we should perform row-by-row deletion instead of using optimized
-- delete_all_rows() method.
--
create table t1 (i int);
insert into t1 values (1), (2);
create trigger trg1 before delete on t1 for each row set @del_before:= @del_before + old.i;
create trigger trg2 after delete on t1 for each row set @del_after:= @del_after + old.i;
set @del_before:=0, @del_after:= 0;
delete from t1;
select @del_before, @del_after;
drop trigger trg1;
drop trigger trg2;
drop table t1;

-- Test for bug #5859 "DROP TABLE does not drop triggers". Trigger should not
-- magically reappear when we recreate dropped table.
create table t1 (a int);
create trigger trg1 before insert on t1 for each row set new.a= 10;
drop table t1;
create table t1 (a int);
insert into t1 values ();
select * from t1;
drop table t1;

-- Test for bug #6559 "DROP DATABASE forgets to drop triggers". 
create database mysqltest;
use mysqltest;
create table t1 (i int);
create trigger trg1 before insert on t1 for each row set @a:= 1;
drop database mysqltest;
use test;

-- Test for bug #8791
-- "Triggers: Allowed to create triggers on a subject table in a different DB". 
create database mysqltest;
create table mysqltest.t1 (i int);
create trigger trg1 before insert on mysqltest.t1 for each row set @a:= 1;
use mysqltest;
create trigger test.trg1 before insert on t1 for each row set @a:= 1;
drop database mysqltest;
use test;


-- Test for bug #5860 "Multi-table UPDATE does not activate update triggers"
-- We will also test how delete triggers wor for multi-table DELETE.
create table t1 (i int, j int default 10, k int not null, key (k));
create table t2 (i int);
insert into t1 (i, k) values (1, 1);
insert into t2 values (1);
create trigger trg1 before update on t1 for each row set @a:= @a + new.j - old.j;
create trigger trg2 after update on t1 for each row set @b:= "Fired";
set @a:= 0, @b:= "";
update t1, t2 set j = j + 10 where t1.i = t2.i;
select @a, @b;
insert into t1 values (2, 13, 2);
insert into t2 values (2);
set @a:= 0, @b:= "";
update t1, t2 set j = j + 15 where t1.i = t2.i and t1.k >= 2;
select @a, @b;
create trigger trg3 before delete on t1 for each row set @c:= @c + old.j;
create trigger trg4 before delete on t2 for each row set @d:= @d + old.i;
create trigger trg5 after delete on t1 for each row set @e:= "After delete t1 fired";
create trigger trg6 after delete on t2 for each row set @f:= "After delete t2 fired";
set @c:= 0, @d:= 0, @e:= "", @f:= "";
delete t1, t2 from t1, t2 where t1.i = t2.i;
select @c, @d, @e, @f;
drop table t1, t2;

-- Test for bug #6812 "Triggers are not activated for INSERT ... SELECT".
-- (We also check the fact that trigger modifies some field does not affect
--  value of next record inserted).
delimiter |;
create table t1 (i int, j int default 10)|
create table t2 (i int)|
insert into t2 values (1), (2)|
create trigger trg1 before insert on t1 for each row 
begin
  if new.i = 1 then
    set new.j := 1;
  end if;
create trigger trg2 after insert on t1 for each row set @a:= 1|
set @a:= 0|
insert into t1 (i) select * from t2|
select * from t1|
select @a|
-- This also will drop triggers
drop table t1, t2|
delimiter ;

-- Test for bug #8755 "Trigger is not activated by LOAD DATA"
create table t1 (i int, j int, k int);
create trigger trg1 before insert on t1 for each row set new.k = new.i;
create trigger trg2 after insert on t1 for each row set @b:= "Fired";
set @b:="";
select *, @b from t1;
set @b:="";
select *, @b from t1;
drop table t1;

create table t1 (i int, bt int, k int, key(k));
create table t2 (i int);
insert into t1 values (1, 1, 1), (2, 2, 2);
insert into t2 values (1), (2), (3);
create trigger bi before insert on t1 for each row set @a:= new.bt;
create trigger bu before update on t1 for each row set @a:= new.bt;
create trigger bd before delete on t1 for each row set @a:= old.bt;
alter table t1 drop column bt;
insert into t1 values (3, 3);
select * from t1;
update t1 set i = 2;
select * from t1;
delete from t1;
select * from t1;
select * from t1;
insert into t1 select 3, 3;
select * from t1;
update t1, t2 set k = k + 10 where t1.i = t2.i;
select * from t1;
update t1, t2 set k = k + 10 where t1.i = t2.i and k < 2;
select * from t1;
delete t1, t2 from t1 straight_join t2 where t1.i = t2.i;
select * from t1;
delete t2, t1 from t2 straight_join t1 where t1.i = t2.i;
select * from t1;
alter table t1 add primary key (i);
drop trigger bi;
insert into t1 values (2, 4) on duplicate key update k= k + 10;
select * from t1;
select * from t1;
drop table t1, t2;

-- Test for bug #5893 "Triggers with dropped functions cause crashes"
-- Appropriate error should be reported instead of crash.
-- Also test for bug #11889 "Server crashes when dropping trigger
-- using stored routine".
create table t1 (col1 int, col2 int);
insert into t1 values (1, 2);
create function bug5893 () returns int return 5;
create trigger t1_bu before update on t1 for each row set new.col1= bug5893();
drop function bug5893;
update t1 set col2 = 4;
drop trigger t1_bu;
drop table t1;

--
-- storing and restoring parsing modes for triggers (BUG#5891)
--
set sql_mode='ansi';
create table t1 ("t1 column" int);
create trigger t1_bi before insert on t1 for each row set new."t1 column" = 5;
set sql_mode="";
insert into t1 values (0);
create trigger t1_af after insert on t1 for each row set @a=10;
insert into t1 values (0);
select * from t1;
select @a;
drop table t1;
set sql_mode="traditional";
create table t1 (a date);
insert into t1 values ('2004-01-00');
set sql_mode="";
create trigger t1_bi before insert on t1 for each row set new.a = '2004-01-00';
set sql_mode="traditional";
insert into t1 values ('2004-01-01');
select * from t1;
set sql_mode=default;
drop table t1;

-- Test for bug #12280 "Triggers: crash if flush tables"
-- FLUSH TABLES and FLUSH PRIVILEGES should be disallowed inside
-- of functions and triggers.
create table t1 (id int);
create trigger t1_ai after insert on t1 for each row reset binary logs and gtids;
create trigger t1_ai after insert on t1 for each row reset slave;
create trigger t1_ai after insert on t1 for each row flush tables with read lock;
create trigger t1_ai after insert on t1 for each row flush logs;
create trigger t1_ai after insert on t1 for each row flush status;
create trigger t1_ai after insert on t1 for each row flush user_resources;
create trigger t1_ai after insert on t1 for each row flush tables;
create trigger t1_ai after insert on t1 for each row flush privileges;

create trigger t1_ai after insert on t1 for each row call p1();
create procedure p1() flush tables;
insert into t1 values (0);

drop procedure p1;
create procedure p1() reset binary logs and gtids;
insert into t1 values (0);

drop procedure p1;
create procedure p1() reset slave;
insert into t1 values (0);

drop procedure p1;
create procedure p1() flush privileges;
insert into t1 values (0);

drop procedure p1;
create procedure p1() flush tables with read lock;
insert into t1 values (0);

drop procedure p1;
create procedure p1() flush tables;
insert into t1 values (0);

drop procedure p1;
create procedure p1() flush logs;
insert into t1 values (0);

drop procedure p1;
create procedure p1() flush status;
insert into t1 values (0);

drop procedure p1;
create procedure p1() flush user_resources;
insert into t1 values (0);

drop procedure p1;
drop table t1;

-- Test for bug #11973 "SELECT .. INTO var_name;
--                      crash on update"

create table t1 (id int, data int, username varchar(16));
insert into t1 (id, data) values (1, 0);
create trigger t1_whoupdated before update on t1 for each row
begin
  declare user varchar(32);
  select user() into user;
  set NEW.username = user;
  select count(*) from ((select 1) union (select 2)) as d1 into i;
update t1 set data = 1;
update t1 set data = 2;
drop table t1;

--
-- #11587 Trigger causes lost connection error
--

create table t1 (c1 int, c2 datetime);
create trigger tr1 before insert on t1 for each row 
begin 
  set new.c2= '2004-04-01';
  select 'hello';

insert into t1 (c1) values (1),(2),(3);
select * from t1;
create procedure bug11587(x char(16))
begin
  select "hello";
  select "hello again";

create trigger tr1 before insert on t1 for each row 
begin 
  call bug11587(new.c2);
  set new.c2= '2004-04-02';
insert into t1 (c1) values (4),(5),(6);
select * from t1;

drop procedure bug11587;
drop table t1;

-- Test for bug #11896 "Partial locking in case of recursive trigger
-- definitions". Recursion in triggers should not be allowed.
-- We also should not allow to change tables which are used in
-- statements invoking this trigger.
create table t1 (f1 integer);
create table t2 (f2 integer);
create trigger t1_ai after insert on t1
  for each row insert into t2 values (new.f1+1);
create trigger t2_ai after insert on t2
  for each row insert into t1 values (new.f2+1);
set @SAVE_SP_RECURSION_LEVELS=@@max_sp_recursion_depth;
set @@max_sp_recursion_depth=100;
insert into t1 values (1);
set @@max_sp_recursion_depth=@SAVE_SP_RECURSION_LEVELS;
select * from t1;
select * from t2;
drop trigger t1_ai;
drop trigger t2_ai;
create trigger t1_bu before update on t1
  for each row insert into t1 values (2);
insert into t1 values (1);
update t1 set f1= 10;
select * from t1;
drop trigger t1_bu;
create trigger t1_bu before update on t1
  for each row delete from t1 where f1=new.f1;
update t1 set f1= 10;
select * from t1;
drop trigger t1_bu;
create trigger t1_bi before insert on t1
  for each row set new.f1=(select sum(f1) from t1);
insert into t1 values (3);
select * from t1;
drop trigger t1_bi;
drop tables t1, t2;

-- Tests for bug #12704 "Server crashes during trigger execution".
-- If we run DML statements and CREATE TRIGGER statements concurrently
-- it may happen that trigger will be created while DML statement is
-- waiting for table lock. In this case we have to reopen tables and
-- recalculate prelocking set.
-- Unfortunately these tests rely on the order in which tables are locked
-- by statement so they are non determenistic and are disabled.
--disable_testcase BUG--0000
create table t1 (id int);
create table t2 (id int);
create table t3 (id int);
create function f1() returns int return (select max(id)+2 from t2);
create view v1 as select f1() as f;

-- Let us check that we notice trigger at all
connection addconroot1;
create trigger t1_trg before insert on t1 for each row set NEW.id:= 1;
select * from t1;

-- Check that we properly calculate new prelocking set
insert into t2 values (3);
drop trigger t1_trg;
create trigger t1_trg before insert on t1 for each row
  insert into t3 values (new.id);
select * from t1;
select * from t3;

-- We should be able to do this even if fancy views are involved
connection addconroot1;
drop trigger t1_trg;
create trigger t1_trg before insert on t1 for each row
  insert into t3 values (new.id + 100);
select * from t1;
select * from t3;

-- This also should work for multi-update
-- Let us drop trigger to demonstrate that prelocking set is really
-- rebuilt
drop trigger t1_trg;
create trigger t1_trg before update on t1 for each row
  insert into t3 values (new.id);
select * from t1;
select * from t3;

-- And even for multi-update converted from ordinary update thanks to view
drop view v1;
drop trigger t1_trg;
create view v1 as select t1.id as id1 from t1, t2 where t1.id= t2.id;
insert into t2 values (10);
create trigger t1_trg before update on t1 for each row
  insert into t3 values (new.id + 100);
select * from t1;
select * from t3;

drop function f1;
drop view v1;
drop table t1, t2, t3;

--
-- Test for bug #13399 "Crash when executing PS/SP which should activate
-- trigger which is now dropped". See also test for similar bug for stored
-- routines in sp-error.test (#12329).
create table t1 (id int);
create table t2 (id int);
create trigger t1_bi before insert on t1 for each row insert into t2 values (new.id);
create procedure p1() insert into t1 values (10);
drop trigger t1_bi;
drop procedure p1;

-- Let us test more complex situation when we alter trigger in such way that
-- it uses different set of tables (or simply add new trigger).
create table t3 (id int);
create trigger t1_bi after insert on t1 for each row insert into t2 values (new.id);
create procedure p1() insert into t1 values (10);
drop trigger t1_bi;
create trigger t1_bi after insert on t1 for each row insert into t3 values (new.id);
drop procedure p1;
drop table t1, t2, t3;

--
-- BUG#13549 "Server crash with nested stored procedures".
-- Server should not crash when during execution of stored procedure
-- we have to parse trigger/function definition and this new trigger/
-- function has more local variables declared than invoking stored
-- procedure and last of these variables is used in argument of NOT
-- operator.
--
create table t1 (a int);
CREATE PROCEDURE `p1`()
begin
  insert into t1 values (1);
create trigger trg before insert on t1 for each row 
begin 
  declare done int default 0;
  set done= not done;
drop procedure p1;
drop table t1;

--
-- Test for bug #14863 "Triggers: crash if create and there is no current
-- database". We should not crash and give proper error when database for
-- trigger or its table is not specified and there is no current database.
--
connection addconwithoutdb;
create trigger t1_bi before insert on test.t1 for each row set @a:=0;
create trigger test.t1_bi before insert on t1 for each row set @a:=0;
drop trigger t1_bi;

--
-- Tests for bug #13525 "Rename table does not keep info of triggers"
-- and bug #17866 "Problem with renaming table with triggers with fully
-- qualified subject table".
--
create table t1 (id int);
create trigger t1_bi before insert on t1 for each row set @a:=new.id;
create trigger t1_ai after insert on test.t1 for each row set @b:=new.id;
insert into t1 values (101);
select @a, @b;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test';
insert into t2 values (102);
select @a, @b;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test';
alter table t2 rename to t3;
insert into t3 values (103);
select @a, @b;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test';
alter table t3 rename to t4, add column val int default 0;
insert into t4 values (104, 1);
select @a, @b;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test';
drop trigger t1_bi;
drop trigger t1_ai;
drop table t4;
create database mysqltest;
use mysqltest;
create table t1 (id int);
create trigger t1_bi before insert on t1 for each row set @a:=new.id;
insert into t1 values (101);
select @a;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test' or event_object_schema = 'mysqltest';
insert into t1 values (102);
select @a;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test' or event_object_schema = 'mysqltest';
drop trigger test.t1_bi;
alter table t1 rename to test.t1;
insert into t1 values (103);
select @a;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test' or event_object_schema = 'mysqltest';
drop trigger test.t1_bi;
alter table t1 rename to test.t1, add column val int default 0;
insert into t1 values (104);
select @a;
select trigger_schema, trigger_name, event_object_schema,
       event_object_table, action_statement from information_schema.triggers
       where event_object_schema = 'test' or event_object_schema = 'mysqltest';
drop trigger test.t1_bi;
drop trigger t1_bi;
drop table t1;
drop database mysqltest;
use test;

-- Test for bug #16829 "Firing trigger with RETURN crashes the server"
-- RETURN is not supposed to be used anywhere except functions, so error
-- should be returned when one attempts to create trigger with RETURN.
create table t1 (i int);
create trigger t1_bi before insert on t1 for each row return 0;
insert into t1 values (1);
drop table t1;

-- Test for bug #17764 "Trigger crashes table"
--
-- Table was reported as crashed when it was subject table of trigger invoked
-- by insert statement which was executed with enabled bulk insert mode (which
-- is actually set of optimizations enabled by handler::start_bulk_insert())
-- and this trigger also explicitly referenced it.
-- The same problem arose when table to which bulk insert was done was also
-- referenced in function called by insert statement.
create table t1 (a varchar(64), b int);
create table t2 like t1;
create trigger t1_ai after insert on t1 for each row
  set @a:= (select max(a) from t1);
insert into t1 (a) values
  ("Twas"),("brillig"),("and"),("the"),("slithy"),("toves"),
  ("Did"),("gyre"),("and"),("gimble"),("in"),("the"),("wabe");
create trigger t2_ai after insert on t2 for each row
  set @a:= (select max(a) from t2);
insert into t2 select * from t1;
drop trigger t1_ai;
drop trigger t2_ai;
create function f1() returns int return (select max(b) from t1);
insert into t1 values
  ("All",f1()),("mimsy",f1()),("were",f1()),("the",f1()),("borogoves",f1()),
  ("And",f1()),("the",f1()),("mome", f1()),("raths",f1()),("outgrabe",f1());
create function f2() returns int return (select max(b) from t2);
insert into t2 select a, f2() from t1;
drop function f1;
drop function f2;
drop table t1, t2;

--
-- Test for bug #16021 "Wrong index given to function in trigger" which
-- was caused by the same bulk insert optimization as bug #17764 but had
-- slightly different symptoms (instead of reporting table as crashed
-- storage engine reported error number 124)
--
create table t1(i int not null, j int not null, n numeric(15,2), primary key(i,j));
create table t2(i int not null, n numeric(15,2), primary key(i));
create trigger t1_ai after insert on t1 for each row
begin
  declare sn numeric(15,2);
  select sum(n) into sn from t1 where i=new.i;
insert into t1 values
  (1,1,10.00),(1,2,10.00),(1,3,10.00),(1,4,10.00),(1,5,10.00),
  (1,6,10.00),(1,7,10.00),(1,8,10.00),(1,9,10.00),(1,10,10.00),
  (1,11,10.00),(1,12,10.00),(1,13,10.00),(1,14,10.00),(1,15,10.00);
select * from t1;
select * from t2;
drop tables t1, t2;

--
-- Test for Bug #16461 connection_id() does not work properly inside trigger
--
CREATE TABLE t1 (
    conn_id INT,
    trigger_conn_id INT
);
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW
  SET NEW.trigger_conn_id = CONNECTION_ID();

INSERT INTO t1 (conn_id, trigger_conn_id) VALUES (CONNECTION_ID(), -1);
INSERT INTO t1 (conn_id, trigger_conn_id) VALUES (CONNECTION_ID(), -1);

SELECT * FROM t1 WHERE conn_id != trigger_conn_id;

DROP TRIGGER t1_bi;
DROP TABLE t1;


--
-- Bug#6951: Triggers/Traditional: SET @ result wrong
--

CREATE TABLE t1 (i1 INT);

SET @save_sql_mode=@@sql_mode;

SET SQL_MODE='';

CREATE TRIGGER t1_ai AFTER INSERT ON t1 FOR EACH ROW
  SET @x = 5/0;

SET SQL_MODE='traditional';

CREATE TRIGGER t1_au AFTER UPDATE ON t1 FOR EACH ROW
  SET @x = 5/0;

SET @x=1;
INSERT INTO t1 VALUES (@x);
SELECT @x;

SET @x=2;
UPDATE t1 SET i1 = @x;
SELECT @x;

SET SQL_MODE='';

SET @x=3;
INSERT INTO t1 VALUES (@x);
SELECT @x;

SET @x=4;
UPDATE t1 SET i1 = @x;
SELECT @x;

SET @@sql_mode=@save_sql_mode;

DROP TRIGGER t1_ai;
DROP TRIGGER t1_au;
DROP TABLE t1;


--
-- Test for bug #14635 Accept NEW.x as INOUT parameters to stored
-- procedures from within triggers
--
--disable_warnings
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;

CREATE TABLE t1 (i1 INT);

-- Check that NEW.x pseudo variable is accepted as INOUT and OUT
-- parameter to stored routine.
INSERT INTO t1 VALUES (3);
CREATE PROCEDURE p1(OUT i1 INT) DETERMINISTIC NO SQL SET i1 = 5;
CREATE PROCEDURE p2(INOUT i1 INT) DETERMINISTIC NO SQL SET i1 = i1 * 7;
CREATE TRIGGER t1_bu BEFORE UPDATE ON t1 FOR EACH ROW
BEGIN
  CALL p1(NEW.i1);
UPDATE t1 SET i1 = 11 WHERE i1 = 3;
DROP TRIGGER t1_bu;
DROP PROCEDURE p2;
DROP PROCEDURE p1;

-- Check that OLD.x pseudo variable is not accepted as INOUT and OUT
-- parameter to stored routine.
INSERT INTO t1 VALUES (13);
CREATE PROCEDURE p1(OUT i1 INT) DETERMINISTIC NO SQL SET @a = 17;
CREATE TRIGGER t1_bu BEFORE UPDATE ON t1 FOR EACH ROW
  CALL p1(OLD.i1);
UPDATE t1 SET i1 = 19 WHERE i1 = 13;
DROP TRIGGER t1_bu;
DROP PROCEDURE p1;

INSERT INTO t1 VALUES (23);
CREATE PROCEDURE p1(INOUT i1 INT) DETERMINISTIC NO SQL SET @a = i1 * 29;
CREATE TRIGGER t1_bu BEFORE UPDATE ON t1 FOR EACH ROW
  CALL p1(OLD.i1);
UPDATE t1 SET i1 = 31 WHERE i1 = 23;
DROP TRIGGER t1_bu;
DROP PROCEDURE p1;

-- Check that NEW.x pseudo variable is read-only in the AFTER TRIGGER.
INSERT INTO t1 VALUES (37);
CREATE PROCEDURE p1(OUT i1 INT) DETERMINISTIC NO SQL SET @a = 41;
CREATE TRIGGER t1_au AFTER UPDATE ON t1 FOR EACH ROW
  CALL p1(NEW.i1);
UPDATE t1 SET i1 = 43 WHERE i1 = 37;
DROP TRIGGER t1_au;
DROP PROCEDURE p1;

INSERT INTO t1 VALUES (47);
CREATE PROCEDURE p1(INOUT i1 INT) DETERMINISTIC NO SQL SET @a = i1 * 49;
CREATE TRIGGER t1_au AFTER UPDATE ON t1 FOR EACH ROW
  CALL p1(NEW.i1);
UPDATE t1 SET i1 = 51 WHERE i1 = 47;
DROP TRIGGER t1_au;
DROP PROCEDURE p1;

-- Post requisite.
SELECT * FROM t1;

DROP TABLE t1;

--
-- Bug #18005: Creating a trigger on mysql.event leads to server crash on
-- scheduler startup
--
-- Bug #18361: Triggers on mysql.user table cause server crash
--
-- We don't allow triggers on the mysql schema
delimiter |;
create trigger wont_work after update on mysql.user for each row
begin
 set @a:= 1;
use mysql|
--error ER_NO_TRIGGERS_ON_SYSTEM_SCHEMA
create trigger wont_work after update on event for each row
begin
 set @a:= 1;
use test|
delimiter ;


--
-- Test for BUG#16899: Possible buffer overflow in handling of DEFINER-clause.
--

-- Prepare.

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;

CREATE TABLE t1(c INT);
CREATE TABLE t2(c INT);
CREATE DEFINER=1234567890abcdefGHIKL1234567890abcdefGHIKL@localhost
  TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW SET @a = 1;
CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890X
  TRIGGER t2_bi BEFORE INSERT ON t2 FOR EACH ROW SET @a = 2;

-- Cleanup.

DROP TABLE t1;
DROP TABLE t2;

--
-- Bug#20028 Function with select return no data
-- 

--disable_warnings
drop table if exists t1;
drop table if exists t2;
drop table if exists t3;
drop table if exists t4;

SET @save_sql_mode=@@sql_mode;
SET sql_mode='TRADITIONAL'|
create table t1 (id int(10) not null primary key, v int(10) )|
create table t2 (id int(10) not null primary key, v int(10) )|
create table t3 (id int(10) not null primary key, v int(10) )|
create table t4 (c int)|

create trigger t4_bi before insert on t4 for each row set @t4_bi_called:=1|
create trigger t4_bu before update on t4 for each row set @t4_bu_called:=1|

insert into t1 values(10, 10)|
set @a:=1/0|
select 1/0 from t1|

create trigger t1_bi before insert on t1 for each row set @a:=1/0|

insert into t1 values(20, 20)|

drop trigger t1_bi|
create trigger t1_bi before insert on t1 for each row
begin
  insert into t2 values (new.id, new.v);
  update t2 set v=v+1 where id= new.id;
  update t2, t3 set t2.v=new.v, t3.v=new.v where t2.id=t3.id;
  create temporary table t5 select * from t1;
  delete from t5;
  insert into t5 select * from t1;
  insert into t4 values (0);
  set @check= (select count(*) from t5);
  update t4 set c= @check;
  drop temporary table t5;

  set @a:=1/0;

set @check=0, @t4_bi_called=0, @t4_bu_called=0|
insert into t1 values(30, 30)|
select @check, @t4_bi_called, @t4_bu_called|

delimiter ;

SET @@sql_mode=@save_sql_mode;

drop table t1;
drop table t2;
drop table t3;
drop table t4;

--
-- Bug#20670 "UPDATE using key and invoking trigger that modifies
--            this key does not stop"
--

create table t1 (i int, j int key);
insert into t1 values (1,1), (2,2), (3,3);
create trigger t1_bu before update on t1 for each row
  set new.j = new.j + 10;
update t1 set i= i+ 10 where j > 2;
select * from t1;
drop table t1;

--
-- Bug#23556 TRUNCATE TABLE still maps to DELETE
--
CREATE TABLE t1 (a INT PRIMARY KEY);
CREATE TABLE t2 (a INT PRIMARY KEY);
INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8);

CREATE TRIGGER trg_t1 BEFORE DELETE on t1 FOR EACH ROW 
  INSERT INTO t2 VALUES (OLD.a);
SELECT COUNT(*) FROM t2;

INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8);
DELETE FROM t2;
DELETE FROM t1;
SELECT COUNT(*) FROM t2;

DROP TRIGGER trg_t1;
DROP TABLE t1,t2;

--
-- Bug #23651 "Server crashes when trigger which uses stored function
--             invoked from different connections".
--
--disable_warnings
drop table if exists t1;
drop function if exists f1;
create table t1 (i int);
create function f1() returns int return 10;
create trigger t1_bi before insert on t1 for each row set @a:= f1() + 10;
insert into t1 values ();
select @a;
insert into t1 values ();
select @a;
drop table t1;
drop function f1;

--
-- Bug#23703: DROP TRIGGER needs an IF EXISTS
--

create table t1(a int, b varchar(50));

-- error ER_TRG_DOES_NOT_EXIST
drop trigger not_a_trigger;

drop trigger if exists not_a_trigger;

create trigger t1_bi before insert on t1
for each row set NEW.b := "In trigger t1_bi";

insert into t1 values (1, "a");
drop trigger if exists t1_bi;
insert into t1 values (2, "b");
drop trigger if exists t1_bi;
insert into t1 values (3, "c");

select * from t1;

drop table t1;

--
-- Bug#25398: crash when a trigger contains a SELECT with 
--            trigger fields in the select list under DISTINCT
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 (
  id int NOT NULL DEFAULT '0',
  a  varchar(10) NOT NULL,
  b  varchar(10),
  c  varchar(10),
  d  timestamp NOT NULL,
  PRIMARY KEY (id, a)
);

CREATE TABLE t2 (
  fubar_id         int unsigned NOT NULL DEFAULT '0',
  last_change_time datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY  (fubar_id)
);

CREATE TRIGGER fubar_change
  AFTER UPDATE ON t1
    FOR EACH ROW
      BEGIN
        INSERT INTO t2 (fubar_id, last_change_time)
          SELECT DISTINCT NEW.id AS fubar_id, NOW() AS last_change_time
            FROM t1 WHERE (id = NEW.id) AND (OLD.c != NEW.c)
        ON DUPLICATE KEY UPDATE
          last_change_time =
            IF((fubar_id = NEW.id)AND(OLD.c != NEW.c),NOW(),last_change_time);
      END
|

DELIMITER ;

INSERT INTO t1 (id,a, b,c,d) VALUES
 (1,'a','b','c',now()),(2,'a','b','c',now());

UPDATE t1 SET c='Bang!' WHERE id=1;

SELECT fubar_id FROM t2;

DROP TABLE t1,t2;
SET sql_mode = default;
--           trigger for inserting)
--

--disable_warnings
DROP TABLE IF EXISTS bug21825_A;
DROP TABLE IF EXISTS bug21825_B;

CREATE TABLE bug21825_A (id int(10));
CREATE TABLE bug21825_B (id int(10));

CREATE TRIGGER trgA AFTER INSERT ON bug21825_A
FOR EACH ROW
BEGIN
  INSERT INTO bug21825_B (id) values (1);

INSERT INTO bug21825_A (id) VALUES (10);
INSERT INTO bug21825_A (id) VALUES (20);

DROP TABLE bug21825_B;

-- Must pass, the missing table in the insert trigger should not matter.
DELETE FROM bug21825_A WHERE id = 20;

DROP TABLE bug21825_A;

--
-- Bug#22580 (DROP TABLE in nested stored procedure causes strange dependancy
-- error)
--

--disable_warnings
DROP TABLE IF EXISTS bug22580_t1;
DROP PROCEDURE IF EXISTS bug22580_proc_1;
DROP PROCEDURE IF EXISTS bug22580_proc_2;

CREATE TABLE bug22580_t1 (a INT, b INT);

CREATE PROCEDURE bug22580_proc_2()
BEGIN
  DROP TABLE IF EXISTS bug22580_tmp;
  CREATE TEMPORARY TABLE bug22580_tmp (a INT);
  DROP TABLE bug22580_tmp;

CREATE PROCEDURE bug22580_proc_1()
BEGIN
  CALL bug22580_proc_2();

CREATE TRIGGER t1bu BEFORE UPDATE ON bug22580_t1
FOR EACH ROW 
BEGIN
  CALL bug22580_proc_1();

-- Must pass, the actions of the update trigger should not matter
INSERT INTO bug22580_t1 VALUES (1,1);

DROP TABLE bug22580_t1;
DROP PROCEDURE bug22580_proc_1;
DROP PROCEDURE bug22580_proc_2;

--
-- Bug#27006: AFTER UPDATE triggers not fired with INSERT ... ON DUPLICATE
--
--disable_warnings
DROP TRIGGER IF EXISTS trg27006_a_update;
DROP TRIGGER IF EXISTS trg27006_a_insert;

CREATE TABLE t1 (
  `id` int(10) unsigned NOT NULL auto_increment,
  `val` varchar(10) NOT NULL,
  PRIMARY KEY  (`id`)
);
CREATE TABLE t2 like t1;

CREATE TRIGGER trg27006_a_insert AFTER INSERT ON t1 FOR EACH ROW
BEGIN
    insert into t2 values (NULL,new.val);
END |
CREATE TRIGGER trg27006_a_update AFTER UPDATE ON t1 FOR EACH ROW
BEGIN
    insert into t2 values (NULL,new.val);
END |
DELIMITER ;

INSERT INTO t1(val) VALUES ('test1'),('test2');
SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t1 VALUES (2,'test2') ON DUPLICATE KEY UPDATE val=VALUES(val);
INSERT INTO t1 VALUES (2,'test3') ON DUPLICATE KEY UPDATE val=VALUES(val);
INSERT INTO t1 VALUES (3,'test4') ON DUPLICATE KEY UPDATE val=VALUES(val);
SELECT * FROM t1;
SELECT * FROM t2;
DROP TRIGGER trg27006_a_insert;
DROP TRIGGER trg27006_a_update;
drop table t1,t2;

--
-- Bug #20903 "Crash when using CREATE TABLE .. SELECT and triggers"
--

create table t1 (i int);
create trigger t1_bi before insert on t1 for each row set new.i = 7;
create trigger t1_ai after insert on t1 for each row set @a := 7;
create table t2 (j int);
insert into t2 values (1), (2);
set @a:="";
insert into t1 select * from t2;
select * from t1;
select @a;
drop trigger t1_bi;
drop trigger t1_ai;
create table t3 (isave int);
create trigger t1_bi before insert on t1 for each row insert into t3 values (new.i);
insert into t1 select * from t2;
select * from t1;
select * from t3;
drop table t1, t2, t3;
drop table if exists t1, t2;
drop trigger if exists trg_bug28502_au;

create table t1 (id int, count int);
create table t2 (id int);

create trigger trg_bug28502_au before update on t2
for each row
begin
  if (new.id is not null) then
    update t1 set count= count + 1 where id = old.id;
  end if;
insert into t1 (id, count) values (1, 0);
insert into t2 set id=1;
update t2 set id=1 where id=1;
select * from t1;
select * from t2;
drop table t1, t2;
drop table if exists t1, t2, t1_op_log;
drop view if exists v1;
drop trigger if exists trg_bug28502_bi;
drop trigger if exists trg_bug28502_ai;
drop trigger if exists trg_bug28502_bu;
drop trigger if exists trg_bug28502_au;
drop trigger if exists trg_bug28502_bd;
drop trigger if exists trg_bug28502_ad;
create table t1 (id int primary key auto_increment, operation varchar(255));
create table t2 (id int primary key);
create table t1_op_log(operation varchar(255));
create view v1 as select * from t1;
create trigger trg_bug28502_bi before insert on t1
for each row
  insert into t1_op_log (operation)
  values (concat("Before INSERT, new=", new.operation));

create trigger trg_bug28502_ai after insert on t1
for each row
  insert into t1_op_log (operation)
  values (concat("After INSERT, new=", new.operation));

create trigger trg_bug28502_bu before update on t1
for each row
  insert into t1_op_log (operation)
  values (concat("Before UPDATE, new=", new.operation,
                 ", old=", old.operation));

create trigger trg_bug28502_au after update on t1
for each row
  insert into t1_op_log (operation)
  values (concat("After UPDATE, new=", new.operation,
                 ", old=", old.operation));

create trigger trg_bug28502_bd before delete on t1
for each row
  insert into t1_op_log (operation)
  values (concat("Before DELETE, old=", old.operation));

create trigger trg_bug28502_ad after delete on t1
for each row
  insert into t1_op_log (operation)
  values (concat("After DELETE, old=", old.operation));

insert into t1 (operation) values ("INSERT");

set @id=last_insert_id();

select * from t1;
select * from t1_op_log;

update t1 set operation="UPDATE" where id=@id;

select * from t1;
select * from t1_op_log;

delete from t1 where id=@id;

select * from t1;
select * from t1_op_log;

insert into t1 (id, operation) values
(NULL, "INSERT ON DUPLICATE KEY UPDATE, inserting a new key")
on duplicate key update id=NULL, operation="Should never happen";

set @id=last_insert_id();

select * from t1;
select * from t1_op_log;

insert into t1 (id, operation) values
(@id, "INSERT ON DUPLICATE KEY UPDATE, the key value is the same")
on duplicate key update id=NULL,
operation="INSERT ON DUPLICATE KEY UPDATE, updating the duplicate";

select * from t1;
select * from t1_op_log;

set @id=last_insert_id();

select * from t1;
select * from t1_op_log;

select * from t1;
select * from t1_op_log;

insert into t1
select NULL, "CREATE TABLE ... SELECT, inserting a new key";

set @id=last_insert_id();

select * from t1;
select * from t1_op_log;
select @id, "CREATE TABLE ... REPLACE SELECT, deleting a duplicate key";

select * from t1;
select * from t1_op_log;

insert into t1 (id, operation)
select NULL, "INSERT ... SELECT, inserting a new key";

set @id=last_insert_id();

select * from t1;
select * from t1_op_log;

insert into t1 (id, operation)
select @id,
"INSERT ... SELECT ... ON DUPLICATE KEY UPDATE, updating a duplicate"
on duplicate key update id=NULL,
operation="INSERT ... SELECT ... ON DUPLICATE KEY UPDATE, updating a duplicate";

select * from t1;
select * from t1_op_log;
select NULL, "REPLACE ... SELECT, inserting a new key";

set @id=last_insert_id();

select * from t1;
select * from t1_op_log;
select @id, "REPLACE ... SELECT, deleting a duplicate";

select * from t1;
select * from t1_op_log;

insert into t1 (id, operation) values (1, "INSERT for multi-DELETE");
insert into t2 (id) values (1);

delete t1.*, t2.* from t1, t2 where t1.id=1;

select * from t1;
select * from t2;
select * from t1_op_log;

insert into t1 (id, operation) values (1, "INSERT for multi-UPDATE");
insert into t2 (id) values (1);
update t1, t2 set t1.id=2, operation="multi-UPDATE" where t1.id=1;
update t1, t2
set t2.id=3, operation="multi-UPDATE, SET for t2, but the trigger is fired" where t1.id=2;

select * from t1;
select * from t2;
select * from t1_op_log;

insert into v1 (operation) values ("INSERT");

set @id=last_insert_id();

select * from t1;
select * from t1_op_log;

update v1 set operation="UPDATE" where id=@id;

select * from t1;
select * from t1_op_log;

delete from v1 where id=@id;

select * from t1;
select * from t1_op_log;

insert into v1 (id, operation) values
(NULL, "INSERT ON DUPLICATE KEY UPDATE, inserting a new key")
on duplicate key update id=NULL, operation="Should never happen";

set @id=last_insert_id();

select * from t1;
select * from t1_op_log;

insert into v1 (id, operation) values
(@id, "INSERT ON DUPLICATE KEY UPDATE, the key value is the same")
on duplicate key update id=NULL,
operation="INSERT ON DUPLICATE KEY UPDATE, updating the duplicate";

select * from t1;
select * from t1_op_log;

set @id=last_insert_id();

select * from t1;
select * from t1_op_log;

select * from t1;
select * from t1_op_log;

insert into v1
select NULL, "CREATE TABLE ... SELECT, inserting a new key";

set @id=last_insert_id();

select * from t1;
select * from t1_op_log;
select @id, "CREATE TABLE ... REPLACE SELECT, deleting a duplicate key";

select * from t1;
select * from t1_op_log;

insert into v1 (id, operation)
select NULL, "INSERT ... SELECT, inserting a new key";

set @id=last_insert_id();

select * from t1;
select * from t1_op_log;

insert into v1 (id, operation)
select @id,
"INSERT ... SELECT ... ON DUPLICATE KEY UPDATE, updating a duplicate"
on duplicate key update id=NULL,
operation="INSERT ... SELECT ... ON DUPLICATE KEY UPDATE, updating a duplicate";

select * from t1;
select * from t1_op_log;
select NULL, "REPLACE ... SELECT, inserting a new key";

set @id=last_insert_id();

select * from t1;
select * from t1_op_log;
select @id, "REPLACE ... SELECT, deleting a duplicate";

select * from t1;
select * from t1_op_log;

insert into v1 (id, operation) values (1, "INSERT for multi-DELETE");
insert into t2 (id) values (1);

delete v1.*, t2.* from v1, t2 where v1.id=1;

select * from t1;
select * from t2;
select * from t1_op_log;

insert into v1 (id, operation) values (1, "INSERT for multi-UPDATE");
insert into t2 (id) values (1);
update v1, t2 set v1.id=2, operation="multi-UPDATE" where v1.id=1;
update v1, t2
set t2.id=3, operation="multi-UPDATE, SET for t2, but the trigger is fired" where v1.id=2;

select * from t1;
select * from t2;
select * from t1_op_log;

drop view v1;
drop table t1, t2, t1_op_log;

--
-- TODO: test LOAD DATA INFILE
--
--echo
--echo Bug--27248 Triggers: error if insert affects temporary table
--echo
--echo The bug was fixed by the fix for Bug--26141
--echo
--disable_warnings
drop table if exists t1;
drop temporary table if exists t2;
create table t1 (s1 int);
create temporary table t2 (s1 int);
create trigger t1_bi before insert on t1 for each row insert into t2 values (0);
create trigger t1_bd before delete on t1 for each row delete from t2;
insert into t1 values (0);
insert into t1 values (0);
select * from t1;
select * from t2;
delete from t1;
select * from t1;
select * from t2;
drop table t1;
drop temporary table t2;
DROP TABLE IF EXISTS t1;
DROP TRIGGER IF EXISTS t_insert;
DROP TABLE IF EXISTS t2;

CREATE TABLE t1 (a int, date_insert timestamp, PRIMARY KEY (a));
INSERT INTO t1 (a) VALUES (2),(5);
CREATE TABLE t2 (a int, b int, PRIMARY KEY (a));
CREATE TRIGGER t_insert AFTER INSERT ON t2 FOR EACH ROW BEGIN UPDATE t1,t2 SET
date_insert=NOW() WHERE t1.a=t2.b AND t2.a=NEW.a;
INSERT INTO t2 (a,b) VALUES (1,2);

DROP TRIGGER t_insert;
CREATE TRIGGER t_insert AFTER INSERT ON t2 FOR EACH ROW BEGIN UPDATE t1,t2 SET
date_insert=NOW(),b=b+1 WHERE t1.a=t2.b AND t2.a=NEW.a;
INSERT INTO t2 (a,b) VALUES (3,5);

DROP TABLE t1;
DROP TRIGGER t_insert;
DROP TABLE t2;

--
-- Bug#25411 (trigger code truncated)
--

--disable_warnings
drop table if exists table_25411_a;
drop table if exists table_25411_b;

create table table_25411_a(a int);
create table table_25411_b(b int);

create trigger trg_25411a_ai after insert on table_25411_a
for each row
  insert into table_25411_b select new.*;

select * from table_25411_a;
insert into table_25411_a values (1);

select * from table_25411_a;

drop table table_25411_a;
drop table table_25411_b;

--
-- Bug #31866: MySQL Server crashes on SHOW CREATE TRIGGER statement
--

--error ER_TRG_DOES_NOT_EXIST
SHOW CREATE TRIGGER trg;

--
-- Bug#23713 LOCK TABLES + CREATE TRIGGER + FLUSH TABLES WITH READ LOCK = deadlock
--
-- Test of trigger creation and removal under LOCK TABLES
--

create table t1 (i int, j int);

create trigger t1_bi before insert on t1 for each row begin end;
create trigger t1_bi before insert on t1 for each row begin end;
drop trigger t1_bi;
drop trigger t1_bi;
create trigger t1_bi before insert on t1 for each row begin end;
create trigger t1_bi before insert on t1 for each row begin end;
drop trigger t1_bi;

create trigger t1_bi before insert on t1 for each row begin end;
create trigger t1_bi before insert on t1 for each row begin end;
drop trigger t1_bi;
drop trigger t1_bi;
create trigger b1_bi before insert on t1 for each row set new.i = new.i + 10;
insert into t1 values (10, 10);
drop trigger b1_bi;
insert into t1 values (10, 10);
select * from t1;

drop table t1;

--
-- Bug#23771 AFTER UPDATE trigger not invoked when there are no changes of the data
--

--disable_warnings
drop table if exists t1, t2;
drop trigger if exists trg1;
drop trigger if exists trg2;
create table t1 (a int);
create table t2 (b int);
create trigger trg1 after update on t1 for each row set @a= @a+1;
create trigger trg2 after update on t2 for each row set @b= @b+1;
insert into t1 values (1), (2), (3);
insert into t2 values (1), (2), (3);
set @a= 0;
set @b= 0;
update t1, t2 set t1.a= t1.a, t2.b= t2.b;
select @a, @b;
update t1, t2 set t1.a= t2.b, t2.b= t1.a;
select @a, @b;
update t1 set a= a;
select @a, @b;
update t2 set b= b;
select @a, @b;
update t1 set a= 1;
select @a, @b;
update t2 set b= 1;
select @a, @b;
drop trigger trg1;
drop trigger trg2;
drop table t1, t2;

--
-- Bug#44653: Server crash noticed when executing random queries with partitions.
--
CREATE TABLE t1 ( a INT, b INT );
CREATE TABLE t2 ( a INT AUTO_INCREMENT KEY, b INT );

INSERT INTO t1 (a) VALUES (1);
CREATE TRIGGER tr1
BEFORE INSERT ON t2
FOR EACH ROW 
BEGIN 
  UPDATE a_nonextisting_table SET a = 1;
CREATE TABLE IF NOT EXISTS t2 ( a INT, b INT ) SELECT a, b FROM t1;

-- Caused failed assertion
SELECT * FROM t2;

DROP TABLE t1, t2;
DROP TRIGGER IF EXISTS trg1;
DROP TABLE IF EXISTS t1, t2;

CREATE TABLE t1 (b VARCHAR(50) NOT NULL);
CREATE TABLE t2 (a VARCHAR(10) NOT NULL DEFAULT '');
CREATE TRIGGER trg1 AFTER INSERT ON t2
FOR EACH ROW BEGIN
  SELECT 1 FROM t1 c WHERE
    (@bug51650 IS NULL OR @bug51650 != c.b) AND c.b = NEW.a LIMIT 1 INTO @foo;

SET @bug51650 = 1;
INSERT IGNORE INTO t2 VALUES();
INSERT IGNORE INTO t1 SET b = '777';
INSERT IGNORE INTO t2 SET a = '111';
SET @bug51650 = 1;
INSERT IGNORE INTO t2 SET a = '777';

DROP TRIGGER trg1;
DROP TABLE t1, t2;
DROP DATABASE IF EXISTS db1;
DROP TRIGGER IF EXISTS trg1;
DROP TABLE IF EXISTS t1, t2;

CREATE DATABASE db1;
USE db1;

CREATE TABLE t1 (b INT);
CREATE TABLE t2 (a INT);

CREATE TRIGGER trg1 BEFORE INSERT ON t2 FOR EACH ROW INSERT/*!INTO*/t1 VALUES (1);
INSERT INTO t2 VALUES (1);
SELECT * FROM t1;

DROP DATABASE db1;
USE test;
DROP TRIGGER IF EXISTS t1_bi;
DROP TRIGGER IF EXISTS t1_bd;
DROP TABLE IF EXISTS t1;
DROP TEMPORARY TABLE IF EXISTS t2;

CREATE TABLE t1 (s1 INT);
CREATE TEMPORARY TABLE t2 (s1 INT);
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW INSERT INTO t2 VALUES (0);
CREATE TRIGGER t1_bd BEFORE DELETE ON t1 FOR EACH ROW DELETE FROM t2;
INSERT INTO t1 VALUES (0);
INSERT INTO t1 VALUES (0);
SELECT * FROM t1;
SELECT * FROM t2;
DELETE FROM t1;

DROP TABLE t1;
DROP TEMPORARY TABLE t2;

--
-- Bug#36649: Condition area is not properly cleaned up after stored routine invocation
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
DROP TRIGGER IF EXISTS trg1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a INT);
CREATE TRIGGER trg1 BEFORE INSERT ON t1 FOR EACH ROW
BEGIN
  DECLARE a CHAR;
  SELECT 'ab' INTO a;
  SELECT 'ab' INTO a;
  SELECT 'a' INTO a;

INSERT INTO t1 VALUES (1);

DROP TRIGGER trg1;
DROP TABLE t1;

--
-- Successive trigger actuations
--

--disable_warnings
DROP TRIGGER IF EXISTS trg1;
DROP TRIGGER IF EXISTS trg2;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a INT);

CREATE TRIGGER trg1 BEFORE INSERT ON t1 FOR EACH ROW
BEGIN
  DECLARE trg1 CHAR;
  SELECT 'ab' INTO trg1;

CREATE TRIGGER trg2 AFTER INSERT ON t1 FOR EACH ROW
BEGIN
  DECLARE trg2 CHAR;
  SELECT 'ab' INTO trg2;

INSERT INTO t1 VALUES (0);
SELECT * FROM t1;
INSERT INTO t1 VALUES (1),(2);

DROP TRIGGER trg1;
DROP TRIGGER trg2;
DROP TABLE t1;
SET sql_mode = default;
drop trigger if exists t1_bi;
drop temporary table if exists t1;
drop table if exists t1;

create table t1 (i int);
create trigger t1_bi before insert on t1 for each row set @a:=1;
create temporary table t1 (j int);
drop trigger t1_bi;
select trigger_name from information_schema.triggers
  where event_object_schema = 'test' and event_object_table = 't1';
drop temporary table t1;
drop table t1;

CREATE TABLE t1(c TEXT);
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW
BEGIN
  DECLARE v TEXT;
  SET v = 'aaa';
  SET NEW.c = v;

INSERT INTO t1 VALUES('qazwsxedc');

SELECT c FROM t1;

DROP TABLE t1;
DROP TABLE IF EXISTS t1, t2, t3;
DROP TRIGGER IF EXISTS t2_ai;
CREATE TABLE t2 
       (
         value CHAR(30),
         domain_id INT,
         mailaccount_id INT, 
         program CHAR(30),
         keey CHAR(30),
         PRIMARY KEY(domain_id)
       );
CREATE TABLE t3 
       (
         value CHAR(30),
         domain_id INT,
         mailaccount_id INT,
         program CHAR(30),
         keey CHAR(30),
         PRIMARY KEY(domain_id)
       );
CREATE TABLE t1 (id INT,domain CHAR(30),PRIMARY KEY(id));
CREATE TRIGGER t2_ai AFTER INSERT ON t2 FOR EACH ROW 
  UPDATE t3 ms, t1 d SET ms.value='No'
  WHERE ms.domain_id = 
    (SELECT max(id) FROM t1 WHERE domain='example.com') 
  AND ms.mailaccount_id IS NULL 
  AND ms.program='spamfilter' 
  AND ms.keey='scan_incoming';

INSERT INTO t1 VALUES (1, 'example.com'),
                      (2, 'mysql.com'),
                      (3, 'earthmotherwear.com'),
                      (4, 'yahoo.com'),
                      (5, 'example.com');
INSERT INTO t2 VALUES ('Yes', 1, NULL, 'spamfilter','scan_incoming');
DROP TRIGGER t2_ai;
DROP TABLE t1, t2, t3;

CREATE TABLE t1 (a INT, b INT DEFAULT 150);
CREATE TRIGGER t1_bi BEFORE INSERT ON t1
FOR EACH ROW 
BEGIN
  CREATE TEMPORARY TABLE t2 AS SELECT NEW.a, NEW.b;
  INSERT INTO t2(a) VALUES (10);
  INSERT INTO t2 VALUES (100, 500);
  INSERT INTO t2(a) VALUES (1000);
END
|
delimiter ;

INSERT INTO t1 VALUES (1, 2);
SELECT * FROM t2;

DROP TABLE t1;
DROP TEMPORARY TABLE t2;

CREATE TABLE t1(a INT);
CREATE TRIGGER t1_au AFTER UPDATE ON t1 FOR EACH ROW START SLAVE;
CREATE TRIGGER t1_au AFTER UPDATE ON t1 FOR EACH ROW STOP SLAVE;
CREATE TRIGGER t1_au AFTER UPDATE ON t1 FOR EACH ROW
CREATE SERVER s FOREIGN DATA WRAPPER mysql OPTIONS (USER 'Remote',
                                                    HOST '192.168.1.106',
                                                    DATABASE 'test');
CREATE TRIGGER t1_bu BEFORE UPDATE ON t1 FOR EACH ROW
ALTER SERVER s OPTIONS (password '1');
CREATE TRIGGER tr1 AFTER UPDATE ON t1 FOR EACH ROW
DROP SERVER IF EXISTS s;

CREATE DATABASE db1;
CREATE TRIGGER tr1 AFTER UPDATE ON t1 FOR EACH ROW
ALTER DATABASE db1 CHARACTER SET latin1;

DROP DATABASE db1;

CREATE USER 'u1'@'localhost' IDENTIFIED BY 'pass';
CREATE TRIGGER tr1 AFTER UPDATE ON t1 FOR EACH ROW
ALTER USER 'u1'@'localhost' PASSWORD EXPIRE;

DROP USER 'u1'@'localhost';
CREATE TRIGGER tr1 AFTER UPDATE ON t1 FOR EACH ROW
CHANGE REPLICATION SOURCE TO SOURCE_SSL = 0;

DROP TABLE t1;

SET @save_sql_mode= @@sql_mode;
SET sql_mode= 'traditional';

let $column1_type_name = INT;
let $column2_type_name = INT;
let $column2_value = 3;

let $column1_type_name = TINYINT;
let $column2_type_name = TINYINT;
let $column2_value = 3;

let $column1_type_name = BOOL;
let $column2_type_name = BOOL;
let $column2_value = TRUE;

let $column1_type_name = SMALLINT;
let $column2_type_name = SMALLINT;
let $column2_value = 3;

let $column1_type_name = BIGINT;
let $column2_type_name = BIGINT;
let $column2_value = 3;

let $column1_type_name = DECIMAL;
let $column2_type_name = DECIMAL;
let $column2_value = 3;

let $column1_type_name = FLOAT;
let $column2_type_name = FLOAT;
let $column2_value = 3;

let $column1_type_name = DOUBLE;
let $column2_type_name = DOUBLE;
let $column2_value = 3;

let $column1_type_name = BIT;
let $column2_type_name = BIT;
let $column2_value = 1;

let $column1_type_name = ENUM('a', 'b', 'c');
let $column2_type_name = ENUM('a', 'b', 'c');
let $column2_value = 'b';

let $column1_type_name = SET('a', 'b', 'c');
let $column2_type_name = SET('a', 'b', 'c');
let $column2_value = 'b';

let $column1_type_name = VARBINARY(10);
let $column2_type_name = VARBINARY(10);
let $column2_value = 'binary';

let $column1_type_name = BINARY(10);
let $column2_type_name = BINARY(10);
let $column2_value = 'binary';

let $column1_type_name = TINYTEXT;
let $column2_type_name = TINYTEXT;
let $column2_value = 'text';

let $column1_type_name = TEXT(10);
let $column2_type_name = TEXT(10);
let $column2_value = 'text';

let $column1_type_name = BLOB;
let $column2_type_name = BLOB;
let $column2_value = 'binary';

let $column1_type_name = VARCHAR(5);
let $column2_type_name = INT;
let $column2_value = 3;

let $column1_type_name = INT;
let $column2_type_name = VARCHAR(5);
let $column2_value = 'str';

let $column1_type_name = VARCHAR(15);
let $column2_type_name = VARCHAR(5);
let $column2_value = 'str';

let $column1_type_name = VARCHAR(15);
let $column2_type_name = BLOB;
let $column2_value = 'str';

let $column1_type_name = TEXT(20);
let $column2_type_name = TEXT(10);
let $column2_value = 'text';

SET sql_mode= @save_sql_mode;

-- End of tests for Bug#17864349
--echo --
--echo -- Bug#18596756 - FAILED PREPARING OF TRIGGER ON TRUNCATED TABLES CAUSE
--echo --                ERROR 1054.
--echo --

CREATE TABLE t1(id INT);
CREATE TABLE t2(id INT);

CREATE TRIGGER trigger1 BEFORE INSERT ON t1 FOR EACH ROW
  SET NEW.id= (SELECT * FROM t2);

INSERT INTO t2 VALUES(0);
INSERT INTO t1 VALUES(0);

INSERT INTO t2 VALUES(0);
INSERT INTO t1 VALUES(0);

DROP TABLE t2;
INSERT INTO t1 VALUES(0);

DROP TABLE t1;
CREATE TABLE t1 (a INT PRIMARY KEY);
CREATE TABLE t2 (after_update CHAR(50));
CREATE TABLE t3(b INT PRIMARY KEY);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t3 VALUES (1);
CREATE TRIGGER post_update_t1 AFTER UPDATE ON t1
FOR EACH ROW BEGIN
  INSERT INTO t2 VALUES("POST UPDATE TRIGGER FOR UPDATE IGNORE ON t1 FIRED");
UPDATE IGNORE t1 SET a=2 WHERE a=1;
SELECT * FROM t2;
UPDATE IGNORE t1,t3 SET t1.a=2 WHERE t1.a=1;
SELECT * FROM t2;
UPDATE IGNORE t3,t1 SET t1.a=2 WHERE t1.a=1;
SELECT * FROM t1;
SELECT * FROM t2;
DROP TRIGGER post_update_t1;
DROP TABLE t1,t2,t3;

CREATE USER user_name_robert_golebiowski@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char;
CREATE TABLE test.silly_one (ID INT);

CREATE DEFINER=user_name_robert_golebiowski@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char TRIGGER test.silly_trigger BEFORE INSERT ON test.silly_one FOR EACH ROW SET @x=1;

SELECT DEFINER FROM information_schema.triggers WHERE TRIGGER_NAME='silly_trigger';

DROP USER user_name_robert_golebiowski@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char;
DROP TRIGGER test.silly_trigger;
DROP TABLE test.silly_one;

CREATE TABLE t1 (a INT) ENGINE=InnoDB;
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW BEGIN END;

DROP TRIGGER t1_bi;
DROP TABLE t1Renamed;
CREATE TRIGGER non_existent_db.trg1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN END;
DROP TRIGGER non_existent_db.trg1;

CREATE TABLE t1 (val INT NOT NULL) ENGINE=InnoDB
PARTITION BY LIST(val) (
  PARTITION p1 VALUES IN (1,2,3),
  PARTITION p2 VALUES IN (4,5)
);

CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW BEGIN END;

ALTER TABLE t1 DROP PARTITION p1;

DROP TABLE t1;
CREATE TABLE t1 (a INT);
CREATE TRIGGER trg1a BEFORE INSERT ON t1 FOR EACH ROW BEGIN END;
CREATE TRIGGER trg1b AFTER INSERT ON t1 FOR EACH ROW BEGIN END;
CREATE TRIGGER trg1c BEFORE UPDATE ON t1 FOR EACH ROW BEGIN END;
CREATE TRIGGER trg1d AFTER UPDATE ON t1 FOR EACH ROW BEGIN END;
CREATE TRIGGER trg1e BEFORE DELETE ON t1 FOR EACH ROW BEGIN END;
CREATE TRIGGER trg1f AFTER DELETE ON t1 FOR EACH ROW BEGIN END;
CREATE TRIGGER trg1a2 BEFORE INSERT ON t1 FOR EACH ROW BEGIN END;
CREATE TRIGGER trg1b2 AFTER INSERT ON t1 FOR EACH ROW BEGIN END;
CREATE TRIGGER trg1c2 BEFORE UPDATE ON t1 FOR EACH ROW BEGIN END;
CREATE TRIGGER trg1d2 AFTER UPDATE ON t1 FOR EACH ROW BEGIN END;
CREATE TRIGGER trg1f2 AFTER DELETE ON t1 FOR EACH ROW BEGIN END;
CREATE TRIGGER trg1a0 BEFORE INSERT ON t1 FOR EACH ROW PRECEDES trg1a BEGIN END;
CREATE TRIGGER trg1a3 BEFORE INSERT ON t1 FOR EACH ROW FOLLOWS trg1a2 BEGIN END;
CREATE TRIGGER trg1b0 AFTER INSERT ON t1 FOR EACH ROW PRECEDES trg1b BEGIN END;
CREATE TRIGGER trg1b3 AFTER INSERT ON t1 FOR EACH ROW FOLLOWS trg1b2 BEGIN END;
CREATE TRIGGER trg1c0 BEFORE UPDATE ON t1 FOR EACH ROW PRECEDES trg1c BEGIN END;
CREATE TRIGGER trg1c3 BEFORE UPDATE ON t1 FOR EACH ROW FOLLOWS trg1c2 BEGIN END;
SELECT TRIGGER_NAME FROM information_schema.triggers WHERE TRIGGER_NAME LIKE 'trg1%' ORDER BY TRIGGER_NAME;
DROP TABLE t1;

CREATE TABLE t1(a INT);
CREATE SCHEMA s1;
CREATE VIEW s1.v1 AS SELECT * FROM t1;
CREATE TRIGGER trg1 BEFORE INSERT ON t1 FOR EACH ROW BEGIN END;
DROP TRIGGER trg1;
DROP VIEW s1.v1;
DROP TABLE t1;
DROP SCHEMA s1;
--   - Check that triggers are executed under the authorization of the definer.
--   - Check DEFINER clause of CREATE TRIGGER statement;
--     - Check that SUPER privilege required to create a trigger with different
--       definer.
--     - Check that if the user specified as DEFINER does not exist, a warning
--       is emitted.
--     - Check that the definer of a trigger does not exist, the trigger will
--       not be activated.
--   - Check that SHOW TRIGGERS statement provides "Definer" column.
--   - Check that if trigger contains NEW/OLD variables, the definer must have
--     SELECT privilege on the subject table (aka BUG#15166/BUG#15196).
--
--  Let's also check that user name part of definer can contain '@' symbol (to
--  check that triggers are not affected by BUG#13310 "incorrect user parsing
--  by SP").
--
--##########################################################################

--
-- Prepare environment.
--

DELETE FROM mysql.user WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.db WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.tables_priv WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.columns_priv WHERE User LIKE 'mysqltest_%';
DROP DATABASE IF EXISTS mysqltest_db1;

CREATE DATABASE mysqltest_db1;

CREATE USER mysqltest_dfn@localhost;
CREATE USER mysqltest_inv@localhost;

CREATE TABLE t1(num_value INT);
CREATE TABLE t2(user_str TEXT);

--
-- Check that the user must have TRIGGER privilege to create a trigger.
--

--connection default
--echo
--echo ---> connection: default

GRANT SUPER ON *.* TO mysqltest_dfn@localhost;
CREATE TRIGGER trg1 AFTER INSERT ON t1
  FOR EACH ROW
    INSERT INTO t2 VALUES(CURRENT_USER());

--
-- Check that the user must have TRIGGER privilege to drop a trigger.
--

--connection default
--echo
--echo ---> connection: default

GRANT TRIGGER ON mysqltest_db1.t1 TO mysqltest_dfn@localhost;

CREATE TRIGGER trg1 AFTER INSERT ON t1
  FOR EACH ROW
    INSERT INTO t2 VALUES(CURRENT_USER());
DROP TRIGGER trg1;

--
-- Check that the definer must have TRIGGER privilege to activate a trigger.
--

--connect (wl2818_definer_con,localhost,mysqltest_dfn,,mysqltest_db1)
--connection wl2818_definer_con
--echo
--echo ---> connection: wl2818_definer_con

--error ER_TABLEACCESS_DENIED_ERROR
INSERT INTO t1 VALUES(0);

INSERT INTO t1 VALUES(0);

-- Cleanup for further tests.
DROP TRIGGER trg1;

--
-- Check that triggers are executed under the authorization of the definer:
--   - create two tables under "definer";
--   - grant all privileges on the test db to "definer";
--   - grant all privileges on the first table to "invoker";
--   - grant only select privilege on the second table to "invoker";
--   - create a trigger, which inserts a row into the second table after
--     inserting into the first table.
--   - insert a row into the first table under "invoker". A row also should be
--     inserted into the second table.
--

--connect (wl2818_definer_con,localhost,mysqltest_dfn,,mysqltest_db1)
--connection wl2818_definer_con
--echo
--echo ---> connection: wl2818_definer_con

CREATE TRIGGER trg1 AFTER INSERT ON t1
  FOR EACH ROW
    INSERT INTO t2 VALUES(CURRENT_USER());

-- Setup definer's privileges.

GRANT ALL PRIVILEGES ON mysqltest_db1.t1 TO mysqltest_dfn@localhost;

-- Setup invoker's privileges.

GRANT ALL PRIVILEGES ON mysqltest_db1.t1
  TO 'mysqltest_inv'@localhost;
  TO 'mysqltest_inv'@localhost;

use mysqltest_db1;

INSERT INTO t1 VALUES(1);

SELECT * FROM t1;
SELECT * FROM t2;

use mysqltest_db1;

INSERT INTO t1 VALUES(2);

SELECT * FROM t1;
SELECT * FROM t2;

--
-- Check that if definer lost some privilege required to execute (activate) a
-- trigger, the trigger will not be activated:
--  - create a trigger on insert into the first table, which will insert a row
--    into the second table;
--  - revoke INSERT privilege on the second table from the definer;
--  - insert a row into the first table;
--  - check that an error has been risen;
--  - check that no row has been inserted into the second table;
--

--connection default
--echo
--echo ---> connection: default

use mysqltest_db1;

use mysqltest_db1;
INSERT INTO t1 VALUES(3);

SELECT * FROM t1;
SELECT * FROM t2;

--
-- Check DEFINER clause of CREATE TRIGGER statement.
--
--   - Check that SUPER privilege required to create a trigger with different
--     definer:
--     - try to create a trigger with DEFINER="definer@localhost" under
--       "invoker";
--     - analyze error code;
--   - Check that if the user specified as DEFINER does not exist, a warning is
--     emitted:
--     - create a trigger with DEFINER="non_existent_user@localhost" from
--       "definer";
--     - check that a warning emitted;
--   - Check that the definer of a trigger does not exist, the trigger will not
--     be activated:
--     - activate just created trigger;
--     - check error code;
--

--connection wl2818_definer_con
--echo
--echo ---> connection: wl2818_definer_con

use mysqltest_db1;

DROP TRIGGER trg1;

-- Check that SUPER is required to specify different DEFINER.

--error ER_SPECIFIC_ACCESS_DENIED_ERROR
CREATE DEFINER='mysqltest_inv'@'localhost'
  TRIGGER trg1 BEFORE INSERT ON t1
  FOR EACH ROW
    SET @new_sum = 0;

use mysqltest_db1;

CREATE DEFINER='mysqltest_inv'@'localhost'
  TRIGGER trg1 BEFORE INSERT ON t1
  FOR EACH ROW
    SET @new_sum = 0;

-- Create with non-existent user.

CREATE DEFINER='mysqltest_nonexs'@'localhost'
  TRIGGER trg2 AFTER INSERT ON t1
  FOR EACH ROW
    SET @new_sum = 0;

-- Check that trg2 will not be activated.

--error ER_NO_SUCH_USER
INSERT INTO t1 VALUES(6);

--
-- Check that SHOW TRIGGERS statement provides "Definer" column.
--

--replace_column 6 --
SHOW TRIGGERS;

DROP TRIGGER trg1;
DROP TRIGGER trg2;

--
-- Cleanup
--

--connection default
--echo
--echo ---> connection: default

DROP USER mysqltest_dfn@localhost;
DROP USER mysqltest_inv@localhost;

DROP DATABASE mysqltest_db1;

--
-- Prepare environment.
--

DELETE FROM mysql.user WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.db WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.tables_priv WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.columns_priv WHERE User LIKE 'mysqltest_%';
DROP DATABASE IF EXISTS mysqltest_db1;

CREATE DATABASE mysqltest_db1;

use mysqltest_db1;

-- Tables for tesing table-level privileges:
CREATE TABLE t1(col CHAR(20));
CREATE TABLE t2(col CHAR(20));

-- Tables for tesing column-level privileges:
CREATE TABLE t3(col CHAR(20));
CREATE TABLE t4(col CHAR(20));

CREATE USER mysqltest_u1@localhost;

SET @mysqltest_var = NULL;

-- parsing (CREATE TRIGGER) time:
--   - check that nor SELECT either UPDATE is required to execute triggger w/o
--     NEW/OLD variables.

--connection default
--echo
--echo ---> connection: default

use mysqltest_db1;

use mysqltest_db1;

CREATE TRIGGER t1_trg_after_delete AFTER DELETE ON t1
  FOR EACH ROW
    SET @mysqltest_var = 'Hello, world!';

-- parsing (CREATE TRIGGER) time:
--   - check that UPDATE is not enough to read the value;
--   - check that UPDATE is required to modify the value;

use mysqltest_db1;

use mysqltest_db1;

-- - table-level privileges

-- TODO: check privileges at CREATE TRIGGER time.
-- --error ER_COLUMNACCESS_DENIED_ERROR
CREATE TRIGGER t1_trg_err_1 BEFORE INSERT ON t1
  FOR EACH ROW
    SET @mysqltest_var = NEW.col;
DROP TRIGGER t1_trg_err_1;

-- TODO: check privileges at CREATE TRIGGER time.
-- --error ER_COLUMNACCESS_DENIED_ERROR
CREATE TRIGGER t1_trg_err_2 BEFORE DELETE ON t1
  FOR EACH ROW
    SET @mysqltest_var = OLD.col;
DROP TRIGGER t1_trg_err_2;

CREATE TRIGGER t2_trg_before_insert BEFORE INSERT ON t2
  FOR EACH ROW
    SET NEW.col = 't2_trg_before_insert';

-- - column-level privileges

-- TODO: check privileges at CREATE TRIGGER time.
-- --error ER_COLUMNACCESS_DENIED_ERROR
CREATE TRIGGER t3_trg_err_1 BEFORE INSERT ON t3
  FOR EACH ROW
    SET @mysqltest_var = NEW.col;
DROP TRIGGER t3_trg_err_1;

-- TODO: check privileges at CREATE TRIGGER time.
-- --error ER_COLUMNACCESS_DENIED_ERROR
CREATE TRIGGER t3_trg_err_2 BEFORE DELETE ON t3
  FOR EACH ROW
    SET @mysqltest_var = OLD.col;
DROP TRIGGER t3_trg_err_2;

CREATE TRIGGER t4_trg_before_insert BEFORE INSERT ON t4
  FOR EACH ROW
    SET NEW.col = 't4_trg_before_insert';

-- parsing (CREATE TRIGGER) time:
--   - check that SELECT is required to read the value;
--   - check that SELECT is not enough to modify the value;

use mysqltest_db1;

use mysqltest_db1;

-- - table-level privileges

CREATE TRIGGER t1_trg_after_insert AFTER INSERT ON t1
 FOR EACH ROW
  SET @mysqltest_var = NEW.col;

CREATE TRIGGER t1_trg_after_update AFTER UPDATE ON t1
 FOR EACH ROW
  SET @mysqltest_var = OLD.col;

-- TODO: check privileges at CREATE TRIGGER time.
-- --error ER_COLUMNACCESS_DENIED_ERROR
CREATE TRIGGER t2_trg_err_1 BEFORE UPDATE ON t2
 FOR EACH ROW
  SET NEW.col = 't2_trg_err_1';
DROP TRIGGER t2_trg_err_1;

-- TODO: check privileges at CREATE TRIGGER time.
-- --error ER_COLUMNACCESS_DENIED_ERROR
CREATE TRIGGER t2_trg_err_2 BEFORE UPDATE ON t2
 FOR EACH ROW
  SET NEW.col = CONCAT(OLD.col, '(updated)');
DROP TRIGGER t2_trg_err_2;

-- - column-level privileges

CREATE TRIGGER t3_trg_after_insert AFTER INSERT ON t3
  FOR EACH ROW
    SET @mysqltest_var = NEW.col;

CREATE TRIGGER t3_trg_after_update AFTER UPDATE ON t3
  FOR EACH ROW
    SET @mysqltest_var = OLD.col;

-- TODO: check privileges at CREATE TRIGGER time.
-- --error ER_COLUMNACCESS_DENIED_ERROR
CREATE TRIGGER t4_trg_err_1 BEFORE UPDATE ON t4
 FOR EACH ROW
  SET NEW.col = 't4_trg_err_1';
DROP TRIGGER t4_trg_err_1;

-- TODO: check privileges at CREATE TRIGGER time.
-- --error ER_COLUMNACCESS_DENIED_ERROR
CREATE TRIGGER t4_trg_err_2 BEFORE UPDATE ON t4
 FOR EACH ROW
  SET NEW.col = CONCAT(OLD.col, '(updated)');
DROP TRIGGER t4_trg_err_2;

-- execution time:
--   - check that UPDATE is not enough to read the value;
--   - check that UPDATE is required to modify the value;

use mysqltest_db1;

-- - table-level privileges

--error ER_COLUMNACCESS_DENIED_ERROR
INSERT INTO t1 VALUES('line1');

SELECT * FROM t1;
SELECT @mysqltest_var;

INSERT INTO t2 VALUES('line2');

SELECT * FROM t2;

-- - column-level privileges

--error ER_COLUMNACCESS_DENIED_ERROR
INSERT INTO t3 VALUES('t3_line1');

SELECT * FROM t3;
SELECT @mysqltest_var;

INSERT INTO t4 VALUES('t4_line2');

SELECT * FROM t4;

-- execution time:
--   - check that SELECT is required to read the value;
--   - check that SELECT is not enough to modify the value;

use mysqltest_db1;

-- - table-level privileges

INSERT INTO t1 VALUES('line3');

SELECT * FROM t1;
SELECT @mysqltest_var;
INSERT INTO t2 VALUES('line4');

SELECT * FROM t2;

-- - column-level privileges

INSERT INTO t3 VALUES('t3_line2');

SELECT * FROM t3;
SELECT @mysqltest_var;
INSERT INTO t4 VALUES('t4_line2');

SELECT * FROM t4;

-- execution time:
--   - check that nor SELECT either UPDATE is required to execute triggger w/o
--     NEW/OLD variables.

DELETE FROM t1;

SELECT @mysqltest_var;

--
-- Cleanup.
--

DROP USER mysqltest_u1@localhost;

DROP DATABASE mysqltest_db1;


--
-- Test for bug #14635 Accept NEW.x as INOUT parameters to stored
-- procedures from within triggers
--
-- We require UPDATE privilege when NEW.x passed as OUT parameter, and
-- SELECT and UPDATE when NEW.x passed as INOUT parameter.
--
DELETE FROM mysql.user WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.db WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.tables_priv WHERE User LIKE 'mysqltest_%';
DELETE FROM mysql.columns_priv WHERE User LIKE 'mysqltest_%';
DROP DATABASE IF EXISTS mysqltest_db1;

CREATE DATABASE mysqltest_db1;
USE mysqltest_db1;

CREATE TABLE t1 (i1 INT);
CREATE TABLE t2 (i1 INT);

CREATE USER mysqltest_dfn@localhost;
CREATE USER mysqltest_inv@localhost;
CREATE PROCEDURE p1(OUT i INT) DETERMINISTIC NO SQL SET i = 3;
CREATE PROCEDURE p2(INOUT i INT) DETERMINISTIC NO SQL SET i = i * 5;

-- Check that having no privilege won't work.
connection definer;
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW
  CALL p1(NEW.i1);
CREATE TRIGGER t2_bi BEFORE INSERT ON t2 FOR EACH ROW
  CALL p2(NEW.i1);
INSERT INTO t1 VALUES (7);
INSERT INTO t2 VALUES (11);
DROP TRIGGER t2_bi;
DROP TRIGGER t1_bi;

-- Check that having only SELECT privilege is not enough.
connection default;
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW
  CALL p1(NEW.i1);
CREATE TRIGGER t2_bi BEFORE INSERT ON t2 FOR EACH ROW
  CALL p2(NEW.i1);
INSERT INTO t1 VALUES (13);
INSERT INTO t2 VALUES (17);
DROP TRIGGER t2_bi;
DROP TRIGGER t1_bi;

-- Check that having only UPDATE privilege is enough for OUT parameter,
-- but not for INOUT parameter.
connection default;
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW
  CALL p1(NEW.i1);
CREATE TRIGGER t2_bi BEFORE INSERT ON t2 FOR EACH ROW
  CALL p2(NEW.i1);
INSERT INTO t1 VALUES (19);
INSERT INTO t2 VALUES (23);
DROP TRIGGER t2_bi;
DROP TRIGGER t1_bi;

-- Check that having SELECT and UPDATE privileges is enough.
connection default;
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW
  CALL p1(NEW.i1);
CREATE TRIGGER t2_bi BEFORE INSERT ON t2 FOR EACH ROW
  CALL p2(NEW.i1);
INSERT INTO t1 VALUES (29);
INSERT INTO t2 VALUES (31);
DROP TRIGGER t2_bi;
DROP TRIGGER t1_bi;
DROP PROCEDURE p2;
DROP PROCEDURE p1;

-- Check that late procedure redefining won't open a security hole.
connection default;
CREATE PROCEDURE p1(OUT i INT) DETERMINISTIC NO SQL SET i = 37;
CREATE TRIGGER t1_bi BEFORE INSERT ON t1 FOR EACH ROW
  CALL p1(NEW.i1);
INSERT INTO t1 VALUES (41);
DROP PROCEDURE p1;
CREATE PROCEDURE p1(IN i INT) DETERMINISTIC NO SQL SET @v1 = i + 43;
INSERT INTO t1 VALUES (47);
DROP PROCEDURE p1;
CREATE PROCEDURE p1(INOUT i INT) DETERMINISTIC NO SQL SET i = i + 51;
INSERT INTO t1 VALUES (53);
DROP PROCEDURE p1;
DROP TRIGGER t1_bi;

-- Cleanup.
disconnect definer;
DROP USER mysqltest_inv@localhost;
DROP USER mysqltest_dfn@localhost;
DROP TABLE t2;
DROP TABLE t1;
DROP DATABASE mysqltest_db1;
USE test;

--
-- Bug#23713 LOCK TABLES + CREATE TRIGGER + FLUSH TABLES WITH READ LOCK = deadlock
--

--disable_warnings
drop table if exists t1;
create table t1 (i int);
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock";
create trigger t1_bi before insert on t1 for each row begin end;
select * from t1;
drop table t1;

--
-- Bug#45412 SHOW CREATE TRIGGER does not require privileges to disclose trigger data
--
CREATE DATABASE db1;
CREATE TABLE db1.t1 (a char(30)) ENGINE=MEMORY;
CREATE TRIGGER db1.trg AFTER INSERT ON db1.t1 FOR EACH ROW
 INSERT INTO db1.t1 VALUES('Some very sensitive data goes here');

CREATE USER 'no_rights'@'localhost';
SELECT trigger_name FROM INFORMATION_SCHEMA.TRIGGERS
 WHERE trigger_schema = 'db1';
DROP USER 'no_rights'@'localhost';
DROP DATABASE db1;

--
-- Bug#55421 Protocol::end_statement(): Assertion `0' on multi-table UPDATE IGNORE
-- To reproduce a crash we need to provoke a trigger execution with
-- the following conditions:
--   - active SELECT statement during trigger execution
--    (i.e. LEX::current_select != NULL);
--   - IGNORE option (i.e. LEX::current_select->no_error == TRUE);
DROP DATABASE IF EXISTS mysqltest_db1;

CREATE DATABASE mysqltest_db1;
USE mysqltest_db1;

CREATE USER mysqltest_u1@localhost;

CREATE TABLE t1 (
  a1 int,
  a2 int
);
INSERT INTO t1 VALUES (1, 20);

CREATE TRIGGER mysqltest_db1.upd_t1
BEFORE UPDATE ON t1 FOR EACH ROW SET new.a2 = 200;

CREATE TABLE t2 (
  a1 int
);

INSERT INTO t2 VALUES (2);
UPDATE IGNORE t1, t2 SET t1.a1 = 2, t2.a1 = 3 WHERE t1.a1 = 1 AND t2.a1 = 2;

DROP DATABASE mysqltest_db1;
DROP USER mysqltest_u1@localhost;
USE test;

CREATE DATABASE test1;
CREATE TABLE test1.t1 (
  int_field INTEGER UNSIGNED NOT NULL,
  char_field CHAR(10),
  INDEX(`int_field`)
);

use test;

CREATE USER user_name_len_22_01234@localhost;
CREATE USER user_name_len_32_012345678901234@localhost;
SELECT * FROM test1.t1;
SELECT * FROM test1.t1;

CREATE DEFINER=user_name_len_32_012345678901234@localhost
  TRIGGER test1.t1_ai AFTER INSERT ON test1.t1 FOR EACH ROW SET @a = (SELECT COUNT(*) FROM test1.t1);
set @a:=0;
INSERT INTO test1.t1 VALUES (1,'haha');
SELECT @a;
CREATE DEFINER=user_name_len_33_0123456789012345@localhost
  TRIGGER test1.t1_bi BEFORE INSERT ON test1.t1 FOR EACH ROW SET @a = (SELECT COUNT(*) FROM test1.t1);
DROP DATABASE test1;

DROP USER user_name_len_22_01234@localhost;
DROP USER user_name_len_32_012345678901234@localhost;
SET TIMESTAMP= UNIX_TIMESTAMP("2017-03-30 07:07:07");
CREATE TABLE t1( a TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP );

CREATE TRIGGER trigger_for_normal_insert BEFORE INSERT ON t1 FOR EACH ROW
SET @x:= NEW.a;

INSERT INTO t1() VALUES();

SELECT * FROM t1;
SELECT @x;

DROP TABLE t1;
CREATE TABLE t1(a DATETIME NOT NULL DEFAULT NOW(), b INT);

CREATE TRIGGER trigger_for_insert_select BEFORE INSERT ON t1 FOR EACH ROW
SET @x:= NEW.a;

INSERT INTO t1(b) SELECT 1;

SELECT * FROM t1;
SELECT @x;

DROP TABLE t1;
CREATE TABLE t1( a TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP );

CREATE TRIGGER trigger_for_normal_replace BEFORE INSERT ON t1 FOR EACH ROW
SET @x:= NEW.a;

SELECT * FROM t1;
SELECT @x;

DROP TABLE t1;
CREATE TABLE t1(a DATETIME NOT NULL DEFAULT NOW(), b INT);

CREATE TRIGGER trigger_for_replace_select BEFORE INSERT ON t1 FOR EACH ROW
SET @x:= NEW.a;

SELECT * FROM t1;
SELECT @x;

DROP TABLE t1;
SET TIMESTAMP= UNIX_TIMESTAMP("2017-04-11 09:09:09");
CREATE TABLE t1( a TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
                 ON UPDATE NOW(), b INT DEFAULT 1 );

CREATE TRIGGER trigger_before_update BEFORE UPDATE ON t1 FOR EACH ROW
SET @x:= NEW.a;

INSERT INTO t1 VALUES();
SELECT * FROM t1;

SET TIMESTAMP= UNIX_TIMESTAMP("2017-04-12 10:10:10");
UPDATE t1 SET b= 2;

SELECT * FROM t1;
SELECT @x;

DROP TABLE t1;
SET TIMESTAMP= UNIX_TIMESTAMP("2017-04-13 08:08:08");
CREATE TABLE t1( a TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                 b INT DEFAULT 1 );

CREATE TRIGGER trigger_before_update BEFORE UPDATE ON t1 FOR EACH ROW
SET @x:= NEW.a;

INSERT INTO t1 VALUES();
SELECT * FROM t1;

SET TIMESTAMP= UNIX_TIMESTAMP("2017-05-04 05:05:05");
UPDATE t1 SET b= 2;

SELECT * FROM t1;
SELECT @x;

DROP TABLE t1;
SET TIMESTAMP= UNIX_TIMESTAMP("2017-04-25 11:11:11");
CREATE TABLE t1( a DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
                 ON UPDATE CURRENT_TIMESTAMP, b INT);
CREATE TABLE t2( d INT);

INSERT INTO t1(b) VALUES(1);
INSERT INTO t2 VALUES(2);

SELECT * FROM t1;
SELECT * FROM t2;

CREATE TRIGGER trigger_before_update_with_join BEFORE UPDATE ON t1 FOR EACH ROW
SET @x:= NEW.a;

SET TIMESTAMP= UNIX_TIMESTAMP("2017-04-25 01:01:01");
UPDATE t1, t2 SET t1.b= t2.d;

SELECT * FROM t1;
SELECT @x;

DROP TABLE t1, t2;
SET TIMESTAMP= UNIX_TIMESTAMP("2017-04-17 06:06:06");
CREATE TABLE t1( a TIMESTAMP NOT NULL DEFAULT NOW(), b INT );

CREATE TRIGGER trigger_for_load_infile BEFORE INSERT ON t1 FOR EACH ROW
SET @x:= NEW.a;

SELECT 1 INTO OUTFILE 't1.dat' FROM dual;

SELECT * FROM t1;
SELECT @x;

DROP TABLE t1;

let $MYSQLD_DATADIR= `select @@datadir`;

SET TIMESTAMP= DEFAULT;
CREATE TABLE t1 (fld1 VARCHAR(64) NOT NULL,
fld2 INT DEFAULT 0, PRIMARY KEY (fld1));

CREATE TABLE t2 (fld1 VARCHAR(64) NOT NULL,
fld2 INT(11) DEFAULT NULL, PRIMARY KEY (fld1));

INSERT INTO t1(fld1) VALUES (1100);
INSERT INTO t2 VALUES (1100, 40);

CREATE TRIGGER update_after_update
AFTER UPDATE ON t2 FOR EACH ROW
BEGIN
  UPDATE t1 SET t1.fld2 = t1.fld2 + 1
  WHERE t1.fld1 = NEW.fld1;

SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t2 (fld1) values (1100) ON DUPLICATE KEY UPDATE
fld2= 50;

SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t2 (fld1) values (1100) ON DUPLICATE KEY UPDATE
fld2= 50;

SELECT * FROM t1;
SELECT * FROM t2;
INSERT INTO t2 (fld1) values (1100) ON DUPLICATE KEY UPDATE
fld2= 60;

SELECT * FROM t1;
SELECT * FROM t2;
DROP TRIGGER update_after_update;
INSERT INTO t1(fld1) VALUES (1100);

CREATE TRIGGER update_before_update
BEFORE UPDATE ON t2 FOR EACH ROW
BEGIN
  UPDATE t1 SET t1.fld2 = t1.fld2 + 1
  WHERE t1.fld1 = NEW.fld1;

SELECT * FROM t1;
SELECT * FROM t2;

INSERT INTO t2 (fld1) values (1100) ON DUPLICATE KEY UPDATE
fld2= 50;

SELECT * FROM t1;
SELECT * FROM t2;

INSERT INTO t2 (fld1) values (1100) ON DUPLICATE KEY UPDATE
fld2= 50;

SELECT * FROM t1;
SELECT * FROM t2;

INSERT INTO t2 (fld1) values (1100) ON DUPLICATE KEY UPDATE
fld2= 60;

SELECT * FROM t1;
SELECT * FROM t2;
DROP TRIGGER update_before_update;
DROP TABLE t1, t2;

CREATE TABLE t1 (a INT);
CREATE TRIGGER _AI_1 AFTER INSERT ON t1 FOR EACH ROW SET
@t1_var=concat(@t1_var,'_AI_1');
CREATE TRIGGER _AI_2 AFTER INSERT ON t1 FOR EACH ROW SET
@t1_var=concat(@t1_var,'_AI_2');
CREATE TRIGGER _BU_2 BEFORE UPDATE ON t1 FOR EACH ROW SET
@t1_var=concat(@t1_var,'_BU_2');
CREATE TRIGGER _BD_2 BEFORE DELETE ON t1 FOR EACH ROW SET
@t1_var=concat(@t1_var,'_BD_2');
CREATE TRIGGER _AI_0 AFTER INSERT ON t1 FOR EACH ROW PRECEDES _AI_1 SET
@t1_var=concat(@t1_var,'_AI_0');
CREATE TRIGGER _AI_3 AFTER INSERT ON t1 FOR EACH ROW FOLLOWS _AI_2 SET
@t1_var=concat(@t1_var,'_AI_3');

SET @t1_var='Actual Result:   ';
INSERT INTO t1 VALUES (1);
SELECT @t1_var;

DROP TABLE t1;
CREATE TABLE t1 (i INT, j VARCHAR(32));
SET sql_mode='time_truncate_fractional';
CREATE TRIGGER t1_before_insert BEFORE INSERT ON t1 FOR EACH ROW INSERT INTO
t3 VALUES (1, NEW.i, NULL, CONCAT("BI: ", NEW.j));

SET sql_mode=default;
DROP TRIGGER t1_before_insert;
DROP TABLE t1;
CREATE TABLE t1 (i INT, j VARCHAR(32));
SET sql_mode=2147483648*2;
CREATE TRIGGER t1_before_insert BEFORE INSERT ON t1 FOR EACH ROW INSERT INTO
t3 VALUES (1, NEW.i, NULL, CONCAT("BI: ", NEW.j));

SET sql_mode=default;
DROP TRIGGER t1_before_insert;
DROP TABLE t1;
SET NAMES utf8mb3;

CREATE TABLE t1 (f1 INT, f2 INT);
CREATE TRIGGER cafe BEFORE INSERT ON t1 FOR EACH ROW SET @sum= @sum + NEW.f1;
CREATE TRIGGER café BEFORE INSERT ON t1 FOR EACH ROW SET @sum= @sum + NEW.f1;
CREATE TRIGGER CAFE BEFORE INSERT ON t1 FOR EACH ROW SET @sum= @sum + NEW.f1;
DROP TRIGGER CaFé;
CREATE TRIGGER очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_e
       BEFORE INSERT ON t1 FOR EACH ROW SET @sum= @sum + NEW.f1;
CREATE TRIGGER очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_é
       BEFORE INSERT ON t1 FOR EACH ROW SET @sum= @sum + NEW.f1;
CREATE TRIGGER очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_E
       BEFORE INSERT ON t1 FOR EACH ROW SET @sum= @sum + NEW.f1;
DROP TRIGGER очень_очень_очень_очень_очень_очень_очень_очень_длинная_строка_é;

DROP TABLE t1;
SET NAMES default;