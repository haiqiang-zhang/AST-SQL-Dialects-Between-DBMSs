SELECT id, value FROM test_table WHERE id IN special_set_table;
DROP TABLE special_set_table;
DROP TABLE test_table;
