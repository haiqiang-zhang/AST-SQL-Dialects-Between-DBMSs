SET allow_experimental_analyzer = 1;
SET allow_experimental_parallel_reading_from_replicas = 1, parallel_replicas_for_non_replicated_merge_tree = 1, cluster_for_parallel_replicas = 'test_cluster_one_shard_three_replicas_localhost', max_parallel_replicas = 3, parallel_replicas_min_number_of_rows_per_replica=0;
DROP TABLE numbers_1e6__fuzz_34;
DROP TABLE numbers_1e6__fuzz_33;
