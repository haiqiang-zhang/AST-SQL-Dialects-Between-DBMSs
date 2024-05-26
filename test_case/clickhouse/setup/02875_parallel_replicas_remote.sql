DROP TABLE IF EXISTS tt;
CREATE TABLE tt (n UInt64) ENGINE=MergeTree() ORDER BY tuple();
INSERT INTO tt SELECT * FROM numbers(10);
SET allow_experimental_parallel_reading_from_replicas=1, max_parallel_replicas=3, parallel_replicas_for_non_replicated_merge_tree=1;
