SELECT count() FROM test_table WHERE value = '1' SETTINGS force_data_skipping_indices = 'value_idx';
DROP TABLE test_table;
