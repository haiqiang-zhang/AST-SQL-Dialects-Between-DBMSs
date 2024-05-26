ANALYZE;
DELETE FROM sqlite_stat1;
INSERT INTO sqlite_stat1(tbl,idx,stat)
    VALUES('t1','t1a','12345 2'),('t1','t1b','12345 4');
ANALYZE sqlite_master;
SELECT *, '#' FROM t1 WHERE a BETWEEN 3 AND 8 ORDER BY c;
EXPLAIN QUERY PLAN
  SELECT *, '#' FROM t1 WHERE a BETWEEN 3 AND 8 ORDER BY c;
SELECT c FROM t1 ORDER BY a;
EXPLAIN QUERY PLAN
  SELECT c FROM t1 ORDER BY a;
EXPLAIN QUERY PLAN
  SELECT c FROM t1 ORDER BY a;
UPDATE sqlite_stat1 SET stat='12345 2 unordered' WHERE idx='t1a';
ANALYZE sqlite_master;
SELECT *, '#' FROM t1 WHERE a BETWEEN 3 AND 8 ORDER BY c;
EXPLAIN QUERY PLAN
  SELECT *, '#' FROM t1 WHERE a BETWEEN 3 AND 8 ORDER BY c;
SELECT c FROM t1 ORDER BY a;
EXPLAIN QUERY PLAN
  SELECT c FROM t1 ORDER BY a;
EXPLAIN QUERY PLAN
  SELECT c FROM t1 ORDER BY a;
UPDATE sqlite_stat1 SET stat='12345 2 whatever=5 unordered xyzzy=11'
   WHERE idx='t1a';
ANALYZE sqlite_master;
SELECT *, '#' FROM t1 WHERE a BETWEEN 3 AND 8 ORDER BY c;
EXPLAIN QUERY PLAN
  SELECT *, '#' FROM t1 WHERE a BETWEEN 3 AND 8 ORDER BY c;
SELECT c FROM t1 ORDER BY a;
EXPLAIN QUERY PLAN
  SELECT c FROM t1 ORDER BY a;
EXPLAIN QUERY PLAN
  SELECT c FROM t1 ORDER BY a;
DROP INDEX t1a;
CREATE INDEX t1ab ON t1(a,b);
CREATE INDEX t1ca ON t1(c,a);
DELETE FROM sqlite_stat1;
INSERT INTO sqlite_stat1(tbl,idx,stat)
    VALUES('t1','t1ab','12345 3 2 sz=10'),('t1','t1ca','12345 3 2 sz=20');
ANALYZE sqlite_master;
SELECT count(a) FROM t1;
EXPLAIN QUERY PLAN
  SELECT count(a) FROM t1;
DELETE FROM sqlite_stat1;
INSERT INTO sqlite_stat1(tbl,idx,stat)
    VALUES('t1','t1ab','12345 3 2 sz=20'),('t1','t1ca','12345 3 2 sz=10');
ANALYZE sqlite_master;
DROP TABLE IF EXISTS t44;
CREATE TABLE t44(a PRIMARY KEY);
INSERT INTO sqlite_stat1 VALUES('t44',null,'sz=0');
ANALYZE sqlite_master;
SELECT 0 FROM t44 WHERE a IN(1,2,3);
DELETE FROM sqlite_stat1;
INSERT INTO sqlite_stat1(tbl,idx,stat)
    VALUES('t1','t1ab','12345 3 2 x=5 sz=10 y=10'),
          ('t1','t1ca','12345 3 2 whatever sz=20 junk');
ANALYZE sqlite_master;
DELETE FROM sqlite_stat1;
INSERT INTO sqlite_stat1(tbl,idx,stat)
    VALUES('t1','t1ca','12345 3 2 x=5 sz=10 y=10'),
          ('t1','t1ab','12345 3 2 whatever sz=20 junk');
ANALYZE sqlite_master;
