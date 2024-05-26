SELECT * FROM test_dictionary;
SELECT dictGet('test_dictionary', 'insert_time', toUInt64(1), 10);
SELECT '--';
SELECT * FROM test_dictionary;
DROP DICTIONARY test_dictionary;
DROP TABLE test_table;
