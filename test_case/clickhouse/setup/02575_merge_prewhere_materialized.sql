DROP TABLE IF EXISTS m;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE m
(
    `a` String,
    `f` UInt8 DEFAULT 0
)
ENGINE = Merge(currentDatabase(), '^(t1|t2)$');
CREATE TABLE t1
(
    a String,
    f UInt8 MATERIALIZED 1
)
ENGINE = MergeTree
ORDER BY tuple()
SETTINGS index_granularity = 8192;
INSERT INTO t1 (a) VALUES ('OK');
CREATE TABLE t2
(
    a String,
    f UInt8 DEFAULT 2
)
ENGINE = MergeTree
ORDER BY tuple()
SETTINGS index_granularity = 8192;
INSERT INTO t2 (a) VALUES ('OK');
