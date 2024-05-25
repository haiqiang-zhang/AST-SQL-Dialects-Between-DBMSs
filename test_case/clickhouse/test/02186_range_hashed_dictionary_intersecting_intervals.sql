SELECT 'Source table';
SELECT * FROM 02186_range_dictionary_source_table;
DROP DICTIONARY IF EXISTS 02186_range_dictionary;
CREATE DICTIONARY 02186_range_dictionary
(
    id UInt64,
    start Date,
    end Date,
    value String
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(TABLE '02186_range_dictionary_source_table'))
LAYOUT(RANGE_HASHED(range_lookup_strategy 'min'))
RANGE(MIN start MAX end)
LIFETIME(0);
SELECT 'Dictionary .range_lookup_strategy = min';
SELECT * FROM 02186_range_dictionary;
select dictGet('02186_range_dictionary', 'value', toUInt64(1), toDate('2020-01-01'));
select dictGet('02186_range_dictionary', 'value', toUInt64(1), toDate('2020-01-02'));
select dictGet('02186_range_dictionary', 'value', toUInt64(1), toDate('2020-01-03'));
DROP DICTIONARY 02186_range_dictionary;
CREATE DICTIONARY 02186_range_dictionary
(
    id UInt64,
    start Date,
    end Date,
    value String
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(TABLE '02186_range_dictionary_source_table'))
LAYOUT(RANGE_HASHED(range_lookup_strategy 'max'))
RANGE(MIN start MAX end)
LIFETIME(0);
SELECT 'Dictionary .range_lookup_strategy = max';
SELECT * FROM 02186_range_dictionary;
select dictGet('02186_range_dictionary', 'value', toUInt64(1), toDate('2020-01-01'));
select dictGet('02186_range_dictionary', 'value', toUInt64(1), toDate('2020-01-02'));
select dictGet('02186_range_dictionary', 'value', toUInt64(1), toDate('2020-01-03'));
DROP DICTIONARY 02186_range_dictionary;
DROP TABLE 02186_range_dictionary_source_table;
