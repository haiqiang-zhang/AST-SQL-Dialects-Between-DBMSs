CREATE TABLE t1(a INTEGER PRIMARY KEY, b, c);
INSERT INTO t1 VALUES(1, 2, 3);
INSERT INTO t1 VALUES(2, 'two', 'three');
INSERT INTO t1 VALUES(3, NULL, NULL);
CREATE INDEX i1 ON t1(b, c);
BEGIN EXCLUSIVE;
INSERT INTO t1 VALUES(4, 5, 6);
