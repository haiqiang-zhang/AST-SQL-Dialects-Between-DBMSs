SELECT * FROM test_bloom_filter_index WHERE (`uint16`, `index_column`) IN (SELECT toUInt16(2), toUInt64(2));
DROP TABLE IF EXISTS test_bloom_filter_index;
