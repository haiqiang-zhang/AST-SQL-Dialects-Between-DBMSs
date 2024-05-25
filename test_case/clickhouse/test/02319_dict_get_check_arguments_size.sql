DROP DICTIONARY IF EXISTS test_dictionary;
CREATE DICTIONARY test_dictionary
(
    id UInt64,
    value String
)
PRIMARY KEY id
LAYOUT(FLAT())
SOURCE(CLICKHOUSE(TABLE 'dictionary_source_table'))
LIFETIME(0);
SELECT dictGet('test_dictionary', 'value', 0);
SELECT dictGetOrDefault('test_dictionary', 'value', 1, 'DefaultValue');
DROP DICTIONARY test_dictionary;
DROP TABLE dictionary_source_table;
CREATE TABLE dictionary_source_table
(
    key UInt64,
    start UInt64,
    end UInt64,
    value String
) Engine = TinyLog;
INSERT INTO dictionary_source_table values (0, 0, 5, 'Value');
DROP DICTIONARY IF EXISTS range_hashed_dictionary;
CREATE DICTIONARY range_hashed_dictionary
(
    key UInt64,
    start UInt64,
    end UInt64,
    value String
)
PRIMARY KEY key
SOURCE(CLICKHOUSE(TABLE 'dictionary_source_table'))
LAYOUT(RANGE_HASHED())
RANGE(MIN start MAX end)
LIFETIME(0);
SELECT dictGet('range_hashed_dictionary', 'value', 0, toUInt64(4));
SELECT dictGetOrDefault('range_hashed_dictionary', 'value', 1, toUInt64(6), 'DefaultValue');
DROP DICTIONARY range_hashed_dictionary;
DROP TABLE dictionary_source_table;
