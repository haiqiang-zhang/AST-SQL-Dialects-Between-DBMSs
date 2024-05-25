DROP TABLE IF EXISTS pk;
CREATE TABLE pk (x DateTime) ENGINE = MergeTree ORDER BY toStartOfMinute(x) SETTINGS index_granularity = 1;
