SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
drop table if exists t;
create table t (x UInt64) engine = MergeTree order by x;
insert into t select number from numbers_mt(10000000) settings max_insert_threads=8;
set allow_prefetched_read_pool_for_local_filesystem = 0;
