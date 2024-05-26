SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
DROP TABLE IF EXISTS t_max_rows_to_read;
CREATE TABLE t_max_rows_to_read (a UInt64)
ENGINE = MergeTree ORDER BY a
SETTINGS index_granularity = 4, index_granularity_bytes = '10Mi';
INSERT INTO t_max_rows_to_read SELECT number FROM numbers(100);
SET max_threads = 1;
SET optimize_read_in_order = 1;
