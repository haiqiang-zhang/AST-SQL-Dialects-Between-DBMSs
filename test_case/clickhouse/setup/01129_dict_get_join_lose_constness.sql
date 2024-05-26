DROP DICTIONARY IF EXISTS system.dict1;
CREATE DICTIONARY IF NOT EXISTS system.dict1
(
    bytes_allocated UInt64,
    element_count Int32,
    loading_start_time DateTime
)
PRIMARY KEY bytes_allocated
SOURCE(CLICKHOUSE(HOST 'localhost' PORT tcpPort() USER 'default' PASSWORD '' TABLE 'dictionaries' DB 'system'))
LIFETIME(0)
LAYOUT(hashed());
