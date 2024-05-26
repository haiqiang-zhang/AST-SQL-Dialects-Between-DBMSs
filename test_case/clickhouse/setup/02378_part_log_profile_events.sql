DROP TABLE IF EXISTS test;
CREATE TABLE test (key UInt64, val UInt64) engine = MergeTree Order by key PARTITION BY key >= 128;
SET max_block_size = 64, max_insert_block_size = 64, min_insert_block_size_rows = 64;
INSERT INTO test SELECT number AS key, sipHash64(number) AS val FROM numbers(512);
