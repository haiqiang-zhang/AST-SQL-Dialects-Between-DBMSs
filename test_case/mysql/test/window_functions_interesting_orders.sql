
CREATE TABLE t1 ( a INTEGER, b INTEGER, c INTEGER );

-- Fill in some data, so we have nonzero costs.
INSERT INTO t1 (a,b,c) VALUES (1,2,3);
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;

-- Simple partition by and order.
--replace_regex $elide_metrics
EXPLAIN FORMAT=tree SELECT SUM(c) OVER (PARTITION BY a ORDER BY b) FROM t1;

-- Add a second, compatible window. It should be handled using the same sort.
--replace_regex $elide_metrics
EXPLAIN FORMAT=tree SELECT SUM(c) OVER (PARTITION BY a ORDER BY b), SUM(c) OVER (ORDER BY a,b) FROM t1;

-- Swap orderings of two windows to get by with one sort.
--replace_regex $elide_metrics
EXPLAIN FORMAT=tree SELECT SUM(b) OVER (PARTITION BY a), SUM(c) OVER (ORDER BY a,b) FROM t1;

-- Two incompatible windows;

-- Create an index. It should be usable for eliding the sort.
CREATE INDEX idx ON t1 (a, b);
ALTER TABLE t1 DROP INDEX idx;

-- Window sorts should also be usable for final ORDER BY (sortahead).
--replace_regex $elide_metrics
EXPLAIN FORMAT=tree SELECT a, SUM(c) OVER (PARTITION BY a) FROM t1 ORDER BY a;

-- We can even sortahead by a window function, as long as it's processed
-- before the final sort. Check that we move the window to be sorted on
-- earlier in the list.
--replace_regex $elide_metrics
EXPLAIN FORMAT=tree SELECT a, SUM(c) OVER (ORDER BY b), AVG(c) OVER (ORDER BY a), SUM(c) OVER (PARTITION BY a) AS x FROM t1 ORDER BY b, x;

-- DISTINCT cannot normally remove anything...
--replace_regex $elide_metrics
EXPLAIN FORMAT=tree SELECT DISTINCT a, SUM(c) OVER (ORDER BY b) FROM t1;

-- ...but if the window frame is static, we can use sortahead
-- (or an index).
EXPLAIN FORMAT=tree SELECT DISTINCT a, b, SUM(b) OVER (PARTITION BY a) FROM t1 ORDER BY a;

-- DISTINCT and ORDER BY together. This one is incompatible with window ordering,
-- but DISTINCT and ORDER BY should be collapsed into one (duplicate-removing) sort.
--replace_regex $elide_metrics
EXPLAIN FORMAT=tree SELECT DISTINCT a, SUM(c) OVER (ORDER BY b) FROM t1 ORDER BY a;

-- Demonstrate elision by functional dependencies from WHERE.
--replace_regex $elide_metrics
EXPLAIN FORMAT=tree SELECT SUM(a) OVER (ORDER BY b) FROM t1 WHERE b=3;

-- Finally, demonstrate elision by functional dependencies from joins.
-- Both windows should be satisfied by an index scan over a.
CREATE INDEX idx ON t1 (a);

DROP TABLE t1;

CREATE TABLE t1 (pk INT PRIMARY KEY, x INT);
CREATE TABLE t2 (pk INT PRIMARY KEY);

-- The sort for (PARTITION BY t1.x) used to be done on t2.pk, due to the
-- functional dependency t1.x = t2.pk in the join condition. But t2.pk
-- was not made available in the temporary table between the sort and the
-- aggregation, so it failed. Expect the sort to be on t1.x now.
--replace_regex $elide_metrics
EXPLAIN FORMAT=TREE
SELECT ROW_NUMBER() OVER (PARTITION BY t1.x)
FROM t1, t2 WHERE t1.x = t2.pk
GROUP BY t1.pk;

DROP TABLE t1, t2;
