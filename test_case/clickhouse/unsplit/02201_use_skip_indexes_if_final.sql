CREATE TABLE data_02201 (
    key Int,
    value Int,
    INDEX idx value TYPE minmax GRANULARITY 1
)
Engine=AggregatingMergeTree()
ORDER BY key
PARTITION BY key;
INSERT INTO data_02201 SELECT number, number FROM numbers(10);
SELECT * FROM data_02201 FINAL WHERE value = 1 SETTINGS use_skip_indexes=1, use_skip_indexes_if_final=1, max_rows_to_read=1;
