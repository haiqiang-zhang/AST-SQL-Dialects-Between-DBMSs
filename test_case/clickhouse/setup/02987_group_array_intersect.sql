SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
DROP TABLE IF EXISTS test_empty;
CREATE TABLE test_empty (a Array(Int64)) engine=MergeTree ORDER BY a;
INSERT INTO test_empty VALUES ([]);
