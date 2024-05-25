DROP TABLE IF EXISTS data_00612;
DROP TABLE IF EXISTS dist_00612;
CREATE TABLE data_00612 (key UInt64, val UInt64) ENGINE = MergeTree ORDER BY key;
SET distributed_foreground_insert=1;
SET prefer_localhost_replica=0;
SET max_query_size=29;
SET max_query_size=262144;
SET distributed_foreground_insert=0;
SET prefer_localhost_replica=1;
DROP TABLE data_00612;
