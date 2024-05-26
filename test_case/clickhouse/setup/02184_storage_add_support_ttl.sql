DROP TABLE IF EXISTS mergeTree_02184;
CREATE TABLE mergeTree_02184 (id UInt64, name String, dt Date) Engine=MergeTree ORDER BY id;
ALTER TABLE mergeTree_02184 MODIFY COLUMN name String TTL dt + INTERVAL 1 MONTH;
