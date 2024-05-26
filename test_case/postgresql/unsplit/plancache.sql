create temp view v1 as
  select 2+2 as f1;
create or replace temp view v1 as
  select 2+2+4 as f1;
create schema s1
  create table abc (f1 int);
create schema s2
  create table abc (f1 int);
insert into s1.abc values(123);
insert into s2.abc values(456);
set search_path = s1;
prepare p1 as select f1 from abc;
execute p1;
set search_path = s2;
select f1 from abc;
execute p1;
alter table s1.abc add column f2 float8;
execute p1;
drop schema s1 cascade;
drop schema s2 cascade;
reset search_path;
create temp sequence seq;
prepare p2 as select nextval('seq');
execute p2;
drop sequence seq;
create temp sequence seq;
execute p2;
create temp table temptable as select * from generate_series(1,3) as f1;
create temp view vv as select * from temptable;
create table pc_list_parted (a int) partition by list(a);
create table pc_list_part_null partition of pc_list_parted for values in (null);
create table pc_list_part_1 partition of pc_list_parted for values in (1);
create table pc_list_part_def partition of pc_list_parted default;
prepare pstmt_def_insert (int) as insert into pc_list_part_def values($1);
create table pc_list_part_2 partition of pc_list_parted for values in (2);
alter table pc_list_parted detach partition pc_list_part_null;
execute pstmt_def_insert(null);
drop table pc_list_part_1;
drop table pc_list_parted, pc_list_part_null;
deallocate pstmt_def_insert;
create table test_mode (a int);
insert into test_mode select 1 from generate_series(1,1000) union all select 2;
create index on test_mode (a);
analyze test_mode;
prepare test_mode_pp (int) as select count(*) from test_mode where a = $1;
select name, generic_plans, custom_plans from pg_prepared_statements
  where  name = 'test_mode_pp';
set plan_cache_mode to auto;
explain (costs off) execute test_mode_pp(2);
select name, generic_plans, custom_plans from pg_prepared_statements
  where  name = 'test_mode_pp';
set plan_cache_mode to force_generic_plan;
select name, generic_plans, custom_plans from pg_prepared_statements
  where  name = 'test_mode_pp';
set plan_cache_mode to auto;
execute test_mode_pp(1);
select name, generic_plans, custom_plans from pg_prepared_statements
  where  name = 'test_mode_pp';
select name, generic_plans, custom_plans from pg_prepared_statements
  where  name = 'test_mode_pp';
set plan_cache_mode to force_custom_plan;
select name, generic_plans, custom_plans from pg_prepared_statements
  where  name = 'test_mode_pp';
drop table test_mode;
