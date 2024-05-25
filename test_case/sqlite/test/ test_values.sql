CREATE TABLE x1(a, b, c);
INSERT INTO x1 VALUES(1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4);
SELECT * FROM x1;
DELETE FROM x1;
INSERT INTO x1 VALUES(1, 1, 1), (2, 2, 2), (3, 3, 3) UNION ALL SELECT 4, 4, 4;
SELECT * FROM x1;
DELETE FROM x1;
INSERT INTO x1 
  VALUES(1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4), (5, 5, 5) 
  UNION ALL SELECT 6, 6, 6;
SELECT * FROM x1;
DELETE FROM x1;
INSERT INTO x1 
  VALUES(1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4)
  UNION ALL SELECT 6, 6, 6;
SELECT * FROM x1;
DELETE FROM x1;
INSERT INTO x1 VALUES(1, 1, 1), (2, 2, 2), (3, 3, 3) UNION ALL SELECT 6, 6, 6;
SELECT * FROM x1;
DELETE FROM x1;
SELECT * FROM x1;
INSERT INTO x1 VALUES
      (1, 1, 1), 
      (2, 2, 2), 
      (3, 3, 3), 
      (4, 4, 4), 
      (5, 5, 5), 
      (6, 6, 6), 
      (7, 7, 7), 
      (8, 8, 8), 
      (9, 9, 9), 
      (10, 10, 10);
INSERT INTO x1 VALUES
      (1, 1, 1), 
      (2, 2, 2), 
      (3, 3, 3), 
      (4, 4, 4), 
      (5, 5, 5), 
      (6, 6, 6), 
      (7, 7, 7), 
      (8, 8, 8), 
      (9, 9, 9), 
      (10, 10, 10)
      UNION ALL 
      SELECT 5, 12, 12
      ORDER BY 1;
CREATE TABLE y1(x, y);
DELETE FROM y1;
INSERT INTO y1 VALUES(1, 2), (3, 4), (row_number() OVER (), 5);
SELECT * FROM y1;
DELETE FROM y1;
INSERT INTO y1 VALUES(1, 2), (3, 4), (row_number() OVER (), 6)
    , (row_number() OVER (), 7);
SELECT * FROM y1;
DELETE FROM x1;
SELECT * FROM x1;
DELETE FROM x1;
SELECT * FROM x1;
DELETE FROM x1;
SELECT * FROM x1;
DELETE FROM x1;
SELECT * FROM x1;
DELETE FROM x1;
SELECT * FROM x1;
DELETE FROM x1;
SELECT * FROM x1;
CREATE VIEW v1 AS VALUES(1, 2, 3), (4, 5, 6), (7, 8, 9);
SELECT * FROM v1;
CREATE TABLE t1(x);
INSERT INTO t1 VALUES(1), (2);
SELECT ( VALUES( x ), ( x ) ) FROM t1;
INSERT INTO t1 VALUES('x'), ('y');
SELECT * FROM t1, (VALUES(1), (2));
VALUES(CAST(44 AS REAL)),(55);
WITH x1(a, b) AS (
    VALUES(1, 2), ('a', 'b')
  )
  SELECT * FROM x1 one, x1 two;
INSERT INTO t1 VALUES('d'), (NULL), (123);
SELECT * FROM t1 LEFT JOIN 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) );
SELECT * FROM t1 LEFT JOIN 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  );
WITH VVV AS 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 SELECT * FROM t1 LEFT JOIN VVV;
SELECT * FROM t1 LEFT JOIN 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 ON (column1=x);
SELECT * FROM t1 LEFT JOIN 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  )
 ON (column1=x);
WITH VVV AS 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 SELECT * FROM t1 LEFT JOIN VVV ON (column1=x);
SELECT * FROM t1 RIGHT JOIN 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) );
SELECT * FROM t1 RIGHT JOIN 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  );
WITH VVV AS 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 SELECT * FROM t1 RIGHT JOIN VVV;
SELECT * FROM t1 RIGHT JOIN 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 ON (column1=x);
SELECT * FROM t1 RIGHT JOIN 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  )
 ON (column1=x);
WITH VVV AS 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 SELECT * FROM t1 RIGHT JOIN VVV ON (column1=x);
SELECT * FROM t1 FULL OUTER JOIN 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 ON (column1=x);
SELECT * FROM t1 FULL OUTER JOIN 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  )
 ON (column1=x);
