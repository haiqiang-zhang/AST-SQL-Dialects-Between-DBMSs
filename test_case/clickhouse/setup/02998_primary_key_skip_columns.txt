DROP TABLE IF EXISTS test;
CREATE TABLE test (a UInt64, b UInt64, c UInt64) ENGINE = MergeTree ORDER BY (a, b, c) SETTINGS index_granularity = 1, primary_key_ratio_of_unique_prefix_values_to_skip_suffix_columns = 1;
INSERT INTO test SELECT sipHash64(number, 1), sipHash64(number, 2), sipHash64(number, 3) FROM numbers(100000);
