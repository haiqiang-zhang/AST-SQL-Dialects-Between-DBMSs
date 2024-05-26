CREATE TABLE t1(a TEXT, b, c);
CREATE INDEX i1 ON t1(b, c) WHERE a='abc';
INSERT INTO t1 VALUES('abc', 1, 2);
