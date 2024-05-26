SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
set max_threads = 16;
set allow_aggregate_partitions_independently = 1;
set force_aggregate_partitions_independently = 1;
set optimize_use_projections = 0;
set allow_prefetched_read_pool_for_local_filesystem = 0;
create table t1(a UInt32) engine=MergeTree order by tuple() partition by a % 4 settings index_granularity = 8192, index_granularity_bytes = 10485760;
