DROP TABLE IF EXISTS test_parallel_replicas_unavailable_shards;
CREATE TABLE test_parallel_replicas_unavailable_shards (n UInt64) ENGINE=MergeTree() ORDER BY tuple();
INSERT INTO test_parallel_replicas_unavailable_shards SELECT * FROM numbers(10);
SET allow_experimental_parallel_reading_from_replicas=2, max_parallel_replicas=11, cluster_for_parallel_replicas='parallel_replicas', parallel_replicas_for_non_replicated_merge_tree=1;
SET send_logs_level='error';
