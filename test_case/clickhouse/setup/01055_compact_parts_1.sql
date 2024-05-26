drop table if exists mt_compact;
drop table if exists mt_compact_2;
create table mt_compact (a Int, s String) engine = MergeTree order by a partition by a
settings index_granularity_bytes = 0;
