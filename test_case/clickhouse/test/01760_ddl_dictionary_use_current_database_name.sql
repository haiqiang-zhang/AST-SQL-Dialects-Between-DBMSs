DROP DICTIONARY IF EXISTS ddl_dictionary_test;
CREATE DICTIONARY ddl_dictionary_test
(
   id UInt64,
   value UInt64 DEFAULT 0
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(HOST 'localhost' PORT tcpPort() USER 'default' TABLE 'ddl_dictonary_test_source'))
LAYOUT(DIRECT());
SELECT 'dictGet';
SELECT dictGet('ddl_dictionary_test', 'value', number) FROM system.numbers LIMIT 3;
SELECT 'dictHas';
SELECT dictHas('ddl_dictionary_test', number) FROM system.numbers LIMIT 3;
DROP TABLE ddl_dictonary_test_source;
DROP DICTIONARY ddl_dictionary_test;
