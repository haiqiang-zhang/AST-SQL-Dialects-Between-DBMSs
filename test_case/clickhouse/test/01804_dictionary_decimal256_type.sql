SELECT 'Flat dictionary';
SELECT dictGet('flat_dictionary', 'decimal_value', toUInt64(1));
DROP DICTIONARY IF EXISTS hashed_dictionary;
CREATE DICTIONARY hashed_dictionary
(
    id UInt64,
    decimal_value Decimal256(5)
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(HOST 'localhost' PORT tcpPort() TABLE 'dictionary_decimal_source_table'))
LIFETIME(MIN 1 MAX 1000)
LAYOUT(HASHED());
SELECT 'Hashed dictionary';
DROP DICTIONARY hashed_dictionary;
DROP DICTIONARY IF EXISTS cache_dictionary;
CREATE DICTIONARY cache_dictionary
(
    id UInt64,
    decimal_value Decimal256(5)
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(HOST 'localhost' PORT tcpPort() TABLE 'dictionary_decimal_source_table'))
LIFETIME(MIN 1 MAX 1000)
LAYOUT(CACHE(SIZE_IN_CELLS 10));
SELECT 'Cache dictionary';
DROP DICTIONARY cache_dictionary;
DROP DICTIONARY IF EXISTS direct_dictionary;
CREATE DICTIONARY direct_dictionary
(
    id UInt64,
    decimal_value Decimal256(5)
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(HOST 'localhost' PORT tcpPort() TABLE 'dictionary_decimal_source_table'))
LAYOUT(DIRECT());
SELECT 'Direct dictionary';
DROP DICTIONARY direct_dictionary;
DROP TABLE dictionary_decimal_source_table;
DROP TABLE IF EXISTS ip_trie_dictionary_decimal_source_table;
CREATE TABLE ip_trie_dictionary_decimal_source_table
(
    prefix String,
    decimal_value Decimal256(5)
) ENGINE = TinyLog;
INSERT INTO ip_trie_dictionary_decimal_source_table VALUES ('127.0.0.0', 5.0);
DROP DICTIONARY IF EXISTS ip_trie_dictionary;
CREATE DICTIONARY ip_trie_dictionary
(
    prefix String,
    decimal_value Decimal256(5)
)
PRIMARY KEY prefix
SOURCE(CLICKHOUSE(HOST 'localhost' port tcpPort() TABLE 'ip_trie_dictionary_decimal_source_table'))
LIFETIME(MIN 10 MAX 1000)
LAYOUT(IP_TRIE());
SELECT 'IPTrie dictionary';
DROP DICTIONARY ip_trie_dictionary;
DROP TABLE ip_trie_dictionary_decimal_source_table;
DROP TABLE IF EXISTS dictionary_decimal_polygons_source_table;
CREATE TABLE dictionary_decimal_polygons_source_table
(
    key Array(Array(Array(Tuple(Float64, Float64)))),
    decimal_value Decimal256(5)
) ENGINE = TinyLog;
INSERT INTO dictionary_decimal_polygons_source_table VALUES ([[[(0, 0), (0, 1), (1, 1), (1, 0)]]], 5.0);
DROP DICTIONARY IF EXISTS polygon_dictionary;
CREATE DICTIONARY polygon_dictionary
(
    key Array(Array(Array(Tuple(Float64, Float64)))),
    decimal_value Decimal256(5)
)
PRIMARY KEY key
SOURCE(CLICKHOUSE(HOST 'localhost' PORT tcpPort() TABLE 'dictionary_decimal_polygons_source_table'))
LIFETIME(MIN 0 MAX 1000)
LAYOUT(POLYGON());
SELECT 'Polygon dictionary';
DROP DICTIONARY polygon_dictionary;
DROP TABLE dictionary_decimal_polygons_source_table;
