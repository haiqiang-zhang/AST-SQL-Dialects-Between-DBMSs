
CREATE TABLE t1(x INT);
CREATE TABLE t2(pk INT PRIMARY KEY);
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Used to choose a table scan on t2. Should pick an index lookup.
EXPLAIN FORMAT=TREE
SELECT 1 FROM t1, LATERAL (SELECT DISTINCT t1.x) AS dt, t2
WHERE t2.pk = dt.x;

-- Used to fail because the hypergraph optimizer could not find a plan.
SELECT 1 FROM
  t1,
  LATERAL (SELECT DISTINCT t1.x) AS dt1,
  LATERAL (SELECT DISTINCT dt1.x) AS dt2
WHERE dt1.x = dt2.x;

DROP TABLE t1, t2;
