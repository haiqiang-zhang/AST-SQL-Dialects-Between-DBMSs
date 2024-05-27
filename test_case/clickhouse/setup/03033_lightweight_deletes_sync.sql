DROP TABLE IF EXISTS t_lightweight_deletes;
CREATE TABLE t_lightweight_deletes (a UInt64) ENGINE = MergeTree ORDER BY a;
INSERT INTO t_lightweight_deletes VALUES (1) (2) (3);
DELETE FROM t_lightweight_deletes WHERE a = 1 SETTINGS lightweight_deletes_sync = 2;