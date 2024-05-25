drop table if exists t;
drop table if exists td;
create table t (val UInt32) engine = MergeTree order by val;
