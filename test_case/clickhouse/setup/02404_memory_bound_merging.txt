drop table if exists pr_t;
drop table if exists dist_t_different_dbs;
drop table if exists shard_1.t_different_dbs;
drop table if exists t_different_dbs;
drop table if exists dist_t;
drop table if exists t;
create table t(a UInt64, b UInt64) engine=MergeTree order by a;
