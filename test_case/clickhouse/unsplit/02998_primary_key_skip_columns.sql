DROP TABLE IF EXISTS test;
CREATE TABLE test (a UInt64, b UInt64, c UInt64) ENGINE = MergeTree ORDER BY (a, b, c) SETTINGS index_granularity = 1, primary_key_ratio_of_unique_prefix_values_to_skip_suffix_columns = 1;
INSERT INTO test SELECT sipHash64(number, 1), sipHash64(number, 2), sipHash64(number, 3) FROM numbers(100000);
SELECT count() FROM test;
SELECT 'Key size: ', round(sum(primary_key_bytes_in_memory), -5) FROM system.parts WHERE database = currentDatabase() AND table = 'test';
ALTER TABLE test MODIFY SETTING primary_key_ratio_of_unique_prefix_values_to_skip_suffix_columns = 0.9;
DETACH TABLE test;
ATTACH TABLE test;
DROP TABLE test;
