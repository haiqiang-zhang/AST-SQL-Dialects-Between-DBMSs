SET mutations_sync = 2;
DROP TABLE IF EXISTS t_sparse_mutations_1;
CREATE TABLE t_sparse_mutations_1 (key UInt8, id UInt64, s String)
ENGINE = MergeTree ORDER BY id PARTITION BY key
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.9;
INSERT INTO t_sparse_mutations_1 SELECT 1, number, if (number % 21 = 0, 'foo', '') FROM numbers (10000);
