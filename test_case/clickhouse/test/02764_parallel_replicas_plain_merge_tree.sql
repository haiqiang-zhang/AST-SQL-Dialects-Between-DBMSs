CREATE TABLE IF NOT EXISTS parallel_replicas_plain (x String) ENGINE=MergeTree() ORDER BY x;
INSERT INTO parallel_replicas_plain SELECT toString(number) FROM numbers(10);
SET max_parallel_replicas=3, allow_experimental_parallel_reading_from_replicas=1, cluster_for_parallel_replicas='parallel_replicas';
SET send_logs_level='error';
SET parallel_replicas_for_non_replicated_merge_tree = 0;
SET parallel_replicas_for_non_replicated_merge_tree = 1;
DROP TABLE IF EXISTS parallel_replicas_plain;