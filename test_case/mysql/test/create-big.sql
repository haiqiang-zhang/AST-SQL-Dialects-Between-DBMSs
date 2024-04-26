
-- Create auxilliary connections
connect (addconroot1, localhost, root,,);
drop table if exists t1,t2,t3,t4,t5;
set debug_sync='RESET';

--
-- Tests for concurrency problems in CREATE TABLE ... SELECT
--
-- We introduce delays between various stages of table creation
-- and check that other statements dealing with this table cannot
-- interfere during those delays.
--
-- What happens in situation when other statement messes with
-- table to be created before it is created ?
-- Concurrent CREATE TABLE
set debug_sync='create_table_select_before_create SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "create table t1 (j char(5))";
set debug_sync='now SIGNAL go';
drop table t1;

-- Concurrent CREATE TABLE ... SELECT
set debug_sync='create_table_select_before_create SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "create table t1 select 'Test' as j";
set debug_sync='now SIGNAL go';
drop table t1;

-- Concurrent CREATE TABLE LIKE
create table t3 (j char(5));
set debug_sync='create_table_select_before_create SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "create table t1 like t3";
set debug_sync='now SIGNAL go';
drop table t1;

-- Concurrent RENAME TABLE
set debug_sync='create_table_select_before_create SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "rename table t3 to t1";
set debug_sync='now SIGNAL go';
drop table t1;

-- Concurrent ALTER TABLE RENAME
set debug_sync='create_table_select_before_create SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "alter table t3 rename to t1";
set debug_sync='now SIGNAL go';
drop table t1;

-- Concurrent ALTER TABLE RENAME which also adds column
set debug_sync='create_table_select_before_create SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "alter table t3 rename to t1, add k int";
set debug_sync='now SIGNAL go';
drop table t1,t3;

-- What happens if other statement sneaks in after the table
-- creation but before its opening ?
set debug_sync='create_table_select_before_open SIGNAL parked WAIT_FOR go';

-- Concurrent DROP TABLE
set debug_sync='create_table_select_before_open SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "drop table t1";
set debug_sync='now SIGNAL go';

-- Concurrent RENAME TABLE
set debug_sync='create_table_select_before_create SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "rename table t1 to t2";
set debug_sync='now SIGNAL go';
drop table t2;

-- Concurrent SELECT
set debug_sync='create_table_select_before_create SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "select * from t1";
set debug_sync='now SIGNAL go';
drop table t1;

-- Concurrent INSERT
set debug_sync='create_table_select_before_create SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "insert into t1 values (2)";
set debug_sync='now SIGNAL go';
select * from t1;
drop table t1;

-- Concurrent CREATE TRIGGER 
set @a:=0;
set debug_sync='create_table_select_before_create SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "create trigger t1_bi before insert on t1 for each row set @a:=1";
set debug_sync='now SIGNAL go';
select @a;
drop table t1;

-- Okay, now the same tests for the potential gap between open and lock
set debug_sync='create_table_select_before_lock SIGNAL parked WAIT_FOR go';

-- Concurrent DROP TABLE
--send create table t1 select 1 as i;
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "drop table t1";
set debug_sync='now SIGNAL go';

-- Concurrent RENAME TABLE
set debug_sync='create_table_select_before_lock SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "rename table t1 to t2";
set debug_sync='now SIGNAL go';
drop table t2;

-- Concurrent SELECT
set debug_sync='create_table_select_before_lock SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "select * from t1";
set debug_sync='now SIGNAL go';
drop table t1;

-- Concurrent INSERT
set debug_sync='create_table_select_before_lock SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "insert into t1 values (2)";
set debug_sync='now SIGNAL go';
select * from t1;
drop table t1;

-- Concurrent CREATE TRIGGER 
set @a:=0;
set debug_sync='create_table_select_before_lock SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "create trigger t1_bi before insert on t1 for each row set @a:=1";
set debug_sync='now SIGNAL go';
select @a;
drop table t1;

-- Concurrent DROP TABLE
set debug_sync='create_table_select_before_lock SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "drop table t1";
set debug_sync='now SIGNAL go';

-- Concurrent CREATE TRIGGER
create table t1 (i int);
set @a:=0;
set debug_sync='create_table_select_before_check_if_exists SIGNAL parked WAIT_FOR go';
create trigger t1_bi before insert on t1 for each row set @a:=1;
select @a;
select * from t1;
drop table t1;

-- Tests for possible concurrency issues with CREATE TABLE ... LIKE
--
-- Bug #18950 "create table like does not obtain LOCK_open"
-- Bug #23667 "CREATE TABLE LIKE is not isolated from alteration by other
--             connections"
--
-- Again the idea of this test is that we introduce artificial delays on
-- various stages of table creation and check that concurrent statements
-- for tables from CREATE TABLE ... LIKE are not interfering.

--disable_warnings
drop table if exists t1,t2;
set debug_sync='RESET';

-- What happens if some statements sneak in right after we have
-- acquired locks and opened source table ?
create table t1 (i int);
set debug_sync='create_table_like_after_open SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
insert into t1 values (1);
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "drop table t1";
set debug_sync='now SIGNAL go';
drop table t2;

-- Now check the gap between table creation and binlogging
create table t1 (i int);
set debug_sync='create_table_like_before_binlog SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "insert into t2 values (1)";
set debug_sync='now SIGNAL go';
drop table t2;
set debug_sync='create_table_like_before_binlog SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "drop table t2";
set debug_sync='now SIGNAL go';
set debug_sync='create_table_like_before_binlog SIGNAL parked WAIT_FOR go';
set debug_sync='now WAIT_FOR parked';
let $wait_condition=
    select count(*) = 1 from information_schema.processlist
    where state = "Waiting for table metadata lock" and
          info = "drop table t1";
set debug_sync='now SIGNAL go';
drop table t2;

set debug_sync='RESET';

--
-- InnoDB has separate internal limits

let $colnum= 1016;
let $str= c text;
{
  let $str= c$colnum int, $str;
  dec $colnum;
ALTER TABLE t1 ADD COLUMN too_much int;
DROP TABLE t1;

let $str= c1017 int, $str;

--
-- InnoDB has separate internal limits

let $colnum= 1016;
let $str= c1017 ENUM('a');
{
  let $str= c$colnum ENUM('a$colnum'), $str;
  dec $colnum;
ALTER TABLE t1 ADD COLUMN too_much ENUM('a9999');
DROP TABLE t1;

let $str= $str, too_much ENUM('a9999');

--
-- InnoDB has separate internal limits

let $colnum= 1016;
let $str= c1017 SET('a');
{
  let $str= c$colnum SET('a$colnum'), $str;
  dec $colnum;
ALTER TABLE t1 ADD COLUMN too_much SET('a9999');
DROP TABLE t1;

let $str= $str, too_much SET('a9999');

let $elenum= 65534;
let $str= col ENUM('a0';
{
  let $str= $str, 'a$elenum';
  dec $elenum;
INSERT INTO t1 values ('a0'), ('a1'), ('a2');
SELECT * FROM t1;
DROP TABLE t1;

let $iter=25;
let $str_250=;
{
  let $str_250=0123456789$str_250;
  dec $iter;
DROP TABLE t1;
DROP TABLE t1;
