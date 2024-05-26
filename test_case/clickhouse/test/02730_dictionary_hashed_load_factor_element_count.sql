SYSTEM RELOAD DICTIONARY dict_sharded;
SELECT name, length(attribute.names), element_count, round(load_factor, 4) FROM system.dictionaries WHERE database = currentDatabase() AND name = 'dict_sharded';
DROP DICTIONARY dict_sharded;
CREATE DICTIONARY dict_sharded_multi (key UInt64, v0 UInt16, v1 UInt16, v2 UInt16, v3 UInt16, v4 UInt16) PRIMARY KEY key SOURCE(CLICKHOUSE(TABLE 'dict_data')) LIFETIME(MIN 0 MAX 0) LAYOUT(HASHED(SHARDS 32));
SYSTEM RELOAD DICTIONARY dict_sharded_multi;
DROP DICTIONARY dict_sharded_multi;
DROP TABLE dict_data;
