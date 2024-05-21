SET allow_experimental_analyzer=1;
SET prefer_localhost_replica=0;
create table "t0" (a Int64, b Int64) engine = MergeTree() partition by a order by a;
insert into t0 values (1, 10), (2, 12);
