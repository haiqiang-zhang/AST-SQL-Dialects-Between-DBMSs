DROP TABLE IF EXISTS table_with_compact_parts;
CREATE TABLE table_with_compact_parts
(
  date Date,
  key UInt64,
  value1 String,
  value2 String,
  value3 String
)
ENGINE = MergeTree()
PARTITION BY date
ORDER BY key
settings index_granularity = 8,
min_rows_for_wide_part = 10,
min_bytes_for_wide_part = '10G';
INSERT INTO table_with_compact_parts SELECT toDate('2019-10-01') + number % 3, number, toString(number), toString(number), toString(number) from numbers(9);
