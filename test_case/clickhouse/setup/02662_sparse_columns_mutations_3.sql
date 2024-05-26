SET mutations_sync = 2;
DROP TABLE IF EXISTS t_sparse_mutations_3;
CREATE TABLE t_sparse_mutations_3 (key UInt8, id UInt64, s String)
ENGINE = MergeTree ORDER BY id PARTITION BY key
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.9;
INSERT INTO t_sparse_mutations_3 SELECT 1, number, toString(tuple(1, 0, '1', '0', '')) FROM numbers (10000);
