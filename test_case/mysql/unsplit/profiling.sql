select @@profiling;
select @@profiling;
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
insert into t1 select * from t1;
insert into t1 select * from t1;
insert into t1 select * from t1;
select sum(a) from t1;
select sum(a) + sum(b) from t1 group by b;
select '012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890012345678900123456789001234567890' as big_string;
select * from information_schema.profiling;
select query_id, state, duration from information_schema.profiling;
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
select @@profiling;
select @@profiling;
select @@profiling;
drop table if exists profile_log;
create table profile_log (how_many int);
drop procedure if exists p1;
drop procedure if exists p2;
drop procedure if exists p3;
select 'This p1 should show up in profiling';
insert into profile_log select count(*) from information_schema.profiling;
select 'This p2 should show up in profiling';
select 'This p3 should show up in profiling';
select * from profile_log;
select * from profile_log;
select * from profile_log;
drop procedure if exists p1;
drop procedure if exists p2;
drop procedure if exists p3;
drop table if exists profile_log;
drop table if exists t2;
create table t2 (id int not null);
select @@profiling;
insert into t2 values (1), (2), (3);
select @@profiling;
drop table if exists t1, t2;
create table t1 (id int not null primary key);
create table t2 (id int not null primary key, id1 int not null);
select @@profiling;
alter table t2 add foreign key (id1) references t1 (id) on delete cascade;
select @@profiling;
lock table t1 write;
select @@profiling;
unlock table;
select @@profiling;
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
PREPARE s FROM 'DO 1';
DEALLOCATE PREPARE s;
