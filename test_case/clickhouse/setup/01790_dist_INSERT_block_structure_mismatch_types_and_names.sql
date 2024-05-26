DROP TABLE IF EXISTS tmp_01781;
DROP TABLE IF EXISTS dist_01781;
SET prefer_localhost_replica=0;
CREATE TABLE tmp_01781 (n LowCardinality(String)) ENGINE=Memory;
SET distributed_foreground_insert=1;
SET distributed_foreground_insert=0;
