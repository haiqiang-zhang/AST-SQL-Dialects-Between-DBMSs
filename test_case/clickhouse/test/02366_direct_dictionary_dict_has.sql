DROP DICTIONARY IF EXISTS test_dictionary;
CREATE DICTIONARY test_dictionary
(
   id UInt64,
   value String
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(TABLE 'test_table'))
LAYOUT(DIRECT());
SELECT id, lookup_key, dictHas('test_dictionary', lookup_key) FROM test_lookup_table ORDER BY id ASC;
DROP DICTIONARY test_dictionary;
DROP TABLE test_table;
DROP TABLE test_lookup_table;
