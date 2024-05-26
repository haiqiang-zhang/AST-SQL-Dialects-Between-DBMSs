CREATE TABLE order_by_const
(
    `a` UInt64,
    `b` UInt64,
    `c` UInt64,
    `d` UInt64
)
ENGINE = MergeTree
ORDER BY (a, b)
SETTINGS index_granularity = 8192;
