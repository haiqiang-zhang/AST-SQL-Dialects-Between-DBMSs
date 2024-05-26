DROP TABLE IF EXISTS table_02513;
CREATE TABLE table_02513 (n UInt64) ENGINE=MergeTree() ORDER BY tuple() SETTINGS index_granularity=100;
INSERT INTO table_02513 SELECT number+11*13*1000 FROM numbers(20);
SET mutations_sync=2;
SET max_threads=1;
DELETE FROM table_02513 WHERE n%10=0;
