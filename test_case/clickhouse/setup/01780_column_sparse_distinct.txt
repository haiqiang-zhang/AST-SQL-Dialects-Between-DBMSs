DROP TABLE IF EXISTS t_sparse_distinct;
CREATE TABLE t_sparse_distinct (id UInt32, v UInt64)
ENGINE = MergeTree
ORDER BY id
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.9;
