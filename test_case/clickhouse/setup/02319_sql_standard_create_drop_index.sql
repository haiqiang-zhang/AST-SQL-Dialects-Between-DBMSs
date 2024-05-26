drop table if exists t_index;
create table t_index(a int, b String) engine=MergeTree() order by a;
create index i_a on t_index(a) TYPE minmax GRANULARITY 4;
create index if not exists i_a on t_index(a) TYPE minmax GRANULARITY 2;
create index i_b on t_index(b) TYPE bloom_filter GRANULARITY 2;
