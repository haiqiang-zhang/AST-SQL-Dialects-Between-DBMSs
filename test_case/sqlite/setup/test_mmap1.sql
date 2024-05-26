PRAGMA auto_vacuum = 1;
PRAGMA mmap_size = 67108864;
PRAGMA journal_mode = wal;
CREATE TABLE t1(a, b, UNIQUE(a, b));
PRAGMA wal_checkpoint;
PRAGMA auto_vacuum;
