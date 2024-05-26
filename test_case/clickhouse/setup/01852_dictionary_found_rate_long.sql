DROP TABLE IF EXISTS simple_key_source_table_01862;
CREATE TABLE simple_key_source_table_01862
(
    id UInt64,
    value String
) ENGINE = Memory();
INSERT INTO simple_key_source_table_01862 VALUES (1, 'First');
INSERT INTO simple_key_source_table_01862 VALUES (1, 'First');
DROP DICTIONARY IF EXISTS simple_key_flat_dictionary_01862;
CREATE DICTIONARY simple_key_flat_dictionary_01862
(
    id UInt64,
    value String
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(TABLE 'simple_key_source_table_01862'))
LAYOUT(FLAT())
LIFETIME(MIN 0 MAX 1000);
