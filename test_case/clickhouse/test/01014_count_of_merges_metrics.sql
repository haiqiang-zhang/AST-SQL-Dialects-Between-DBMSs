OPTIMIZE TABLE new_table_test FINAL;
INSERT INTO check_table_test (value2) SELECT value FROM system.events WHERE event = 'Merge';
SELECT count() FROM check_table_test WHERE value2 > value1;
DROP TABLE new_table_test;
DROP TABLE check_table_test;
