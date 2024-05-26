DROP TABLE IF EXISTS count;
CREATE TABLE count (x UInt64) ENGINE = MergeTree ORDER BY tuple() SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
INSERT INTO count SELECT * FROM numbers(1234567);
SELECT count() FROM count;
SELECT count() * 2 FROM count;
SELECT arrayJoin([count(), count()]) FROM count;
SELECT arrayJoin([count(), count()]) AS x FROM count LIMIT 1 BY x;
SELECT arrayJoin([count(), count() + 1]) AS x FROM count LIMIT 1 BY x;
DROP TABLE count;
