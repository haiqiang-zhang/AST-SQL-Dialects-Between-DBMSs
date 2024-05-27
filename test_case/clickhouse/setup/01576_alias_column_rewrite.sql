DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
 `timestamp` DateTime,
 `value` UInt64,
 `day` Date ALIAS toDate(timestamp),
 `day1` Date ALIAS day + 1,
 `day2` Date ALIAS day1 + 1,
 `time` DateTime ALIAS timestamp
)
ENGINE = MergeTree
PARTITION BY toYYYYMMDD(timestamp)
ORDER BY timestamp SETTINGS index_granularity = 1;
INSERT INTO test_table(timestamp, value) SELECT toDateTime('2020-01-01 12:00:00'), 1 FROM numbers(10);
INSERT INTO test_table(timestamp, value) SELECT toDateTime('2020-01-02 12:00:00'), 1 FROM numbers(10);
INSERT INTO test_table(timestamp, value) SELECT toDateTime('2020-01-03 12:00:00'), 1 FROM numbers(10);
set optimize_respect_aliases = 1;