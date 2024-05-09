CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT);
CREATE TABLE t3(a INT);
INSERT INTO t1 VALUES (1),(2),(5);
INSERT INTO t2 VALUES (2);
INSERT INTO t3 VALUES (3);
SELECT
IF(TRACE LIKE '%Left join [companion set %] (extra join condition = (t1.a = 5) AND (t2.a = 5))%',
   'OK', TRACE)
FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE;
DROP TABLE t1,t2,t3;
CREATE TABLE t0 (a0 INTEGER);
CREATE TABLE t1 (a1 INTEGER);
CREATE TABLE t2 (a2 INTEGER);
CREATE TABLE t3 (a3 INTEGER);
INSERT INTO t0 VALUES (0),(1);
INSERT INTO t1 VALUES (0),(1);
INSERT INTO t2 VALUES (1);
INSERT INTO t3 VALUES (1);
SELECT * FROM t0, t1 LEFT JOIN (t2,t3) ON a1=5 WHERE a0=a1 AND a0=1;
DROP TABLE t0,t1,t2,t3;
CREATE TABLE t1 (f1 INTEGER);
SELECT f1 FROM t1 GROUP BY f1 HAVING f1 = 10 AND f1 <> 11;
DROP TABLE t1;
CREATE TABLE t1 (f1 YEAR);
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER);
SELECT 1
FROM t1 LEFT JOIN (SELECT t2.*
                   FROM (t1 AS t2 INNER JOIN t1 AS t3 ON (t3.f1 = t2.f1))
                   WHERE (t3.f1 <> 1 OR t2.f1 > t2.f1)) AS dt
ON (t1.f1 = dt.f1);
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER);
SELECT * FROM t1
WHERE t1.f1 NOT IN (SELECT t2.f1
                    FROM (t1 AS t2 JOIN t1 AS t3 ON (t3.f1 = t2.f1))
                    WHERE (t3.f1 <> t2.f1 OR t3.f1 < t2.f1));
DROP TABLE t1;
CREATE TABLE t1(f1 INTEGER);
PREPARE ps FROM
"SELECT * FROM (WITH RECURSIVE qn AS (SELECT 1 FROM t1 UNION ALL
                                      SELECT 1 FROM t1 STRAIGHT_JOIN qn)
                                     SELECT * FROM qn) AS dt1,
                                     (SELECT COUNT(*) FROM t1) AS dt2";
DROP TABLE t1;
CREATE TABLE t(x INT, y INT);
INSERT INTO t VALUES (1, 10), (2, 20), (3, 30);
SELECT * FROM
  t RIGHT JOIN
  (SELECT MAX(y) AS m FROM t WHERE FALSE GROUP BY x) AS dt
  ON t.x = dt.m;
SELECT * FROM
  t LEFT JOIN
  (SELECT MAX(y) AS m FROM t WHERE FALSE GROUP BY x) AS dt
  ON t.x = dt.m;
SELECT * FROM
  t AS t1 LEFT JOIN
  (t AS t2
   INNER JOIN (SELECT MAX(y) AS m FROM t WHERE FALSE GROUP BY x) AS dt
   ON t2.x = dt.m)
  ON t1.x = t2.y;
DROP TABLE t;
CREATE TABLE t1 (f1 INTEGER);
SELECT 1
 FROM t1 LEFT JOIN (SELECT * FROM t1 AS t2
                    WHERE f1 IN (SELECT f1+1 FROM t1 AS t3)) AS dt
 ON t1.f1=dt.f1;
DROP TABLE t1;
CREATE TABLE num (n INT);
INSERT INTO num VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t1 (a INT, ah INT, ai INT, KEY ix1(ai));
INSERT INTO t1 SELECT k%25, k%25, K%25 FROM
  (SELECT num1.n+num2.n*10 k FROM num num1, num num2) d1;
CREATE TABLE t2 (b INT, bh INT, bi INT, KEY ix2(bi));
INSERT INTO t2 SELECT k%25, k%25, k%25 FROM
  (SELECT num1.n+num2.n*10 k FROM num num1, num num2, num num3) d1;
DROP TABLE num, t1, t2;
CREATE TABLE t1 (f1 INTEGER, f2 INTEGER);
SELECT f1 FROM t1
WHERE EXISTS (SELECT t2.f1
              FROM (t1 AS t2 JOIN t1 AS t3 ON (t3.f1 = t2.f2))
              LEFT JOIN t1 AS t4 ON TRUE
              WHERE t4.f1 = t3.f1 OR t3.f2 >= t2.f2)
