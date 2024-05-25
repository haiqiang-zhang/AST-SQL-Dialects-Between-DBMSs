DROP TABLE IF EXISTS t_ttl_non_deterministic;
CREATE TABLE t_ttl_non_deterministic(A Int64) ENGINE = MergeTree ORDER BY A;
DROP TABLE t_ttl_non_deterministic;
CREATE TABLE t_ttl_non_deterministic(A Int64, B Int64) ENGINE = MergeTree ORDER BY A;
DROP TABLE t_ttl_non_deterministic;
