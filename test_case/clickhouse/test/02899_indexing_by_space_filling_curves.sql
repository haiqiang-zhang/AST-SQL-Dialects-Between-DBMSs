SELECT count() FROM test WHERE x >= 10 AND x <= 20 AND y >= 20 AND y <= 30;
SET max_rows_to_read = 8192, force_primary_key = 1, analyze_index_with_space_filling_curves = 0;
DROP TABLE test;
CREATE TABLE test (x UInt32, y UInt32) ENGINE = MergeTree ORDER BY mortonEncode(x, y) SETTINGS index_granularity = 1;
SET max_rows_to_read = 0;
INSERT INTO test SELECT number DIV 32, number % 32 FROM numbers(1024);
SET max_rows_to_read = 200, force_primary_key = 1, analyze_index_with_space_filling_curves = 1;
DROP TABLE test;
