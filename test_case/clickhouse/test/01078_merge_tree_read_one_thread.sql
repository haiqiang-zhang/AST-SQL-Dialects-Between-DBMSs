-- Output slightly different plan
drop table if exists t;
create table t (a Int, b Int) engine = MergeTree order by (a, b) settings index_granularity = 400;
insert into t select 0, 0 from numbers(50);
insert into t select 0, 1  from numbers(350);
insert into t select 1, 2  from numbers(400);
insert into t select 2, 2  from numbers(400);
insert into t select 3, 0 from numbers(100);
set max_threads = 1;
optimize table t final;
select sum(a) from t where a in (0, 3) and b = 0;
drop table t;