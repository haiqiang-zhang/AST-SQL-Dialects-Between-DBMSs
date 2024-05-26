SELECT max(x) - min(x) FROM t;
TRUNCATE TABLE t;
INSERT INTO t SELECT value FROM system.events WHERE event = 'OverflowThrow';
