DROP TABLE IF EXISTS test;
CREATE TABLE test (k UInt64, v String)
ENGINE = MergeTree
ORDER BY k;
INSERT INTO test SELECT number, toString(number) FROM numbers(100);
SET allow_experimental_parallel_reading_from_replicas = 2, max_parallel_replicas = 3, prefer_localhost_replica = 0, parallel_replicas_for_non_replicated_merge_tree=1, cluster_for_parallel_replicas='test_cluster_one_shard_three_replicas_localhost';
