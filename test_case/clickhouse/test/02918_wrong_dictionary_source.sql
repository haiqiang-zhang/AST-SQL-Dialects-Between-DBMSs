DROP DICTIONARY IF EXISTS id_value_dictionary;
DROP TABLE IF EXISTS source_table;
CREATE TABLE source_table(id UInt64, value String) ENGINE = MergeTree ORDER BY tuple();
SELECT count() FROM system.dictionaries WHERE name=='id_value_dictionary' AND database==currentDatabase();
DROP TABLE source_table;
