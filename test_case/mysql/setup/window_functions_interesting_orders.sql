CREATE TABLE t1 ( a INTEGER, b INTEGER, c INTEGER );
INSERT INTO t1 (a,b,c) VALUES (1,2,3);
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
CREATE INDEX idx ON t1 (a, b);
ALTER TABLE t1 DROP INDEX idx;
CREATE INDEX idx ON t1 (a);
DROP TABLE t1;
CREATE TABLE t1 (pk INT PRIMARY KEY, x INT);
CREATE TABLE t2 (pk INT PRIMARY KEY);