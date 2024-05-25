DROP DICTIONARY IF EXISTS 02179_test_dictionary;
CREATE DICTIONARY 02179_test_dictionary
(
    id UInt64,
    value String DEFAULT 'DefaultValue',
    start Int64,
    end Int64
) PRIMARY KEY id
LAYOUT(RANGE_HASHED())
SOURCE(CLICKHOUSE(TABLE '02179_test_table'))
RANGE(MIN start MAX end)
LIFETIME(0);
SELECT dictGet('02179_test_dictionary', 'value', 0, 15);
SELECT dictGet('02179_test_dictionary', 'value', 0, 5);
SELECT dictHas('02179_test_dictionary', 0, 15);
SELECT dictHas('02179_test_dictionary', 0, 5);
SELECT * FROM 02179_test_dictionary;
DROP DICTIONARY 02179_test_dictionary;
DROP TABLE 02179_test_table;
