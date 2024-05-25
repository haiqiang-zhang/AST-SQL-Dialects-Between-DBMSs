DROP DICTIONARY IF EXISTS test_dictionary;
CREATE DICTIONARY test_dictionary
(
    id UInt64,
    value Date32
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(TABLE 'test_table'))
LAYOUT(DIRECT());
SELECT * FROM test_dictionary;
SELECT dictGet('test_dictionary', 'value', toUInt64(0));
DROP DICTIONARY test_dictionary;
DROP TABLE test_table;
