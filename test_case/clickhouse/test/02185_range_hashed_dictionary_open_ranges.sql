SELECT 'Source table';
SELECT * FROM 02185_range_dictionary_source_table;
DROP DICTIONARY IF EXISTS 02185_range_dictionary;
CREATE DICTIONARY 02185_range_dictionary
(
    id UInt64,
    start UInt64,
    end UInt64,
    value String DEFAULT 'DefaultValue'
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(TABLE '02185_range_dictionary_source_table'))
LAYOUT(RANGE_HASHED(convert_null_range_bound_to_open 1))
RANGE(MIN start MAX end)
LIFETIME(0);
SELECT 'Dictionary convert_null_range_bound_to_open = 1';
SELECT * FROM 02185_range_dictionary;
SELECT dictGet('02185_range_dictionary', 'value', 0, 0);
SELECT dictGet('02185_range_dictionary', 'value', 0, 5001);
SELECT dictGet('02185_range_dictionary', 'value', 0, 10001);
SELECT dictHas('02185_range_dictionary', 0, 0);
SELECT dictHas('02185_range_dictionary', 0, 5001);
SELECT dictHas('02185_range_dictionary', 0, 10001);
DROP DICTIONARY 02185_range_dictionary;
CREATE DICTIONARY 02185_range_dictionary
(
    id UInt64,
    start UInt64,
    end UInt64,
    value String DEFAULT 'DefaultValue'
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(TABLE '02185_range_dictionary_source_table'))
LAYOUT(RANGE_HASHED(convert_null_range_bound_to_open 0))
RANGE(MIN start MAX end)
LIFETIME(0);
SELECT 'Dictionary convert_null_range_bound_to_open = 0';
SELECT * FROM 02185_range_dictionary;
SELECT dictGet('02185_range_dictionary', 'value', 0, 0);
SELECT dictGet('02185_range_dictionary', 'value', 0, 5001);
SELECT dictGet('02185_range_dictionary', 'value', 0, 10001);
SELECT dictHas('02185_range_dictionary', 0, 0);
SELECT dictHas('02185_range_dictionary', 0, 5001);
SELECT dictHas('02185_range_dictionary', 0, 10001);
DROP TABLE 02185_range_dictionary_source_table;
