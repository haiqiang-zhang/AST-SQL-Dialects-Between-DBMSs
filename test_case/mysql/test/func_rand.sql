

CREATE TABLE t ( i1 INT, i2 INT);
let $query= INSERT INTO t SELECT MAX(i1), FLOOR(RAND(0)*1000) FROM t;
SELECT * FROM t;

-- Use a simple random expression on a non-empty table.
INSERT INTO t VALUES (1,1),(2,2),(3,3);
SELECT * FROM t;

-- Use a combined random and INNER_TABLE_BIT expression on an empty table.
DELETE FROM t;
let $query= INSERT INTO t SELECT MAX(i1), FLOOR(RAND(0)*1000)
  + EXTRACT(YEAR FROM NOW()) DIV 1000 FROM t;
SELECT * FROM t;

-- Use a combined random and INNER_TABLE_BIT expression on a non-empty table.
INSERT INTO t VALUES (1,1),(2,2),(3,3);
SELECT * FROM t;

-- Use a combined random and INNER_TABLE_BIT expression with GROUP BY
-- on a non-empty table.
let $query= INSERT INTO t SELECT MAX(i1), FLOOR(RAND(0)*1000)
  + EXTRACT(YEAR FROM NOW()) DIV 1000 FROM t GROUP BY i2;
SELECT i1 FROM t;
SELECT i2 FROM t;

DROP TABLE t;

CREATE TABLE t (i INT);
INSERT INTO t VALUES (1), (2), (3);

-- An uncorrelated derived table on the inner side of a join should
-- only be materialized once. The hypergraph optimizer used to
-- rematerialize it for every evaluation of the inner side if it was
-- non-deterministic.
SELECT r FROM t LEFT JOIN (SELECT RAND(0) AS r) AS dt ON TRUE;

-- If the inner side is a correlated derived table, it should be
-- rematerialized for each row in the outer table. This was done
-- correctly also before the fix. Verify that it still is.
--sorted_result
SELECT r FROM t LEFT JOIN LATERAL (SELECT i, RAND(0) AS r) AS dt ON TRUE;

DROP TABLE t;
