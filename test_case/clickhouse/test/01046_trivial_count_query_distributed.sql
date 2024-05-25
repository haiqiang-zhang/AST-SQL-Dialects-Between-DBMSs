DROP TABLE IF EXISTS test_count;
CREATE TABLE test_count (`pt` Date) ENGINE = MergeTree PARTITION BY pt ORDER BY pt SETTINGS index_granularity = 8192;
INSERT INTO test_count values ('2019-12-12');
DROP TABLE test_count;
