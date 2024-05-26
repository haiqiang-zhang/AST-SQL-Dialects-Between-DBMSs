SELECT count() FROM test_table WHERE id = 1 SETTINGS force_primary_key = 1;
DROP TABLE test_table;
