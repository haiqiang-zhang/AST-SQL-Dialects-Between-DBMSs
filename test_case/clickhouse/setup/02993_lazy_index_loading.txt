DROP TABLE IF EXISTS test;
CREATE TABLE test (s String) ENGINE = MergeTree ORDER BY s SETTINGS index_granularity = 1;
INSERT INTO test SELECT randomString(1000) FROM numbers(100000);
