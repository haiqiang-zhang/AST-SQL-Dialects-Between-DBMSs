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
SELECT dictGet('range_hashed_dictionary', 'value', toUInt64(1), toUInt64(18446744073709551615));
SELECT dictGet('range_hashed_dictionary', 'value', toUInt64(1), toUInt64(-1));
DROP DICTIONARY range_hashed_dictionary;
DROP TABLE dictionary_source_table;
