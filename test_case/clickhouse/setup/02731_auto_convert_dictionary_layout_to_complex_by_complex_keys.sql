DROP DICTIONARY IF EXISTS dict_flat_simple;
DROP DICTIONARY IF EXISTS dict_hashed_simple_Decimal128;
DROP DICTIONARY IF EXISTS dict_hashed_simple_Float32;
DROP DICTIONARY IF EXISTS dict_hashed_simple_String;
DROP DICTIONARY IF EXISTS dict_hashed_simple_auto_convert;
DROP TABLE IF EXISTS dict_data;
CREATE TABLE dict_data (v0 UInt16, v1 Int16, v2 Float32, v3 Decimal128(10), v4 String) engine=Memory()  AS SELECT number, number%65535, number*1.1, number*1.1, 'foo' FROM numbers(10);
CREATE DICTIONARY dict_flat_simple (v0 UInt16, v1 UInt16, v2 UInt16) PRIMARY KEY v0 SOURCE(CLICKHOUSE(TABLE 'dict_data')) LIFETIME(0) LAYOUT(flat());
