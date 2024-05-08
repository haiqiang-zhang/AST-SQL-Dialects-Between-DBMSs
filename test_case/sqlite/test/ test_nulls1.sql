DROP TABLE IF EXISTS t3;
CREATE TABLE t3(a INTEGER);
INSERT INTO t3 VALUES(NULL), (10), (30), (20), (NULL);
SELECT a FROM t3 ORDER BY a nULLS FIRST;
SELECT a FROM t3 ORDER BY a nULLS LAST;
SELECT a FROM t3 ORDER BY a DESC nULLS FIRST;
SELECT a FROM t3 ORDER BY a DESC nULLS LAST;
SELECT a FROM t3 ORDER BY a nULLS FIRST LIMIT 10;
SELECT a FROM t3 ORDER BY a nULLS LAST LIMIT 10;
SELECT a FROM t3 ORDER BY a DESC nULLS FIRST LIMIT 10;
SELECT a FROM t3 ORDER BY a DESC nULLS LAST LIMIT 10;
CREATE INDEX i1 ON t3(a);
SELECT a FROM t3 ORDER BY a nULLS FIRST;
SELECT a FROM t3 ORDER BY a nULLS LAST;
SELECT a FROM t3 ORDER BY a DESC nULLS FIRST;
SELECT a FROM t3 ORDER BY a DESC nULLS LAST;
SELECT a FROM t3 ORDER BY a nULLS FIRST LIMIT 10;
SELECT a FROM t3 ORDER BY a nULLS LAST LIMIT 10;
SELECT a FROM t3 ORDER BY a DESC nULLS FIRST LIMIT 10;
SELECT a FROM t3 ORDER BY a DESC nULLS LAST LIMIT 10;
DROP INDEX i1;
CREATE INDEX i1 ON t3(a DESC);
SELECT a FROM t3 ORDER BY a nULLS FIRST;
SELECT a FROM t3 ORDER BY a nULLS LAST;
SELECT a FROM t3 ORDER BY a DESC nULLS FIRST;
SELECT a FROM t3 ORDER BY a DESC nULLS LAST;
SELECT a FROM t3 ORDER BY a nULLS FIRST LIMIT 10;
SELECT a FROM t3 ORDER BY a nULLS LAST LIMIT 10;
SELECT a FROM t3 ORDER BY a DESC nULLS FIRST LIMIT 10;
SELECT a FROM t3 ORDER BY a DESC nULLS LAST LIMIT 10;
CREATE TABLE t2(a, b, c);
CREATE INDEX i2 ON t2(a, b);
INSERT INTO t2 VALUES(1, 1, 1);
INSERT INTO t2 VALUES(1, NULL, 2);
INSERT INTO t2 VALUES(1, NULL, 3);
INSERT INTO t2 VALUES(1, 4, 4);
SELECT * FROM t2 WHERE a=1 ORDER BY b NULLS LAST;
SELECT * FROM t2 WHERE a=1 ORDER BY b DESC NULLS FIRST;
CREATE TABLE t1(a, b, c, d, UNIQUE (b));
CREATE TABLE first(nulls, last);
INSERT INTO first(last, nulls) VALUES(100,200), (300,400), (200,300);
SELECT * FROM first ORDER BY nulls;
CREATE TABLE tx(a INTEGER PRIMARY KEY, b, c);
INSERT INTO tx VALUES(1, 1, 1);
INSERT INTO tx VALUES(2, NULL, 2);
INSERT INTO tx VALUES(3, 3, 3);
INSERT INTO tx VALUES(4, NULL, 4);
INSERT INTO tx VALUES(5, 5, 5);
SELECT * FROM tx ORDER BY b NULLS FIRST;
SELECT * FROM tx ORDER BY b NULLS LAST;
CREATE TABLE t4(a, b, c);
INSERT INTO t4 VALUES(1, 1, 11);
INSERT INTO t4 VALUES(1, 2, 12);
INSERT INTO t4 VALUES(1, NULL, 1);
INSERT INTO t4 VALUES(2, NULL, 1);
INSERT INTO t4 VALUES(2, 2, 12);
INSERT INTO t4 VALUES(2, 1, 11);
INSERT INTO t4 VALUES(3, NULL, 1);
INSERT INTO t4 VALUES(3, 2, 12);
INSERT INTO t4 VALUES(3, NULL, 3);
SELECT * FROM t4 WHERE a IN (1, 2, 3) ORDER BY a, b NULLS LAST;
CREATE INDEX t4ab ON t4(a, b);
SELECT * FROM t4 WHERE a IN (1, 2, 3) ORDER BY a, b NULLS LAST;
SELECT * FROM t4 WHERE a IN (1, 2, 3) ORDER BY a DESC, b DESC NULLS FIRST;
CREATE TABLE t5(a, b, c);
WITH s(i) AS (
    VALUES(1) UNION ALL SELECT i+1 FROM s WHERE i<200
  ) 
  INSERT INTO t5 SELECT i%2, CASE WHEN (i%10)==0 THEN NULL ELSE i END, i FROM s;
CREATE INDEX t5ab ON t5(a, b, c);
SELECT a,b FROM t5 WHERE a=1 ORDER BY b NULLS LAST, c;
SELECT a,b FROM t5 WHERE a=1 ORDER BY b DESC NULLS FIRST, c DESC;
CREATE TABLE t71(a, b, c);
CREATE INDEX t71abc ON t71(a, b, c);
SELECT * FROM t71 WHERE a=1 AND b=2 ORDER BY c NULLS LAST;
SELECT * FROM t71 WHERE a=1 AND b=2 ORDER BY c DESC NULLS FIRST;
SELECT * FROM t71 ORDER BY a NULLS LAST;
SELECT * FROM t71 ORDER BY a DESC NULLS FIRST;
CREATE TABLE v0 (c1, c2, c3);
CREATE INDEX v3 ON v0 (c1, c2, c3);
ANALYZE sqlite_master;
INSERT INTO sqlite_stat1 VALUES('v0','v3','648 324 81');
ANALYZE sqlite_master;
INSERT INTO v0 VALUES
      (1, 10, 'b'),
      (1, 10, 'd'),
      (1, 10, NULL),
      (2, 10, 'a'),
      (2, 10, NULL),
      (1, 10, 'c'),
      (2, 10, 'b'),
      (1, 10, 'a'),
      (1, 10, NULL),
      (2, 10, NULL),
      (2, 10, 'd'),
      (2, 10, 'c');
SELECT c1, c2, ifnull(c3, 'NULL') FROM v0 
  WHERE c2=10 ORDER BY c1, c3 NULLS LAST;
EXPLAIN QUERY PLAN 
  SELECT c1, c2, ifnull(c3, 'NULL') FROM v0 
  WHERE c2=10 ORDER BY c1, c3 NULLS LAST;
UPDATE t2 SET c=NULL WHERE c=6;
