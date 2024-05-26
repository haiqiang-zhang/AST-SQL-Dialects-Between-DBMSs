SELECT 'ARRAY JOIN with constant';
SELECT id, value, value_1 FROM test_table ARRAY JOIN [1, 2, 3] AS value_1;
SELECT '--';
SELECT id, value FROM test_table ARRAY JOIN [1, 2, 3] AS value;
SELECT '--';
WITH [1, 2, 3] AS constant_array SELECT id, value FROM test_table ARRAY JOIN constant_array AS value;
SELECT '--';
WITH [1, 2, 3] AS constant_array SELECT id, value, value_1 FROM test_table ARRAY JOIN constant_array AS value_1;
SELECT '--';
SELECT id, value, value_1, value_2 FROM test_table ARRAY JOIN [[1, 2, 3]] AS value_1 ARRAY JOIN value_1 AS value_2;
SELECT 'ARRAY JOIN with column';
SELECT id, value, test_table.value_array FROM test_table ARRAY JOIN value_array;
SELECT '--';
SELECT id, value_array, value FROM test_table ARRAY JOIN value_array AS value;
SELECT '--';
SELECT id, value, value_array, value_array_element FROM test_table ARRAY JOIN value_array AS value_array_element;
SELECT '--';
SELECT id, value, value_array AS value_array_array_alias FROM test_table ARRAY JOIN value_array_array_alias;
SELECT '--';
SELECT '--';
SELECT id, value, value_array AS value_array_array_alias, value_array_array_alias_element FROM test_table ARRAY JOIN value_array_array_alias AS value_array_array_alias_element;
SELECT '--';
SELECT id, value, value_array_array, value_array_array_inner_element, value_array_array_inner_element, value_array_array_inner_inner_element
FROM test_table ARRAY JOIN value_array_array AS value_array_array_inner_element
ARRAY JOIN value_array_array_inner_element AS value_array_array_inner_inner_element;
DROP TABLE test_table;
