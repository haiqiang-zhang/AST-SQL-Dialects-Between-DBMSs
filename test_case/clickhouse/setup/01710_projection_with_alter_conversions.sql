drop table if exists t;
create table t (i int, j int, projection p (select i order by i)) engine MergeTree order by tuple();
insert into t values (1, 2);
