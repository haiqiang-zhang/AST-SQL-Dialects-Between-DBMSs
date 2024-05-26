SELECT avg(b), typeof(avg(b)) FROM t1;
SELECT sum(b), typeof(sum(b)) FROM t1;
SELECT b, typeof(b) FROM t1 WHERE a=3;
CREATE INDEX t1i1 ON t1(a,b);
REINDEX;
CREATE TABLE t2(x,y);
INSERT INTO t2 SELECT * FROM t1;
CREATE TABLE t3 AS SELECT * FROM t1;
