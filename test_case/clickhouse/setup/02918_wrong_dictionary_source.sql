DROP DICTIONARY IF EXISTS id_value_dictionary;
DROP TABLE IF EXISTS source_table;
CREATE TABLE source_table(id UInt64, value String) ENGINE = MergeTree ORDER BY tuple();
