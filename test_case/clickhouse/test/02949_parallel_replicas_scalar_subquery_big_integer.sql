SET allow_experimental_parallel_reading_from_replicas = 1, max_parallel_replicas = 2, cluster_for_parallel_replicas = 'test_cluster_one_shard_three_replicas_localhost', prefer_localhost_replica = 0, parallel_replicas_for_non_replicated_merge_tree = 1;
DROP TABLE test;
