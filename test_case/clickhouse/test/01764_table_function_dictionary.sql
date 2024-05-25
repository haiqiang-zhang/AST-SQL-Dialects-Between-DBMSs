DROP DICTIONARY IF EXISTS table_function_dictionary_test_dictionary;
CREATE DICTIONARY table_function_dictionary_test_dictionary
(
   id UInt64,
   value UInt64 DEFAULT 0
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(HOST 'localhost' PORT tcpPort() USER 'default' TABLE 'table_function_dictionary_source_table'))
LAYOUT(DIRECT());
SELECT * FROM dictionary('table_function_dictionary_test_dictionary');
DROP TABLE table_function_dictionary_source_table;
DROP DICTIONARY table_function_dictionary_test_dictionary;