GROUP BY f1;
DROP TABLE t1;
CREATE TABLE t1 (pk INT PRIMARY KEY AUTO_INCREMENT, x INT);
CREATE TABLE t2 (x INT);
INSERT INTO t1 VALUES (), (), (), (), (), (), (), (), (), ();
INSERT INTO t2 VALUES (), (), (), (), (), (), (), (), (), ();
DROP TABLE t1,t2;
CREATE TABLE t1 (f1 INTEGER, f2 INTEGER);
SELECT 1
FROM (SELECT * FROM t1
      WHERE f1 IN (SELECT t1.f1 FROM (t1 AS t2 JOIN t1 AS t3 ON t3.f1 = t2.f2)
                   LEFT JOIN t1 AS t4 ON TRUE
                   WHERE (t3.f2 <> t3.f2 OR t4.f2 = t2.f2))) AS t5 JOIN t1 AS t6
ON TRUE;
DROP TABLE t1;
CREATE TABLE t1 (x INTEGER NOT NULL);
CREATE TABLE t2 (y INTEGER, z INTEGER);
SELECT 1 IN (
  SELECT COUNT(*) FROM t1 WHERE x NOT IN (
    SELECT 1 FROM t2 WHERE y <> y OR z <> z));
DROP TABLE t1, t2;
CREATE TABLE t (table_id BIGINT UNSIGNED);
SELECT /*+ SET_VAR(optimizer_max_subgraph_pairs = 1) */ 1
FROM t AS t1 JOIN t AS t2 USING (table_id)
     JOIN INFORMATION_SCHEMA.INNODB_TABLES AS t3 USING (table_id)
     JOIN INFORMATION_SCHEMA.INNODB_TABLES AS t4 USING (table_id)
     JOIN INFORMATION_SCHEMA.INNODB_TABLES AS t5 USING (table_id)
     JOIN INFORMATION_SCHEMA.INNODB_TABLES AS t6 USING (table_id)
     JOIN INFORMATION_SCHEMA.INNODB_TABLES AS t7 USING (table_id)
     JOIN INFORMATION_SCHEMA.INNODB_TABLES AS t8 USING (table_id);
DROP TABLE t;
CREATE TABLE t0 (x INT) ENGINE = MyISAM;
CREATE TABLE t1 (x INT) ENGINE = InnoDB;
SELECT /*+ SET_VAR(optimizer_max_subgraph_pairs = 1) */ 1
FROM t0 AS a NATURAL JOIN
     t0 AS b NATURAL JOIN
     t0 AS c NATURAL JOIN
     t0 AS d NATURAL JOIN
     t0 AS e NATURAL JOIN
     t0 AS f NATURAL JOIN
     t1 AS g NATURAL JOIN
     t1 AS h;
DROP TABLE t0, t1;
CREATE TABLE num (n INT);
INSERT INTO num VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 SELECT n,n FROM num UNION SELECT n+10,n+10 FROM num;
CREATE TABLE t2 (a INT, b INT);
DROP TABLE t1,t2,num;
CREATE TABLE num10 (n INT);
INSERT INTO num10 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t1(a INT, b INT, c INT);
INSERT INTO t1 SELECT NULL, x1.n+x2.n*10, NULL FROM num10 x1, num10 x2;
INSERT INTO t1 VALUES (NULL, 0, 0);
DROP TABLE num10, t1;
CREATE TABLE t2(a INT, b INT);
INSERT INTO t2 VALUES (0, 0), (0, 1), (1, 2), (NULL, 3), (NULL, 4), (NULL, 5);
DROP TABLE t2;
CREATE TABLE num10 (n INT PRIMARY KEY);
INSERT INTO num10 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t1(
  a INT,
  b INT,
  c INT,
  d INT,
  e INT,
  f INT,
  g INT,
  h INT,
  v VARCHAR(5),
  PRIMARY KEY(a,b,c),
  KEY k1 (e,f,g),
  UNIQUE KEY k2(h)
);
INSERT INTO t1
  SELECT k%25, k%50, k, k, k%25, k%50, k, k, CAST( k%25 AS CHAR(5))
  FROM (select x1.n*10+x2.n k from num10 x1, num10 x2) d1;
