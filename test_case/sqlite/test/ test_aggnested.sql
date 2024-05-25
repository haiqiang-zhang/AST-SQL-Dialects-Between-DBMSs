SELECT (SELECT sum(x+(SELECT y)) FROM bb) FROM aa;
SELECT (SELECT sum(x+y) FROM bb) FROM aa;
DROP TABLE IF EXISTS tx;
DROP TABLE IF EXISTS ty;
CREATE TABLE tx(x INT);
INSERT INTO tx VALUES(1),(2),(3),(4),(5);
CREATE TABLE ty(y INT);
INSERT INTO ty VALUES(91),(92),(93);
SELECT min((SELECT count(y) FROM ty)) FROM tx;
SELECT max((SELECT a FROM (SELECT count(*) AS a FROM ty) AS s)) FROM tx;
CREATE TABLE x1(a, b);
INSERT INTO x1 VALUES(1, 2);
CREATE TABLE x2(x);
INSERT INTO x2 VALUES(NULL), (NULL), (NULL);
SELECT ( SELECT total( (SELECT b FROM x1) ) ) FROM x2;
SELECT ( SELECT total( (SELECT 2 FROM x1) ) ) FROM x2;
CREATE TABLE t1(a);
CREATE TABLE t2(b);
SELECT(
    SELECT max(b) LIMIT (
      SELECT total( (SELECT a FROM t1) )
    )
  )
  FROM t2;
CREATE TABLE a(b);
WITH c AS(SELECT a)
    SELECT(SELECT(SELECT string_agg(b, b)
          LIMIT(SELECT 0.100000 *
            AVG(DISTINCT(SELECT 0 FROM a ORDER BY b, b, b))))
        FROM a GROUP BY b,
        b, b) FROM a EXCEPT SELECT b FROM a ORDER BY b,
    b, b;
INSERT INTO t1 VALUES('x');
INSERT INTO t2 VALUES(1);
SELECT ( 
    SELECT t2.b FROM (SELECT t2.b AS c FROM t1) GROUP BY 1 HAVING t2.b
  )
  FROM t2 GROUP BY 'constant_string';
SELECT ( 
    SELECT c FROM (SELECT t2.b AS c FROM t1) GROUP BY c HAVING t2.b
  )
  FROM t2 GROUP BY 'constant_string';
UPDATE t2 SET b=0;
SELECT ( 
    SELECT t2.b FROM (SELECT t2.b AS c FROM t1) GROUP BY 1 HAVING t2.b
  )
  FROM t2 GROUP BY 'constant_string';
SELECT ( 
    SELECT c FROM (SELECT t2.b AS c FROM t1) GROUP BY c HAVING t2.b
  )
  FROM t2 GROUP BY 'constant_string';
CREATE TABLE invoice (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      amount DOUBLE PRECISION DEFAULT NULL,
      name VARCHAR(100) DEFAULT NULL
  );
INSERT INTO invoice (amount, name) VALUES 
      (4.0, 'Michael'), (15.0, 'Bara'), (4.0, 'Michael'), (6.0, 'John');
SELECT sum(amount), name
    from invoice
  group by name
  having (select v > 6 from (select sum(amount) v) t);
SELECT (select 1 from (select sum(amount))) FROM invoice;
INSERT INTO t1 VALUES(100);
INSERT INTO t1 VALUES(20);
INSERT INTO t1 VALUES(3);
WITH out(i, j, k) AS ( 
      VALUES(1234, 5678, 9012) 
  )
  SELECT (
    SELECT (
      SELECT min(abc) = ( SELECT ( SELECT 1234 fROM (SELECT abc) ) ) 
      FROM (
        SELECT sum( out.i ) + ( SELECT sum( out.i ) ) AS abc FROM (SELECT out.j)
      )
    ) 
  ) FROM out;
INSERT INTO t1 VALUES(1), (2), (3);
INSERT INTO t2 VALUES(4), (5), (6);
SELECT ( 
    SELECT min(y) + (SELECT x) FROM (
      SELECT sum(a) AS x, b AS y FROM t2
    )
  )
  FROM t1;
SELECT ( 
    SELECT min(y) + (SELECT (SELECT x)) FROM (
      SELECT sum(a) AS x, b AS y FROM t2
    )
  )
  FROM t1;
SELECT (
    SELECT (SELECT x) FROM (
      SELECT sum(a) AS x, b AS y FROM t2
      ) GROUP BY y
    )
  FROM t1;
SELECT (
    SELECT (SELECT (SELECT x)) FROM (
      SELECT sum(a) AS x, b AS y FROM t2
      ) GROUP BY y
    )
  FROM t1;
DROP TABLE IF EXISTS t0;
DROP TABLE IF EXISTS t1;
CREATE TABLE t0(c1, c2);
INSERT INTO t0 VALUES(1,2);
CREATE TABLE t1(c3, c4);
INSERT INTO t1 VALUES(3,4);
SELECT * FROM t0 WHERE EXISTS (SELECT 1 FROM t1 GROUP BY c3 HAVING ( SELECT count(*) FROM (SELECT 1 UNION ALL SELECT sum(DISTINCT c1) ) ) ) BETWEEN 1 AND 1;
