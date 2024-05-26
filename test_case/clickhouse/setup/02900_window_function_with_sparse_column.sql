CREATE TABLE test1
(
    id String,
    time DateTime64(9),
    key Int64,
    value Bool,
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(time)
ORDER BY (key, id, time);
