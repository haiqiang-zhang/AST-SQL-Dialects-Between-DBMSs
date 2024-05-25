DROP TABLE IF EXISTS count;
CREATE TABLE count (x UInt64) ENGINE = MergeTree ORDER BY tuple() SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
INSERT INTO count SELECT * FROM numbers(1234567);
