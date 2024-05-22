CREATE TABLE IF NOT EXISTS dict_source (key UInt64, value String) ENGINE=MergeTree ORDER BY key;
