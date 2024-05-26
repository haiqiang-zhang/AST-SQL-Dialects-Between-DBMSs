DROP TABLE IF EXISTS test;
CREATE TABLE test
(
  `id` Nullable(String),
  `status` Nullable(Enum8('NEW' = 0, 'CANCEL' = 1)),
  `nested.nestedType` Array(Nullable(String)),
  `partition` Date
) ENGINE = MergeTree() PARTITION BY partition
ORDER BY
  partition SETTINGS index_granularity = 8192;
INSERT INTO test VALUES ('1', 'NEW', array('a', 'b'), now());
