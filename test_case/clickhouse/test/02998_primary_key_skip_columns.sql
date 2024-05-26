SELECT count() FROM test;
SELECT 'Key size: ', round(sum(primary_key_bytes_in_memory), -5) FROM system.parts WHERE database = currentDatabase() AND table = 'test';
ALTER TABLE test MODIFY SETTING primary_key_ratio_of_unique_prefix_values_to_skip_suffix_columns = 0.9;
DETACH TABLE test;
ATTACH TABLE test;
DROP TABLE test;
