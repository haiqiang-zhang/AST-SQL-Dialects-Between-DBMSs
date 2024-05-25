DROP TABLE IF EXISTS tmp_02482;
DROP TABLE IF EXISTS dist_02482;
SET send_logs_level = 'error';
SET prefer_localhost_replica=0;
CREATE TABLE tmp_02482 (i UInt64, n LowCardinality(String)) ENGINE = Memory;
SET distributed_foreground_insert=1;
SET distributed_foreground_insert=0;
SYSTEM STOP DISTRIBUTED SENDS dist_02482;
DROP TABLE tmp_02482;
