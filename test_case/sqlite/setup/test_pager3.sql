PRAGMA journal_mode = DELETE;
CREATE TABLE t1(a, b);
PRAGMA locking_mode=EXCLUSIVE;
INSERT INTO t1 VALUES(1, 2);
PRAGMA locking_mode=NORMAL;