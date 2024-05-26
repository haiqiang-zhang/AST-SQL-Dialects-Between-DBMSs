CREATE TABLE source_table
(
    id UInt64,
    value String
) ENGINE = Memory();
INSERT INTO source_table VALUES (1, 'First');
INSERT INTO source_table VALUES (2, 'Second');
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
