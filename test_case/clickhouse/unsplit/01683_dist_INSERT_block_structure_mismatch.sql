DROP TABLE IF EXISTS tmp_01683;
DROP TABLE IF EXISTS dist_01683;
SET prefer_localhost_replica=0;
CREATE TABLE tmp_01683 (n Int8) ENGINE=Memory;
SET distributed_foreground_insert=1;
SET distributed_foreground_insert=0;
SELECT * FROM tmp_01683 ORDER BY n;
DROP TABLE tmp_01683;
