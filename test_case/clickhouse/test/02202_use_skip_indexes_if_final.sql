CREATE TABLE data_02201 (
    key Int,
    value_max SimpleAggregateFunction(max, Int),
    INDEX idx value_max TYPE minmax GRANULARITY 1
)
Engine=AggregatingMergeTree()
ORDER BY key
PARTITION BY key;
SYSTEM STOP MERGES data_02201;
INSERT INTO data_02201 SELECT number, number FROM numbers(10);
INSERT INTO data_02201 SELECT number, number+1 FROM numbers(10);
SELECT * FROM data_02201 FINAL WHERE value_max = 1 ORDER BY key, value_max SETTINGS use_skip_indexes=1, use_skip_indexes_if_final=0;
SELECT * FROM data_02201 FINAL WHERE value_max = 1 ORDER BY key, value_max SETTINGS use_skip_indexes=1, use_skip_indexes_if_final=1;
