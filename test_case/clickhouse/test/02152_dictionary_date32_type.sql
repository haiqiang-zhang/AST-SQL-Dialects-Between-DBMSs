SELECT * FROM test_dictionary;
SELECT dictGet('test_dictionary', 'value', toUInt64(0));
DROP DICTIONARY test_dictionary;
DROP TABLE test_table;
