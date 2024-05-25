DROP TABLE IF EXISTS t_proj_external;
CREATE TABLE t_proj_external
(
    k1 UInt32,
    k2 UInt32,
    k3 UInt32,
    value UInt32
)
ENGINE = MergeTree
ORDER BY tuple();
INSERT INTO t_proj_external SELECT 1, number%2, number%4, number FROM numbers(50000);
