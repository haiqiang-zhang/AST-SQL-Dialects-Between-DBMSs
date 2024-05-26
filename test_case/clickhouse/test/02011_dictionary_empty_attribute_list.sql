SELECT * FROM test_dictionary;
SELECT dictHas('test_dictionary', toUInt64(0));
DROP DICTIONARY test_dictionary;
DROP TABLE test_table;
