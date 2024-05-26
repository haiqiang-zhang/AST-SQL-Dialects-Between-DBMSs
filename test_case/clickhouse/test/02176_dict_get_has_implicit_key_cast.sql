SELECT dictGet('02176_test_simple_key_dictionary', 'value', toUInt64(0));
SELECT dictHas('02176_test_simple_key_dictionary', toUInt64(0));
DROP DICTIONARY 02176_test_simple_key_dictionary;
DROP TABLE 02176_test_simple_key_table;
DROP TABLE IF EXISTS 02176_test_complex_key_table;
CREATE TABLE 02176_test_complex_key_table
(
    id UInt64,
    id_key String,
    value String
) ENGINE=TinyLog;
INSERT INTO 02176_test_complex_key_table VALUES (0, '0', 'Value');
DROP DICTIONARY IF EXISTS 02176_test_complex_key_dictionary;
CREATE DICTIONARY 02176_test_complex_key_dictionary
(
    id UInt64,
    id_key String,
    value String
)
PRIMARY KEY id, id_key
SOURCE(CLICKHOUSE(TABLE '02176_test_complex_key_table'))
LAYOUT(COMPLEX_KEY_DIRECT());
DROP DICTIONARY 02176_test_complex_key_dictionary;
DROP TABLE 02176_test_complex_key_table;
