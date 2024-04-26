
CREATE TABLE r(a INT);
INSERT INTO r VALUES (1), (2), (-1), (-2);
CREATE TABLE s(a INT);
INSERT INTO s VALUES (1), (10), (20), (-10), (-20);
CREATE TABLE t(a INT);
INSERT INTO t VALUES (10), (100), (200), (-100), (-200);

-- Uncomment this to get trace of query term tree as built for each query:
-- SET SESSION debug = 'd,ast:O,/tmp/mysqld.trace';
let $query = (SELECT * FROM r ORDER BY a LIMIT 2) LIMIT 4;
DROP PREPARE q;
let $query = ((SELECT 1 LIMIT 3) LIMIT 2) LIMIT 1;
let $query = ((SELECT 1 LIMIT 1) LIMIT 2) LIMIT 3;
let $query = ( (((SELECT 1 LIMIT 1) LIMIT 2) LIMIT 3) UNION ALL
              (((SELECT 1 LIMIT 3) LIMIT 2) LIMIT 1)
              ORDER BY 1 LIMIT 5 )
            LIMIT 3;
SET @a = '2';
SET @a = 2;
DROP PREPARE p;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11);
let $query = ((SELECT a AS c FROM t1 LIMIT 10) LIMIT 6) ORDER BY c+1 LIMIT 5;
DROP TABLE t1;
let $query = ((SELECT a AS c FROM r LIMIT 10) LIMIT 6) ORDER BY a+1 LIMIT 20;

let $query = ( ( VALUES ROW(1,1), ROW(2,2), ROW(3,3), ROW(4,4), ROW(5,5)
                 LIMIT 4)
               LIMIT 3)
             ORDER BY column_0, column_1;

let $query = ( ( VALUES ROW(1,1), ROW(2,2), ROW(3,3), ROW(4,4), ROW(5,5)
                 ORDER BY column_0 LIMIT 4)
               LIMIT 3)
             ORDER BY (SELECT column_0), (SELECT column_1) LIMIT 2;

-- This query returns wrong results with the old optimizer. The
-- hypergraph optimizer returns correct results.
let $query = ( ( (VALUES ROW(1,1), ROW(2,2), ROW(3,3), ROW(4,4), ROW(-1,-1))
                 ORDER BY column_0 LIMIT 4)
               LIMIT 3)
             ORDER BY 1;

let $query = (SELECT * FROM r ORDER BY a LIMIT 5) ORDER BY -a LIMIT 4;
DROP PREPARE q;
let $query =
    ((SELECT * FROM r ORDER BY a LIMIT 5) ORDER BY -a LIMIT 4)
    ORDER BY a LIMIT 3;
DROP PREPARE q;
let $query =
    ( ((SELECT * FROM r ORDER BY a LIMIT 5) ORDER BY -a LIMIT 4)
      ORDER BY a LIMIT 3)
    ORDER BY -a LIMIT 2;
DROP PREPARE q;
let $query =
    ( ( (SELECT a AS c FROM r ORDER BY a LIMIT 5) ORDER BY -c LIMIT 4)
      ORDER BY c LIMIT 3)
    ORDER BY -c LIMIT 2;
DROP PREPARE q;
( ( (SELECT a AS c FROM r ORDER BY a LIMIT 5) ORDER BY -a LIMIT 4)
  ORDER BY c LIMIT 3)
ORDER BY -c LIMIT 2;
( ( (SELECT a AS c FROM r ORDER BY a LIMIT 5) ORDER BY -c LIMIT 4)
  ORDER BY a LIMIT 3)
ORDER BY -c LIMIT 2;
( ( (SELECT a AS c FROM r ORDER BY a LIMIT 5) ORDER BY -c LIMIT 4)
  ORDER BY c LIMIT 3)
ORDER BY -a LIMIT 2;
let $query =
    (SELECT * FROM r UNION ALL SELECT * FROM s ORDER BY a LIMIT 10)
    UNION ALL
    (SELECT * FROM r UNION ALL SELECT * FROM s ORDER BY a LIMIT 5) LIMIT 7;
let $query =
    (SELECT * FROM r UNION ALL SELECT * FROM s ORDER BY a LIMIT 10)
    UNION ALL
    (SELECT * FROM r UNION DISTINCT SELECT * FROM s) LIMIT 7;
let $query =
    (((SELECT * from r UNION SELECT * FROM s UNION ALL SELECT * from t) LIMIT 3) LIMIT 5);
let $query =
     (SELECT * FROM r ORDER BY a LIMIT 1);
let $1=63;
 let $query =
     ($query
      ORDER BY a LIMIT 1);
 dec $1;

let $query =
    ($query
     ORDER BY a LIMIT 1);

DROP TABLE r, s, t;
CREATE TABLE t(a INT);
INSERT INTO t VALUES (1), (2);

let $query =
    WITH RECURSIVE cte (n) AS
    (  (SELECT a FROM t UNION DISTINCT SELECT a FROM t LIMIT 1)
       UNION ALL
       SELECT n + 1 FROM cte WHERE n < 5 )
    SELECT * FROM cte;

let $query=
    WITH RECURSIVE cte (n) AS
    (  (SELECT a FROM t UNION DISTINCT SELECT a FROM t LIMIT 2)
       UNION ALL
       SELECT n + 1 FROM cte WHERE n < 5 )
    SELECT * FROM cte;

let $query=
    WITH RECURSIVE cte (n) AS
    (  (SELECT a FROM t UNION SELECT a FROM t LIMIT 2)
       UNION ALL
       SELECT n + 1 FROM cte WHERE n < 5 LIMIT 7)
    SELECT * FROM cte;

DROP TABLE t;
CREATE TABLE t1 (a INT NOT NULL, b CHAR (10) NOT NULL);
INSERT INTO t1 VALUES (1,'a'), (2,'b'), (3,'c'), (3,'c');
CREATE TABLE t2 (a INT NOT NULL, b CHAR (10) NOT NULL);
INSERT INTO t2 VALUES (3,'c'), (4,'d'), (5,'f'), (6,'e');

let $query =
    SELECT * FROM t1 WHERE a IN
        ( SELECT a FROM t1 UNION DISTINCT
          SELECT a FROM t1 ORDER BY (SELECT a) ) UNION DISTINCT
    SELECT * FROM t1
    ORDER BY (SELECT a);
CREATE TABLE t4 AS SELECT * from t1;
DELETE FROM t4;
INSERT INTO t4 SELECT a,b FROM t1 UNION DISTINCT SELECT a,b FROM t2;
SELECT * FROM t4;
SELECT FOUND_ROWS();

DROP TABLE t1, t2, t4;
CREATE TABLE t1 (f1 INT);
CREATE TABLE t2 (f1 INT, f2 INT ,f3 DATE);
CREATE TABLE t3 (f1 INT, f2 CHAR(10));
CREATE TABLE t4
( SELECT t2.f3 AS sdate
  FROM t1
  LEFT OUTER JOIN t2 ON (t1.f1 = t2.f1)
  INNER JOIN t3 ON (t2.f2 = t3.f1)
  ORDER BY t1.f1, t3.f1, t2.f3 )
UNION DISTINCT
( SELECT CAST('2004-12-31' AS DATE) AS sdate
  FROM t1
  LEFT OUTER JOIN t2 ON (t1.f1 = t2.f1)
  INNER JOIN t3 ON (t2.f2 = t3.f1)
  GROUP BY t1.f1
  ORDER BY t1.f1, t3.f1, t2.f3 )
ORDER BY sdate;
DROP TABLE t1, t2, t3, t4;
