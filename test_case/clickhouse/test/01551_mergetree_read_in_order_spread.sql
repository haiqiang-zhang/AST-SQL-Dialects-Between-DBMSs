SET max_threads=3;
SET merge_tree_min_rows_for_concurrent_read=10000;
SET optimize_aggregation_in_order=1;
SET read_in_order_two_level_merge_threshold=1;
EXPLAIN PIPELINE SELECT key FROM data_01551 GROUP BY key, key/2;
DROP TABLE data_01551;