WITH VVV AS 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 SELECT * FROM t1 FULL OUTER JOIN VVV ON (column1=x);
SELECT count(*) FROM 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) );
SELECT count(*) FROM 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  );
WITH VVV AS 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 SELECT count(*) FROM VVV;
SELECT (SELECT column1 FROM 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
);
SELECT (SELECT column1 FROM 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  )
);
WITH VVV AS 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 SELECT (SELECT column1 FROM VVV);
SELECT * FROM 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 UNION ALL SELECT * FROM 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) );
SELECT * FROM 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  )
 UNION ALL SELECT * FROM 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  );
WITH VVV AS 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 SELECT * FROM VVV UNION ALL SELECT * FROM VVV;
SELECT * FROM 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 INTERSECT SELECT * FROM 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) );
SELECT * FROM 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  )
 INTERSECT SELECT * FROM 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  );
WITH VVV AS 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 SELECT * FROM VVV INTERSECT SELECT * FROM VVV;
SELECT * FROM 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 eXCEPT SELECT * FROM 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) );
SELECT * FROM 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  )
 eXCEPT SELECT * FROM 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  );
WITH VVV AS 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 SELECT * FROM VVV eXCEPT SELECT * FROM VVV;
SELECT * FROM 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 eXCEPT SELECT 'a', 'b';
SELECT * FROM 
  ( 
  SELECT 'a' AS column1, 'b' AS column2 
  UNION ALL SELECT 'c', 'd' UNION ALL SELECT 123, NULL
  )
 eXCEPT SELECT 'a', 'b';
WITH VVV AS 
  ( VALUES('a', 'b'), ('c', 'd'), (123, NULL) )
 SELECT * FROM VVV eXCEPT SELECT 'a', 'b';
VALUES(456), (123), (NULL) UNION ALL SELECT 122 ORDER BY 1;
VALUES (1, 2), (3, 4), (
    ( SELECT column1 FROM ( VALUES (5, 6), (7, 8) ) ),
    ( SELECT max(column2) FROM ( VALUES (5, 1), (7, 6) ) )
  );
CREATE TABLE a2(a, b, c DEFAULT 'xyz');
INSERT INTO a2(a) VALUES(3),(4);
SELECT * FROM t1;
INSERT INTO t1 VALUES('xyz');
SELECT (
      VALUES( (max(substr('abc', 1, 1), x)) ),
      (123),
      (456)
      )
  FROM t1;
PRAGMA encoding = utf16;
CREATE TABLE t2(x,y);
BEGIN;
BEGIN;
BEGIN;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1 AS SELECT * FROM (VALUES(1,2), (3,4 IN (1,2,3)));
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(x INTEGER PRIMARY KEY);
DROP TABLE t1;
CREATE TABLE t1(x INTEGER PRIMARY KEY, y, z);
INSERT INTO t1 VALUES(1,2,3);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(x INTEGER PRIMARY KEY, y, z);
INSERT INTO t1 VALUES(1,2,3);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(x INTEGER PRIMARY KEY, y, z);
INSERT INTO t1 VALUES(1,2,3);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(x INTEGER PRIMARY KEY, y, z);
INSERT INTO t1 VALUES(1,2,3);
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1 VALUES(1,2,13);
SELECT * FROM t1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;
CREATE TABLE t1(a,b);
INSERT INTO t1 VALUES(1,2);
CREATE TABLE t2(column1,column2);
INSERT INTO t2 VALUES(11,22),(33,44);
CREATE TABLE t3(d,e);
INSERT INTO t3 VALUES(3,4);
-- output verify using PG 14.2
  SELECT *
    FROM t1 CROSS JOIN t2 FULL JOIN t3 ON a=d
   ORDER BY +d, +column1;
SELECT *
    FROM t1 CROSS JOIN (VALUES(11,22),(33,44)) FULL JOIN t3 ON a=d
   ORDER BY +d, +column1;
-- output verified using PG 14.2
  SELECT *
    FROM t1 CROSS JOIN t2 FULL JOIN t3 ON a=d
   WHERE column1 IS NULL;
SELECT *
    FROM t1 CROSS JOIN (VALUES(11,22),(33,44)) FULL JOIN t3 ON a=d
   WHERE column1 IS NULL;
