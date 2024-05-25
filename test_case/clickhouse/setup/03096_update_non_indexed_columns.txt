DROP TABLE IF EXISTS test_03096;
CREATE TABLE test_03096
(
    `a` UInt32,
    `b` UInt32,
    `c` UInt32,
    `d` UInt32 MATERIALIZED 0,
    `sum` UInt32 MATERIALIZED (a + b) + c,
    INDEX idx (c, d) TYPE minmax GRANULARITY 1
)
ENGINE = MergeTree
ORDER BY a
SETTINGS index_granularity = 8192;
INSERT INTO test_03096 SELECT number, number % 42, number % 123 FROM numbers(10000);
