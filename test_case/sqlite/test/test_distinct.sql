SELECT DISTINCT a, b FROM t1;
SELECT DISTINCT b, a FROM t1;
SELECT DISTINCT a, b, c FROM t1;
SELECT DISTINCT a, b, c FROM t1 ORDER BY a, b, c;
SELECT DISTINCT b FROM t1 WHERE a = 'a';
SELECT DISTINCT b FROM t1 ORDER BY +b COLLATE binary;
SELECT DISTINCT a FROM t1;
SELECT DISTINCT b COLLATE nocase FROM t1;
SELECT DISTINCT b COLLATE nocase FROM t1 ORDER BY b COLLATE nocase;
SELECT (SELECT DISTINCT o.a FROM t1 AS i) FROM t1 AS o ORDER BY rowid;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1(a INTEGER);
INSERT INTO t1 VALUES(3);
INSERT INTO t1 VALUES(2);
INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(2);
INSERT INTO t1 VALUES(3);
INSERT INTO t1 VALUES(1);
CREATE TABLE t2(x);
INSERT INTO t2
    SELECT DISTINCT
      CASE a WHEN 1 THEN x'0000000000'
             WHEN 2 THEN zeroblob(5)
             ELSE 'xyzzy' END
      FROM t1;
SELECT quote(x) FROM t2 ORDER BY 1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(x);
INSERT INTO t1(x) VALUES(3),(1),(5),(2),(6),(4),(5),(1),(3);
CREATE INDEX t1x ON t1(x DESC);
SELECT DISTINCT x FROM t1 ORDER BY x ASC;
SELECT DISTINCT x FROM t1 ORDER BY x DESC;
SELECT DISTINCT x FROM t1 ORDER BY x;
DROP INDEX t1x;
CREATE INDEX t1x ON t1(x ASC);
SELECT DISTINCT x FROM t1 ORDER BY x ASC;
SELECT DISTINCT x FROM t1 ORDER BY x DESC;
SELECT DISTINCT x FROM t1 ORDER BY x;
CREATE TABLE jjj(x);
SELECT (SELECT 'mmm' UNION SELECT DISTINCT max(name) ORDER BY 1) 
    FROM sqlite_master;
CREATE TABLE nnn(x);
SELECT (SELECT 'mmm' UNION SELECT DISTINCT max(name) ORDER BY 1) 
    FROM sqlite_master;
CREATE TABLE t3(a INTEGER PRIMARY KEY);
CREATE TABLE t4(x);
CREATE TABLE t5(y);
INSERT INTO t5 VALUES(1), (2), (2);
INSERT INTO t1 VALUES(2);
INSERT INTO t3 VALUES(2);
INSERT INTO t4 VALUES(2);
CREATE TABLE person ( pid INT);
CREATE UNIQUE INDEX idx ON person ( pid ) WHERE pid == 1;
INSERT INTO person VALUES (1), (10), (10);
SELECT DISTINCT pid FROM person where pid = 10;
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i1;
DROP INDEX IF EXISTS i1;
SELECT  DISTINCT
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1
  ORDER  BY
   'x','x','x','x','x','x','x','x','x','x',
   'x','x','x','x','x','x','x','x','x','x',
   'x','x','x','x','x','x','x','x','x','x',
   'x','x','x','x','x','x','x','x','x','x',
   'x','x','x','x','x','x','x','x','x','x',
   'x','x','x','x','x','x','x','x','x','x',
   'x','x','x','x';
EXPLAIN
  SELECT  DISTINCT
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1
  ORDER  BY
   'x','x','x','x','x','x','x','x','x','x',
   'x','x','x','x','x','x','x','x','x','x',
   'x','x','x','x','x','x','x','x','x','x',
   'x','x','x','x','x','x','x','x','x','x',
   'x','x','x','x','x','x','x','x','x','x',
   'x','x','x','x','x','x','x','x','x','x',
   'x','x','x','x';
DROP TABLE IF EXISTS t0;
CREATE  TABLE t0 AS  SELECT  DISTINCT 0xda, 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 0xda-0xda-42e-300, 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0', 'lit0' ORDER  BY '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%Y-%m-%d', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', 'lit0', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', 'auto', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', ':memory:', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '%%', '';
SELECT count(*) FROM t0;
DROP TABLE IF EXISTS t2;
CREATE  TABLE t2 AS  SELECT  DISTINCT ':memory:', 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 0.0*7/0, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 ORDER  BY '%J%j%w%s', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', '%J%j%w%s', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 'unixepoch', 42e-300, 'unixepoch', 'unixepoch', 'unixepoch' LIMIT 0xda;
