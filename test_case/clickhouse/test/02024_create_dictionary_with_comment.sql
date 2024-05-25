DROP DICTIONARY IF EXISTS 2024_dictionary_with_comment;
CREATE DICTIONARY 2024_dictionary_with_comment
(
    id UInt64,
    value String
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(HOST 'localhost' PORT tcpPort() TABLE 'source_table'))
LAYOUT(FLAT())
LIFETIME(MIN 0 MAX 1000)
COMMENT 'Test dictionary with comment';
SHOW CREATE DICTIONARY 2024_dictionary_with_comment;
SELECT comment FROM system.dictionaries WHERE name == '2024_dictionary_with_comment' AND database == currentDatabase();
DROP DICTIONARY IF EXISTS 2024_dictionary_with_comment;
