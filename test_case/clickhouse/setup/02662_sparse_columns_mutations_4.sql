SET mutations_sync = 2;
DROP TABLE IF EXISTS t_sparse_mutations_4;
CREATE TABLE t_sparse_mutations_4 (k UInt64, v UInt64)
ENGINE = MergeTree ORDER BY k
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.9;
INSERT INTO t_sparse_mutations_4 SELECT number, 0 FROM numbers(10000);
