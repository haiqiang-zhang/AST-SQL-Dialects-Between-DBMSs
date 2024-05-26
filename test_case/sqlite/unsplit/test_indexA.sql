CREATE TABLE t1(a TEXT, b, c);
CREATE INDEX i1 ON t1(b, c) WHERE a='abc';
INSERT INTO t1 VALUES('abc', 1, 2);
SELECT * FROM t1 WHERE a='abc';
EXPLAIN QUERY PLAN 
  SELECT * FROM t1 WHERE a='abc';
CREATE INDEX i2 ON t1(b, c) WHERE a=5;
INSERT INTO t1 VALUES(5, 4, 3);
SELECT a, typeof(a), b, c FROM t1 WHERE a=5;
CREATE TABLE t2(x);
INSERT INTO t2 VALUES('v');
SELECT x, a, b, c FROM t2 LEFT JOIN t1 ON (a=5 AND b=x);
SELECT x, a, b, c FROM t2 RIGHT JOIN t1 ON (t1.a=5 AND t1.b=t2.x);
EXPLAIN QUERY PLAN 
  SELECT x, a, b, c FROM t2 RIGHT JOIN t1 ON (t1.a=5 AND t1.b=t2.x);
CREATE TABLE x1(a TEXT, b, c);
INSERT INTO x1 VALUES('2', 'two', 'ii');
INSERT INTO x1 VALUES('2.0', 'twopointoh', 'ii.0');
CREATE TABLE x2(a NUMERIC, b, c);
INSERT INTO x2 VALUES('2', 'two', 'ii');
INSERT INTO x2 VALUES('2.0', 'twopointoh', 'ii.0');
CREATE TABLE x3(a REAL, b, c);
INSERT INTO x3 VALUES('2', 'two', 'ii');
INSERT INTO x3 VALUES('2.0', 'twopointoh', 'ii.0');
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i2;
DROP INDEX IF EXISTS i3;
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i2;
DROP INDEX IF EXISTS i3;
CREATE INDEX i1 ON x1(b, c) WHERE a=2;
CREATE INDEX i2 ON x2(b, c) WHERE a=2;
CREATE INDEX i3 ON x3(b, c) WHERE a=2;
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i2;
DROP INDEX IF EXISTS i3;
CREATE INDEX i1 ON x1(b, c) WHERE a=2.0;
CREATE INDEX i2 ON x2(b, c) WHERE a=2.0;
CREATE INDEX i3 ON x3(b, c) WHERE a=2.0;
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i2;
DROP INDEX IF EXISTS i3;
CREATE INDEX i1 ON x1(b, c) WHERE a='2.0';
CREATE INDEX i2 ON x2(b, c) WHERE a='2.0';
CREATE INDEX i3 ON x3(b, c) WHERE a='2.0';
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i2;
DROP INDEX IF EXISTS i3;
CREATE INDEX i1 ON x1(b, c) WHERE a='2';
CREATE INDEX i2 ON x2(b, c) WHERE a='2';
CREATE INDEX i3 ON x3(b, c) WHERE a='2';
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i2;
DROP INDEX IF EXISTS i3;
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i2;
DROP INDEX IF EXISTS i3;
CREATE INDEX i1 ON x1(b, c) WHERE a=2;
CREATE INDEX i2 ON x2(b, c) WHERE a=2;
CREATE INDEX i3 ON x3(b, c) WHERE a=2;
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i2;
DROP INDEX IF EXISTS i3;
CREATE INDEX i1 ON x1(b, c) WHERE a=2.0;
CREATE INDEX i2 ON x2(b, c) WHERE a=2.0;
CREATE INDEX i3 ON x3(b, c) WHERE a=2.0;
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i2;
DROP INDEX IF EXISTS i3;
CREATE INDEX i1 ON x1(b, c) WHERE a='2.0';
CREATE INDEX i2 ON x2(b, c) WHERE a='2.0';
CREATE INDEX i3 ON x3(b, c) WHERE a='2.0';
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i2;
DROP INDEX IF EXISTS i3;
CREATE INDEX i1 ON x1(b, c) WHERE a='2';
CREATE INDEX i2 ON x2(b, c) WHERE a='2';
CREATE INDEX i3 ON x3(b, c) WHERE a='2';
SELECT * FROM t1;
INSERT INTO t1 VALUES(1, 1, 1);
INSERT INTO t1 VALUES(2, 1, 2);
ANALYZE;
UPDATE sqlite_stat1 SET stat = '50 1' WHERE idx='t2z';
UPDATE sqlite_stat1 SET stat = '50' WHERE tbl='t2' AND idx IS NULL;
UPDATE sqlite_stat1 SET stat = '5000' WHERE tbl='t1' AND idx IS NULL;
ANALYZE sqlite_schema;
INSERT INTO t1 VALUES(5, 'abc', 'xyz');
CREATE INDEX ex2 ON t1(a, 4);
CREATE INDEX ex1 ON t1(a) WHERE 4=b;
INSERT INTO t1 VALUES(1, 4, 1);
INSERT INTO t1 VALUES(1, 5, 1);
INSERT INTO t1 VALUES(2, 4, 2);
SELECT * FROM t1 WHERE b=4;
