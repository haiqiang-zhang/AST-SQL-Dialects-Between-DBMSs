DROP TABLE IF EXISTS t;
CREATE TABLE t
(
  key1 UInt64,
  value1 String,
  value2 String,
  INDEX idx (value1) TYPE set(10) GRANULARITY 1
)
ENGINE MergeTree ORDER BY key1 SETTINGS index_granularity = 1;
INSERT INTO t SELECT toDate('2019-10-01') + number % 3, toString(number), toString(number) from numbers(9);
