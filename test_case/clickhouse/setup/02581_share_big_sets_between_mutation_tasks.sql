DROP TABLE IF EXISTS 02581_trips;
CREATE TABLE 02581_trips(id UInt32, id2 UInt32, description String) ENGINE=MergeTree ORDER BY id SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
INSERT INTO 02581_trips SELECT number, number, '' FROM numbers(10000);
INSERT INTO 02581_trips SELECT number+10000, number+10000, '' FROM numbers(10000);
INSERT INTO 02581_trips SELECT number+20000, number+20000, '' FROM numbers(10000);
INSERT INTO 02581_trips SELECT number+30000, number+30000, '' FROM numbers(10000);