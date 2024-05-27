DROP TABLE IF EXISTS t_sparse_full;
CREATE TABLE t_sparse_full (id UInt64, u UInt64, s String)
ENGINE = MergeTree ORDER BY id
SETTINGS index_granularity = 32, index_granularity_bytes = '10Mi',
ratio_of_defaults_for_sparse_serialization = 0.1;