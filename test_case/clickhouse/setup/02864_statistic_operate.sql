DROP TABLE IF EXISTS t1;
SET allow_experimental_statistic = 1;
SET allow_statistic_optimize = 1;
CREATE TABLE t1
(
    a Float64 STATISTIC(tdigest),
    b Int64 STATISTIC(tdigest),
    pk String,
) Engine = MergeTree() ORDER BY pk
SETTINGS min_bytes_for_wide_part = 0;
