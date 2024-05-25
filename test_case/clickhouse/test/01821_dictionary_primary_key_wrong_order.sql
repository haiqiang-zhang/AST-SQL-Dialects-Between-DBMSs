DROP DICTIONARY IF EXISTS flat_dictionary;
CREATE DICTIONARY flat_dictionary
(
    identifier UInt64,
    v UInt64
)
PRIMARY KEY v
SOURCE(CLICKHOUSE(HOST 'localhost' PORT tcpPort() TABLE 'dictionary_primary_key_source_table'))
LIFETIME(MIN 1 MAX 1000)
LAYOUT(FLAT());
SELECT * FROM flat_dictionary;
DROP DICTIONARY flat_dictionary;
DROP TABLE dictionary_primary_key_source_table;
