BEGIN;
INSERT INTO t1 VALUES(1, 2);
PRAGMA journal_mode = wal;
INSERT INTO t1 VALUES(3, 4);
PRAGMA auto_vacuum = 0;