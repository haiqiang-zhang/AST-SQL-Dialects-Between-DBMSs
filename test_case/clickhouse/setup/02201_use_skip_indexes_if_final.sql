CREATE TABLE data_02201 (
    key Int,
    value Int,
    INDEX idx value TYPE minmax GRANULARITY 1
)
Engine=AggregatingMergeTree()
ORDER BY key
PARTITION BY key;
INSERT INTO data_02201 SELECT number, number FROM numbers(10);
