VACUUM;
PRAGMA wal_checkpoint;
BEGIN;
SELECT count(a) FROM t1;
PRAGMA wal_checkpoint;
