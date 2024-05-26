SELECT count() FROM t_lightweight_deletes;
SYSTEM STOP MERGES t_lightweight_deletes;
DELETE FROM t_lightweight_deletes WHERE a = 2 SETTINGS lightweight_deletes_sync = 0;
DROP TABLE t_lightweight_deletes;
