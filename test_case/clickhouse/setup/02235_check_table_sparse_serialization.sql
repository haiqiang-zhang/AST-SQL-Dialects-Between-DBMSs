DROP TABLE IF EXISTS t_sparse_02235;
CREATE TABLE t_sparse_02235 (a UInt8) ENGINE = MergeTree ORDER BY tuple()
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.9;
