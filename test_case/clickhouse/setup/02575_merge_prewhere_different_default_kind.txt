DROP TABLE IF EXISTS m;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE m
(
    a String,
    date Date,
    f UInt8
)
ENGINE = Merge(currentDatabase(), '^(t1|t2)$');
CREATE TABLE t1
(
    a String,
    date Date,
    f UInt8 ALIAS 0
)
ENGINE = MergeTree
ORDER BY tuple()
SETTINGS index_granularity = 8192;
INSERT INTO t1 (a) VALUES ('OK');
