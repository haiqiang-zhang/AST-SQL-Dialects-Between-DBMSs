
-- Verify that the protocol isn't violated if we ask for profiling info
-- before profiling has recorded anything.
--disable_warnings
show profiles;

-- default is OFF
show session variables like 'profil%';
select @@profiling;

-- But size is okay
--disable_warnings
set @start_value= @@global.profiling_history_size;
set global profiling_history_size=100;

-- turn on for testing
--disable_warnings
set session profiling = ON;
set session profiling_history_size=30;

-- verify it is active
show session variables like 'profil%';
select @@profiling;

--   Profiling is a descriptive look into the way the server operated
--   in retrospect.  Chad doesn't think it's wise to include the result
--   log, as this creates a proscriptive specification about how the 
--   server should work in the future -- or it forces everyone who 
--   changes the server significantly to record the test results again,
--   and that violates the spirit of our tests.  Please don't include
--   execution-specific data here, as in all of the "show profile" and
--   information_schema.profiling results.

create table t1 (
  a int,
  b int
);
insert into t1 values (1,1), (2,null), (3, 4);
insert into t1 values (5,1), (6,null), (7, 4);
insert into t1 values (1,1), (2,null), (3, 4);
insert into t1 values (5,1), (6,null), (7, 4);
select max(x) from (select sum(a) as x from t1 group by b) as teeone;
insert into t1 select * from t1;
select count(*) from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
select count(*) from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
select count(*) from t1;
select sum(a) from t1;
select sum(a) from t1 group by b;
select sum(a) + sum(b) from t1 group by b;
select max(x) from (select sum(a) as x from t1 group by b) as teeone;
select '012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890' as big_string;

select * from information_schema.profiling;
select query_id, state, duration from information_schema.profiling;
select query_id, sum(duration) from information_schema.profiling group by query_id;
select query_id, count(*) from information_schema.profiling group by query_id;
select sum(duration) from information_schema.profiling;

-- Broken down into number of stages and duration of each query.
select query_id, count(*), sum(duration) from information_schema.profiling group by query_id;
select CPU_user, CPU_system, Context_voluntary, Context_involuntary, Block_ops_in, Block_ops_out, Messages_sent, Messages_received, Page_faults_major, Page_faults_minor, Swaps, Source_function, Source_file, Source_line from information_schema.profiling;
drop table if exists t1, t2, t3;
create table t1 (id int );
create table t2 (id int not null);
create table t3 (id int not null primary key);
insert into t1 values (1), (2), (3);
insert into t2 values (1), (2), (3);
insert into t3 values (1), (2), (3);

select * from t1;

delete from t1;
insert into t1 values (1), (2), (3);
insert into t1 values (1), (2), (3);

select * from t1;

-- Turning profiling off does freeze it
set session profiling = OFF;
select sum(id) from t1;

--#  Verify that the various juggling of THD contexts doesn't affect profiling.

--#  Functions and procedures
--disable_warnings
set session profiling = ON;
select @@profiling;
create function f1() returns varchar(50) return 'hello';
select @@profiling;
select * from t1 where id <> f1();
select @@profiling;
set session profiling = OFF;
drop table if exists profile_log;
create table profile_log (how_many int);
drop procedure if exists p1;
drop procedure if exists p2;
drop procedure if exists p3;
create procedure p1 () 
  modifies sql data 
begin 
  set profiling = ON;
  select 'This p1 should show up in profiling';
  insert into profile_log select count(*) from information_schema.profiling;
create procedure p2() 
  deterministic 
begin 
  set profiling = ON;
  select 'This p2 should show up in profiling';
create procedure p3 () 
  reads sql data 
begin 
  set profiling = ON;
  select 'This p3 should show up in profiling';
select * from profile_log;
select * from profile_log;
select * from profile_log;
set session profiling = OFF;
set session profiling = OFF;

drop procedure if exists p1;
drop procedure if exists p2;
drop procedure if exists p3;
drop table if exists profile_log;

--#  Triggers
--disable_warnings
set session profiling = ON;
drop table if exists t2;
create table t2 (id int not null);
create trigger t2_bi before insert on t2 for each row set @x=0;
select @@profiling;
insert into t2 values (1), (2), (3);
select @@profiling;

--#  ALTER TABLE
--disable_warnings
set session profiling = ON;
drop table if exists t1, t2;
create table t1 (id int not null primary key);
create table t2 (id int not null primary key, id1 int not null);
select @@profiling;
alter table t2 add foreign key (id1) references t1 (id) on delete cascade;
select @@profiling;

--#  Table LOCKing
lock table t1 write;
select @@profiling;
select @@profiling;

--#  Transactions
set autocommit=0;
select @@profiling, @@autocommit;
select @@profiling;
insert into t1 values (1);
insert into t2 values (1,1);
delete from t1 where id = 1;
select @@profiling;
select @@profiling;
select @@profiling;
select @@profiling;

drop table if exists t2, t1, t3;
drop view if exists v1;
drop function if exists f1;

--# Multiple queries in one packet.  Combo statements don't work with ps-proto.
----eval select 1;
--# two continuations, one starting
--select state from information_schema.profiling where seq=1 order by query_id desc limit 3;

SET profiling= 1;


--# last thing in the file
--disable_warnings
set session profiling = OFF;
set global profiling_history_size= @start_value;
