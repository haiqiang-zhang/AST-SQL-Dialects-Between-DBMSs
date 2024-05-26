DROP TABLE IF EXISTS t_sparse_intersect;
CREATE TABLE t_sparse_intersect (a UInt64, c Int64) ENGINE = MergeTree
ORDER BY tuple() SETTINGS ratio_of_defaults_for_sparse_serialization = 0.8;
