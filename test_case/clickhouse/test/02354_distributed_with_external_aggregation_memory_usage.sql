set max_bytes_before_external_group_by = '2G',
    max_threads = 16,
    aggregation_memory_efficient_merge_threads = 16,
    distributed_aggregation_memory_efficient = 1,
    prefer_localhost_replica = 1,
    group_by_two_level_threshold = 100000,
    group_by_two_level_threshold_bytes = 1000000,
    max_block_size = 65505;
DROP TABLE t_2354_dist_with_external_aggr;
