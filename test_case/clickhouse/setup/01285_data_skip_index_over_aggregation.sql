SET optimize_on_insert = 0;
DROP TABLE IF EXISTS data_01285;
SET max_threads=1;
CREATE TABLE data_01285 (
    key   Int,
    value SimpleAggregateFunction(max, Nullable(Int)),
    INDEX value_idx assumeNotNull(value) TYPE minmax GRANULARITY 1
)
ENGINE=AggregatingMergeTree()
ORDER BY key;
