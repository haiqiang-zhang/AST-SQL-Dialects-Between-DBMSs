drop table if exists t;
drop table if exists t1;
create table t(id UInt32) engine MergeTree order by id as select 1;
create table t1(a Array(UInt32)) ENGINE = MergeTree ORDER BY tuple() as select [1,2];
