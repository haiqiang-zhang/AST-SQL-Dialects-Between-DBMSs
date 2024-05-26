SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
DROP TABLE IF EXISTS test1;
DROP TABLE IF EXISTS test2;
DROP TABLE IF EXISTS test3;
CREATE TABLE test1 (n UInt64) ENGINE = MergeTree ORDER BY n SETTINGS index_granularity = 1;
CREATE TABLE test2 (s String) ENGINE = MergeTree ORDER BY s SETTINGS index_granularity = 1;
CREATE TABLE test3 (d Decimal(4, 3)) ENGINE = MergeTree ORDER BY d SETTINGS index_granularity = 1;
INSERT INTO test1 SELECT * FROM numbers(10000);
