CREATE TABLE data_02201 (
    key Int,
    value_max SimpleAggregateFunction(max, Int),
    INDEX idx value_max TYPE minmax GRANULARITY 1
)
Engine=AggregatingMergeTree()
ORDER BY key
PARTITION BY key;
