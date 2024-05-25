DROP TABLE IF EXISTS t_1;
DROP TABLE IF EXISTS t_random_1;
CREATE TABLE t_1
(
    `order_0` UInt64,
    `ordinary_1` UInt32,
    `p_time` Date,
    `computed` ALIAS 'computed_' || cast(`p_time` AS String),
    `granule` MATERIALIZED cast(`order_0` / 0x2000 AS UInt64) % 3,
    INDEX `index_granule` `granule` TYPE minmax GRANULARITY 1
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(p_time)
ORDER BY order_0
SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
CREATE TABLE t_random_1
(
    `ordinary_1` UInt32
)
ENGINE = GenerateRandom(1, 5, 3);
INSERT INTO t_1 select rowNumberInAllBlocks(), *, '1984-01-01' from t_random_1 limit 1000000;
