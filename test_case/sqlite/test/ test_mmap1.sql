PRAGMA auto_vacuum = 1;
PRAGMA mmap_size = 67108864;
PRAGMA journal_mode = wal;
CREATE TABLE t1(a, b, UNIQUE(a, b));
--   32
    PRAGMA wal_checkpoint;
PRAGMA auto_vacuum;
SELECT count(*) FROM t1;
PRAGMA wal_checkpoint;
PRAGMA mmap_size = 67108864;
PRAGMA auto_vacuum = 1;
--    8

  CREATE TABLE t2(a, b, UNIQUE(a, b));
INSERT INTO t2 SELECT * FROM t1;
PRAGMA mmap_size = 67108864;
PRAGMA page_size = 1024;
SELECT * FROM t1;
BEGIN;
PRAGMA mmap_size = 67108864;
PRAGMA auto_vacuum = 2;
PRAGMA page_size = 1024;
PRAGMA auto_vacuum;
SELECT * FROM t1;
