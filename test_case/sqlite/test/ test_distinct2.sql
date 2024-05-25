CREATE TABLE t1(x INTEGER PRIMARY KEY);
INSERT INTO t1 VALUES(0),(1),(2);
CREATE TABLE t2 AS
     SELECT DISTINCT a.x AS aa, b.x AS bb
      FROM t1 a, t1 b;
SELECT *, '|' FROM t2 ORDER BY aa, bb;
DROP TABLE t2;
CREATE TABLE t2 AS
     SELECT DISTINCT a.x AS aa, b.x AS bb
       FROM t1 a, t1 b
      WHERE a.x IN t1 AND b.x IN t1;
SELECT *, '|' FROM t2 ORDER BY aa, bb;
CREATE TABLE t102 (i0 TEXT UNIQUE NOT NULL);
INSERT INTO t102 VALUES ('0'),('1'),('2');
DROP TABLE t2;
CREATE TABLE t2 AS
    SELECT DISTINCT * 
    FROM t102 AS t0 
    JOIN t102 AS t4 ON (t2.i0 IN t102)
    NATURAL JOIN t102 AS t3
    JOIN t102 AS t1 ON (t0.i0 IN t102)
    JOIN t102 AS t2 ON (t2.i0=+t0.i0 OR (t0.i0<>500 AND t2.i0=t1.i0));
SELECT *, '|' FROM t2 ORDER BY 1, 2, 3, 4, 5;
CREATE TABLE t4(a,b,c,d,e,f,g,h,i,j);
INSERT INTO t4 VALUES(0,1,2,3,4,5,6,7,8,9);
INSERT INTO t4 SELECT * FROM t4;
INSERT INTO t4 SELECT * FROM t4;
CREATE INDEX t4x ON t4(c,d,e);
SELECT DISTINCT a,b,c FROM t4 WHERE a=0 AND b=1;
SELECT DISTINCT a,b,c,d FROM t4 WHERE a=0 AND b=1;
SELECT DISTINCT d,a,b,c FROM t4 WHERE a=0 AND b=1;
SELECT DISTINCT a,b,c,d,e FROM t4 WHERE a=0 AND b=1;
SELECT DISTINCT a,b,c,d,e,f FROM t4 WHERE a=0 AND b=1;
CREATE TABLE t5(a INT, b INT);
CREATE UNIQUE INDEX t5x ON t5(a+b);
INSERT INTO t5(a,b) VALUES(0,0),(1,0),(1,1),(0,3);
CREATE TEMP TABLE out AS SELECT DISTINCT a+b FROM t5;
SELECT * FROM out ORDER BY 1;
CREATE TABLE t6a(x INTEGER PRIMARY KEY);
INSERT INTO t6a VALUES(1);
CREATE TABLE t6b(y INTEGER PRIMARY KEY);
INSERT INTO t6b VALUES(2),(3);
SELECT DISTINCT x, x FROM t6a, t6b;
CREATE TABLE t7(a, b, c);
WITH s(i) AS (
    SELECT 1 UNION ALL SELECT i+1 FROM s WHERE (i+1)<200
  )
  INSERT INTO t7 SELECT i/100, i/50, i FROM s;
SELECT DISTINCT a, b FROM t7;
SELECT DISTINCT a, b+1 FROM t7;
CREATE INDEX i7 ON t7(a, b+1);
ANALYZE;
SELECT DISTINCT a, b+1 FROM t7;
CREATE TABLE t8(a, b, c);
WITH s(i) AS (
    SELECT 1 UNION ALL SELECT i+1 FROM s WHERE (i+1)<100
  )
  INSERT INTO t8 SELECT i/40, i/20, i/40 FROM s;
SELECT DISTINCT a, b, c FROM t8;
SELECT DISTINCT a, b, c FROM t8 WHERE b=3;
CREATE INDEX i8 ON t8(a, c);
ANALYZE;
SELECT DISTINCT a, b, c FROM t8 WHERE b=3;
CREATE TABLE t9(v);
INSERT INTO t9 VALUES 
    ('abcd'), ('Abcd'), ('aBcd'), ('ABcd'), ('abCd'), ('AbCd'), ('aBCd'), 
    ('ABCd'), ('abcD'), ('AbcD'), ('aBcD'), ('ABcD'), ('abCD'), ('AbCD'), 
    ('aBCD'), ('ABCD'),
    ('wxyz'), ('Wxyz'), ('wXyz'), ('WXyz'), ('wxYz'), ('WxYz'), ('wXYz'), 
    ('WXYz'), ('wxyZ'), ('WxyZ'), ('wXyZ'), ('WXyZ'), ('wxYZ'), ('WxYZ'), 
    ('wXYZ'), ('WXYZ');
SELECT DISTINCT v COLLATE NOCASE, v FROM t9 ORDER BY +v;
CREATE INDEX i9 ON t9(v COLLATE NOCASE, v);
ANALYZE;
SELECT DISTINCT v COLLATE NOCASE, v FROM t9 ORDER BY +v;
ANALYZE;
ANALYZE;
ANALYZE;
CREATE TABLE t0 (c0, c1, c2, PRIMARY KEY (c0, c1));
INSERT INTO t0(c2) VALUES (0),(1),(3),(4),(5),(6),(7),(8),(9),(10),(11);
INSERT INTO t0(c1) VALUES ('a');
SELECT DISTINCT t0.c0, t1._rowid_, t0.c1 FROM t1 CROSS JOIN t0 ORDER BY t0.c0;
ANALYZE;
SELECT DISTINCT t0.c0, t1._rowid_, t0.c1 FROM t1 CROSS JOIN t0 ORDER BY t0.c0;
CREATE TABLE t3(x INTEGER PRIMARY KEY);
INSERT INTO t3 VALUES(1);
ANALYZE;
INSERT INTO t0(c2) VALUES (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL);
INSERT INTO t0(c2) VALUES('a');
SELECT DISTINCT * FROM t0 WHERE NULL IS t0.c0;
ANALYZE;
SELECT DISTINCT * FROM t0 WHERE NULL IS c0;
