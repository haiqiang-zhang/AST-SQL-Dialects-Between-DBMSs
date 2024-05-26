SET convert_query_to_cnf = 0;
DROP TABLE IF EXISTS t0;
CREATE TABLE t0
(
    `c0` Int32,
    `c1` Int32 CODEC(NONE)
)
ENGINE = MergeTree()
ORDER BY tuple()
SETTINGS index_granularity = 8192;
INSERT INTO t0 VALUES (0, 0);
