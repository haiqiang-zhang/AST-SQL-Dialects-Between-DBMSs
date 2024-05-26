DROP TABLE IF EXISTS index_memory;
CREATE TABLE index_memory (x UInt64) ENGINE = MergeTree ORDER BY x SETTINGS index_granularity = 1;
