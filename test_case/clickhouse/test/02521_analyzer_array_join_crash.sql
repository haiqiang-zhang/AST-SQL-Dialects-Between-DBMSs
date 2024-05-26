SELECT id, value_element, value FROM test_table ARRAY JOIN [[1,2,3]] AS value_element, value_element AS value;
SELECT id, value_element, value FROM test_table ARRAY JOIN [[1,2,3]] AS value_element ARRAY JOIN value_element AS value;
SELECT value_element, value FROM test_table ARRAY JOIN [1048577] AS value_element, arrayMap(x -> value_element, ['']) AS value;
DROP TABLE test_table;
