PRAGMA auto_vacuum = 0;
CREATE TABLE t1(a, b);
CREATE INDEX i1 ON t1(a);
INSERT INTO t1 VALUES(1, 1), (2, 2), (3, 3), (4, 4);
