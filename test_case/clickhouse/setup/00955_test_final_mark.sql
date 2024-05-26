SET send_logs_level = 'fatal';
DROP TABLE IF EXISTS mt_with_pk;
CREATE TABLE mt_with_pk (
  d Date DEFAULT '2000-01-01',
  x DateTime,
  y Array(UInt64),
  z UInt64,
  n Nested (Age UInt8, Name String),
  w Int16 DEFAULT 10
) ENGINE = MergeTree()
PARTITION BY toYYYYMM(d) ORDER BY (x, z) SETTINGS index_granularity_bytes=10000;
