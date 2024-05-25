CREATE TABLE t1(a, b);
INSERT INTO t1 VALUES(1, 1), (2, 2), (3, 3), (4, 4);
DELETE FROM t1 WHERE a IN (1, 3);
SELECT rowid, a, b FROM t1 ORDER BY rowid;
SELECT rowid, a, b FROM t1 ORDER BY rowid;
