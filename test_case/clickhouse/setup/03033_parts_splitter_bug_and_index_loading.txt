create table t(a UInt32, b UInt32) engine=MergeTree order by (a, b) settings index_granularity=1;
