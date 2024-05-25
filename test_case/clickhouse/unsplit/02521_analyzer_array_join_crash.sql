SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
    id UInt64,
    value String
) ENGINE = MergeTree ORDER BY id;
INSERT INTO test_table VALUES (0, 'Value');
SELECT id, value_element, value FROM test_table ARRAY JOIN [[1,2,3]] AS value_element, value_element AS value;
SELECT id, value_element, value FROM test_table ARRAY JOIN [[1,2,3]] AS value_element ARRAY JOIN value_element AS value;
SELECT value_element, value FROM test_table ARRAY JOIN [1048577] AS value_element, arrayMap(x -> value_element, ['']) AS value;
DROP TABLE test_table;