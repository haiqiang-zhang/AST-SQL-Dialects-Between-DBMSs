SET allow_suspicious_low_cardinality_types=1;
SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
DROP TABLE IF EXISTS single_column_bloom_filter;
CREATE TABLE single_column_bloom_filter (u64 UInt64, i32 Int32, i64 UInt64, INDEX idx (i32) TYPE bloom_filter GRANULARITY 1) ENGINE = MergeTree() ORDER BY u64 SETTINGS index_granularity = 6, index_granularity_bytes = '10Mi';
INSERT INTO single_column_bloom_filter SELECT number AS u64, number AS i32, number AS i64 FROM system.numbers LIMIT 100;
