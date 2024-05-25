CREATE TABLE t0 (
  i0 INTEGER NOT NULL
);
INSERT INTO t0 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t1 (
  pk INTEGER PRIMARY KEY,
  i1 INTEGER NOT NULL,
  i2 INTEGER NOT NULL,
  INDEX k1 (i1)
) ENGINE=InnoDB;
INSERT INTO t1
SELECT a0.i0 + 10*a1.i0 + 100*a2.i0,
       (a0.i0 + 10*a1.i0 + 100*a2.i0) % 50,
       a0.i0 + 10*a1.i0 + 100*a2.i0
FROM t0 AS a0, t0 AS a1, t0 AS a2;
CREATE TABLE t2 (
  pk INTEGER PRIMARY KEY,
  i1 INTEGER NOT NULL,
  i2 INTEGER NOT NULL,
  INDEX k1 (i1)
) ENGINE=InnoDB;
INSERT INTO t2
SELECT a0.i0 + 10*a1.i0 + 100*a2.i0,
       (a0.i0 + 10*a1.i0 + 100*a2.i0) % 500,
       a0.i0 + 10*a1.i0 + 100*a2.i0
FROM t0 AS a0, t0 AS a1, t0 AS a2;
SELECT *
FROM t1 JOIN t2 ON t1.i1=t2.i1
WHERE t2.i2 > 3
ORDER BY t1.i1 LIMIT 20;
DROP TABLE t0, t1, t2;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4);
INSERT INTO t2 VALUES (1),(2);
SELECT t1.a, t2.a FROM t1 JOIN t2
  ON t1.a+t2.a = (SELECT COUNT(*) FROM t1);
SELECT a + (SELECT SUM(a) + (SELECT COUNT(a) FROM t1) FROM t1) AS cnt
  FROM t2;
SELECT TRACE NOT RLIKE '"final_filtering_effect": 1' AS OK
  FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE;
DROP TABLE t1, t2;
