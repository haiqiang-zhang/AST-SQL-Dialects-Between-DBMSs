SET merge_tree_read_split_ranges_into_intersecting_and_non_intersecting_injection_probability = 0.0;
DROP TABLE IF EXISTS t_sparse_distinct;
CREATE TABLE t_sparse_distinct (id UInt32, v String)
ENGINE = MergeTree
ORDER BY id
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.9;