CREATE TABLE t2(x INT, y INT, z INT, KEY (x, y), KEY(y, x));
INSERT INTO t2(x, y) VALUES (1, 1), (2, 2), (3, 3), (4, 4);
CREATE TABLE t3 AS SELECT * FROM t2;
DROP TABLE t1, t2, t3, num10;
CREATE TABLE t1(
       a INT PRIMARY KEY,
       b INT,
       KEY(b),
       c INT
);
INSERT INTO t1
WITH RECURSIVE qn(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM qn WHERE n<100)
SELECT n,  n%5, n%7 FROM qn;
DROP TABLE t1;
CREATE TABLE num (n INT);
INSERT INTO num VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t1(
  a INT PRIMARY KEY,
  b VARCHAR(128),
  c INT
);
INSERT INTO t1 SELECT k, CAST(100+k AS CHAR(10)), k
FROM (SELECT x1.n+x2.n*10 AS k FROM num x1, num x2) d1;
DROP TABLE num, t1;
CREATE TABLE t1 (
  a INT,
  b INT,
  c INT,
  d INT,
  e INT,
  f INT,
  g INT,
  PRIMARY KEY(a),
  KEY k1 (b,d), --  'b' and 'd' are indepdendent.
  KEY k2 (b,e), -- 'b' is funtionally dependent on 'e'.
  KEY k3 (b,g), -- 'b' is funtionally dependent on 'g'.
  KEY k4 (f,g) -- 'f' and 'g' are independet.
);
INSERT INTO t1
WITH RECURSIVE qn(n) AS
(SELECT 0 UNION ALL SELECT n+1 FROM qn WHERE n<255)
SELECT n AS a, n DIV 16 AS b, n % 16 AS c, n % 16 AS d, n DIV 8 AS e,
  n % 32 AS f, n DIV 8 AS g FROM qn;
DROP TABLE t1;
CREATE TABLE t1 (
  a INT PRIMARY KEY,
  b INT,
  c INT,
  d INT,
  e INT,
  KEY k1 (b,c)
);
DROP TABLE t1;
CREATE TABLE t1 (a int, b int);
DROP TABLE t1;
CREATE TABLE t1 (
  a INT,
  b INT,
  c INT,
  PRIMARY KEY(a),
  KEY k_b(b),
  KEY k_c(c)
);
INSERT INTO t1 VALUES (1,1,1);
CREATE TABLE t2 (
  a INT PRIMARY KEY,
  b INT
);
INSERT INTO t2 WITH RECURSIVE qn(n) AS
(SELECT 1 UNION ALL SELECT n+1 FROM qn WHERE n<50) SELECT n, n FROM qn;
DROP TABLE t1,t2;
CREATE TABLE t1
(
  a INT,
  b INT,
  c INT,
  PRIMARY KEY(a),
  KEY k2 (b,c)
);
INSERT INTO t1
WITH RECURSIVE qn(n) AS (SELECT 10 UNION ALL SELECT n-1 FROM qn WHERE n>0)
SELECT n, 1, n FROM qn;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT, KEY k1 (a));
INSERT INTO t1 VALUES (1,1),(2,2),(1,1),(2,2),(1,1),(2,2),(1,1),(2,2),(1,1),(2,2),(1,1),(2,2);
DROP TABLE t1;
CREATE TABLE t1 (
  a INT PRIMARY KEY,
  b INT NOT NULL,
  c INT,
  KEY k_b(b),
  KEY k_c(c)
);
INSERT INTO t1 WITH RECURSIVE qn(n) AS
(SELECT 1 UNION ALL SELECT n+1 FROM qn WHERE n<30) SELECT n, n/2, n/2 FROM qn;
DROP TABLE t1;
CREATE TABLE t1 (
  a INT PRIMARY KEY,
  b INT
);
CREATE TABLE t2 (
  k INT,
  l INT,
  PRIMARY KEY(k)
);
INSERT INTO t1 WITH RECURSIVE qn(n) AS
(SELECT 0 UNION ALL SELECT n+1 FROM qn WHERE n<29) SELECT n, n FROM qn;
INSERT INTO t2 WITH RECURSIVE qn(n) AS
(SELECT 0 UNION ALL SELECT n+1 FROM qn WHERE n<19) SELECT n, n%10 FROM qn;
DROP TABLE t1,t2;
CREATE TABLE t(x INT, y INT);
INSERT INTO t VALUES (1, 2), (2, 3);
PREPARE ps FROM
'SELECT *
 FROM t AS t1 LEFT JOIN t AS t2 ON t1.x=t2.x AND t1.y IN (SELECT x FROM t)';
PREPARE ps FROM
'SELECT *
 FROM t AS t1 LEFT JOIN t AS t2 ON t1.x=t2.x AND t1.y IN (SELECT x FROM t)';
DROP TABLE t;
CREATE TABLE t(x VARCHAR(100), FULLTEXT KEY (x));
INSERT INTO t VALUES ('abc'), ('xyz'), ('abc abc');
PREPARE ps FROM
'SELECT x, MATCH(x) AGAINST (''abc'') AS score FROM t
 GROUP BY x HAVING MATCH(x) AGAINST(''abc'') > 0';
PREPARE ps FROM
'SELECT x, MATCH(x) AGAINST (''abc'') AS score FROM t
 GROUP BY x HAVING MATCH(x) AGAINST(''abc'') > 0';
DROP TABLE t;
