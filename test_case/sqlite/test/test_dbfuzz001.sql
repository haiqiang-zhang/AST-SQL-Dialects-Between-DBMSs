PRAGMA integrity_check;
CREATE TABLE t1(a INTEGER, b INT, c DEFAULT 0);
PRAGMA locking_mode=EXCLUSIVE;
PRAGMA journal_mode = memory;
INSERT INTO t1 VALUES(1,2,3);
PRAGMA journal_mode=PERSIST;
INSERT INTO t1 VALUES(4, 5, 6);
PRAGMA journal_mode=MEMORY;
INSERT INTO t1 VALUES(7, 8, 9);
