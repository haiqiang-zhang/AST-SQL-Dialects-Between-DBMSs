CREATE TABLE t1_a(a INTEGER PRIMARY KEY, b TEXT);
CREATE TABLE t1_b(c INTEGER PRIMARY KEY, d TEXT);
CREATE TABLE t1_c(e INTEGER PRIMARY KEY, f TEXT);
INSERT INTO t1_a VALUES(1, 'one'), (4, 'four');
INSERT INTO t1_b VALUES(2, 'two'), (5, 'five');
INSERT INTO t1_c VALUES(3, 'three'), (6, 'six');
CREATE VIEW t1 AS 
    SELECT a, b FROM t1_a   UNION ALL
    SELECT c, d FROM t1_b   UNION ALL
    SELECT e, f FROM t1_c;
CREATE TABLE i1(x);
INSERT INTO i1 VALUES(2), (5), (6), (1);
SELECT a, b FROM (
    SELECT a, b FROM t1_a   UNION ALL
    SELECT c, d FROM t1_b   UNION ALL
    SELECT e, f FROM t1_c
  ) ORDER BY a;
SELECT a, b FROM t1 ORDER BY a;
SELECT a, b FROM i1, t1 WHERE a=x ORDER BY a;
CREATE TABLE t0(c0 INT);
INSERT INTO t0 VALUES(0);
SELECT * FROM (SELECT t1.a, t1.b AS b, t0.c0 FROM t0, t1);
SELECT * FROM (SELECT t1.a, t1.b AS b, t0.c0 FROM t0, t1) WHERE b=2;
CREATE TABLE t2_a(k INTEGER PRIMARY KEY, v TEXT);
CREATE TABLE t2_b(k INTEGER PRIMARY KEY, v TEXT);
CREATE VIEW t2 AS 
    SELECT * FROM t2_a 
    UNION ALL 
    SELECT * FROM t2_b;
SELECT x1.*, x2.* FROM t2 AS x1, t2 AS x2 WHERE x1.k=x2.k+1;
SELECT * FROM t1, t2 ORDER BY +k;
SELECT * FROM t1, t2 ORDER BY k;
CREATE TABLE t3_a(k INTEGER PRIMARY KEY, v TEXT);
INSERT INTO t3_a VALUES(2,'ii');
CREATE TABLE t3_b(k INTEGER PRIMARY KEY, v TEXT);
CREATE VIEW t3 AS
    SELECT * FROM t3_a
    UNION ALL
    SELECT * FROM t3_b;
SELECT * FROM t1, t3 ORDER BY k;
INSERT INTO t1_a VALUES(123, 't1_a');
INSERT INTO t3_a VALUES(456, 't3_a');
SELECT * FROM t1, t3 ORDER BY k;
SELECT * FROM (SELECT * FROM t1, t3) ORDER BY k;
SELECT * FROM (SELECT * FROM t1, t3), (
    SELECT max(a) OVER () FROM t1
      UNION ALL
    SELECT min(a) OVER () FROM t1
  )
  ORDER BY k;
SELECT * FROM (SELECT * FROM t1, t3), (
    SELECT group_concat(a) OVER (ORDER BY a), 
           group_concat(a) OVER (ORDER BY a),
           group_concat(a) OVER (ORDER BY a),
           group_concat(a) OVER (ORDER BY a),
           group_concat(a) OVER (ORDER BY a),
           group_concat(a) OVER (ORDER BY a),
           group_concat(a) OVER (ORDER BY a),
           group_concat(a) OVER (ORDER BY a),
           group_concat(a) OVER (ORDER BY a)
    FROM t1
  )
  ORDER BY k;
SELECT * FROM (SELECT * FROM t1, t3) AS o, (
    SELECT * FROM t1 LEFT JOIN t3 ON a=k
  );
INSERT INTO t1_a VALUES(0,NULL);
INSERT INTO t3_a VALUES(4,'iv');
INSERT INTO t3_b VALUES(NULL,'iii');
INSERT INTO t3_b VALUES(NULL,'v');
SELECT *, '+' FROM t1 LEFT JOIN t2 ON (a NOT IN(SELECT v FROM t1, t3 WHERE a=k)=NOT EXISTS(SELECT 1 FROM t1 LEFT JOIN t3 ON (a=k)));
SELECT *, '+' FROM t1 LEFT JOIN t3 ON (a NOT IN(SELECT v FROM t1 LEFT JOIN t2 ON (a=k))=k);
CREATE TABLE t4(a,b);
INSERT INTO t4 VALUES(7,8);
CREATE TABLE t5(a,b);
INSERT INTO t5 VALUES(9,10);
WITH x(c) AS (
    SELECT 1000 FROM t1 UNION ALL SELECT 800 FROM t2
  ),
  y(d) AS (
    SELECT  100 FROM t3 UNION ALL SELECT 400 FROM t4
  )
  SELECT * FROM t5, x, y;
WITH c1(x) AS (VALUES(0) UNION ALL SELECT 100+x FROM c1 WHERE x<100 UNION ALL SELECT 1+x FROM c1 WHERE x<1)
  SELECT x, y, '|'
    FROM c1 AS x1, (SELECT x+1 AS y FROM c1 WHERE x<1 UNION ALL SELECT 1+x FROM c1 WHERE 1<x) AS x2
   ORDER BY x, y;
INSERT INTO t0 VALUES(0);
CREATE VIEW v0(c0) AS SELECT CAST(t0.c0 AS INTEGER) FROM t0;
SELECT t1.a, t1.b, t0.c0 AS c, v0.c0 AS d FROM t0 LEFT JOIN v0 ON v0.c0>'0',t1;
SELECT * FROM (SELECT t1.a, t1.b, t0.c0 AS c, v0.c0 AS d FROM t0 LEFT JOIN v0 ON v0.c0>'0',t1) WHERE b=2;
SELECT * FROM (SELECT t1.a, t1.b, t0.c0 AS c, v0.c0 AS d FROM t0 LEFT JOIN v0 ON v0.c0>'0',t1) WHERE b=2.0;
SELECT * FROM (SELECT t1.a, t1.b, t0.c0 AS c, v0.c0 AS d FROM t0 LEFT JOIN v0 ON v0.c0>'0',t1) WHERE b='2';
SELECT * FROM (SELECT t1.a, t1.b, t0.c0 AS c, v0.c0 AS d FROM t0 LEFT JOIN v0 ON v0.c0>'0',t1) WHERE b=2;
SELECT * FROM (SELECT t1.a, t1.b, t0.c0 AS c, v0.c0 AS d FROM t0 LEFT JOIN v0 ON v0.c0>'0',t1) WHERE b=2.0;
SELECT * FROM (SELECT t1.a, t1.b, t0.c0 AS c, v0.c0 AS d FROM t0 LEFT JOIN v0 ON v0.c0>'0',t1) WHERE b='2';
SELECT * FROM (SELECT t1.a, t1.b, t0.c0 AS c, v0.c0 AS d FROM t0 LEFT JOIN v0 ON v0.c0>'0',t1) WHERE b=2;
SELECT * FROM (SELECT t1.a, t1.b, t0.c0 AS c, v0.c0 AS d FROM t0 LEFT JOIN v0 ON v0.c0>'0',t1) WHERE b=2.0;
SELECT * FROM (SELECT t1.a, t1.b, t0.c0 AS c, v0.c0 AS d FROM t0 LEFT JOIN v0 ON v0.c0>'0',t1) WHERE b='2';
