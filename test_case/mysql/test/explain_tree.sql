--

set optimizer_switch='batched_key_access=off,block_nested_loop=off,mrr_cost_based=off';


-- Basic table scan.
CREATE TABLE t1 ( f1 INT );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
DROP TABLE t1;

-- Basic INSERT.
CREATE TABLE t1 ( f1 INT );
CREATE TABLE t2 ( f1 INT );
DROP TABLE t1, t2;

-- Multi-table UPDATE.
CREATE TABLE t1 ( f1 INT );
CREATE TABLE t2 ( f2 INT );
DROP TABLE t1, t2;

-- Multi-table DELETE.
CREATE TABLE t1 ( f1 INT );
CREATE TABLE t2 ( f2 INT );
DROP TABLE t1, t2;

-- Subquery in SELECT list.
CREATE TABLE t1 ( f1 INT );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
DROP TABLE t1;

-- Index scan.
CREATE TABLE t1 ( f1 INT PRIMARY KEY );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
DROP TABLE t1;

-- Various form of grouping and aggregation.
CREATE TABLE t1 ( f1 INT, INDEX ( f1 ) );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
DROP TABLE t1;

-- Only const tables.
CREATE TABLE t1 ( f1 INT PRIMARY KEY );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
DROP TABLE t1;

-- A join (against a const table).
CREATE TABLE t1 ( f1 INT PRIMARY KEY );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
CREATE TABLE t2 ( f1 INT PRIMARY KEY );
INSERT INTO t2 SELECT * FROM t1;
DROP TABLE t1, t2;

-- Right join against a const table.
CREATE TABLE t1 ( f1 INT PRIMARY KEY );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
CREATE TABLE t2 AS SELECT * FROM t1;
DROP TABLE t1, t2;

-- Demonstrate that filters are put on the correct point with nested outer joins.
-- In particular, the isnull(t3.c) should be placed between the two left join iterators.
CREATE TABLE t1 ( a INT );
CREATE TABLE t2 ( a INT );
CREATE TABLE t3 ( a INT, b INT );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t2 VALUES ( 3 );
INSERT INTO t3 VALUES ( 2, 0 );
DROP TABLE t1, t2, t3;

-- Anti-join (due to f1 being not nullable, yet asking for NULL).
CREATE TABLE t1 ( f1 INT PRIMARY KEY );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
CREATE TABLE t2 AS SELECT * FROM t1;
DROP TABLE t1, t2;

-- Adding limit on the right side of joins.
CREATE TABLE t1 (a INT, b INT);
CREATE TABLE t2 (a INT, c INT, KEY(a));
INSERT INTO t1 VALUES (1, 1), (2, 2);
INSERT INTO t2 VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 1), (2, 2), (2, 3), (2, 4), (2, 5),
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5);
DROP TABLE t1, t2;

-- Sort.
CREATE TABLE t1 ( f1 INT );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
DROP TABLE t1;

-- Pointless materialization.
-- Also demonstrates printout of sorting without addon fields.
CREATE TABLE t1 ( a LONGBLOB, b INT );
INSERT INTO t1 VALUES ('a', 0);
DROP TABLE t1;

-- A case where we use hash deduplication for a temporary table (due to the blob).
-- We don't show explicitly that it's using hash, though.
CREATE TABLE t1 (a text, b varchar(10));
INSERT INTO t1 VALUES (repeat('1', 1300),'one'), (repeat('1', 1300),'two');
DROP TABLE t1;

-- Double limit, with unique on the way into materialization.
CREATE TABLE t1 ( f1 VARCHAR(100) );
INSERT INTO t1 VALUES ('abc');
INSERT INTO t1 VALUES ('abc');
INSERT INTO t1 VALUES ('def');
INSERT INTO t1 VALUES ('def');
INSERT INTO t1 VALUES ('ghi');
DROP TABLE t1;

-- Pointless extra limit (pushed down into the temporary table, but not removed on the outside).
CREATE TABLE t1 (a int PRIMARY KEY);
INSERT INTO t1 values (1), (2);
DROP TABLE t1;

-- Double materialization;
CREATE TABLE t1 (a INTEGER, b INTEGER);
INSERT INTO t1 VALUES (1,3), (2,4), (1,5),
(1,3), (2,1), (1,5), (1,7), (3,1),
(3,2), (3,1), (2,4);
DROP TABLE t1;

-- A subquery within WHERE. Test both dependent and independent queries.
CREATE TABLE t1 ( f1 INT PRIMARY KEY );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
DROP TABLE t1;

-- A subquery in the SELECT list of a condition subquery.
CREATE TABLE t1 ( f1 INT PRIMARY KEY );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
DROP TABLE t1;

-- Deeply nested subqueries in the SELECT list.
-- The addition is to keep the optimizer from flattening out the queries.
CREATE TABLE t1 ( f1 INT PRIMARY KEY );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
DROP TABLE t1;

-- A subquery which is pushed to a temporary table due to ordering.
CREATE TABLE t1 ( f1 INT PRIMARY KEY );
INSERT INTO t1 VALUES ( 1 );
INSERT INTO t1 VALUES ( 2 );
INSERT INTO t1 VALUES ( 3 );
DROP TABLE t1;

-- Condition pushed before filesort.
CREATE TABLE t1 (a INTEGER, b INTEGER);
INSERT INTO t1 VALUES (1,3), (2,4), (1,5),
(1,3), (2,1), (1,5), (1,7), (3,1),
(3,2), (3,1), (2,4);
DROP TABLE t1;

-- Single-table modifications don't have a JOIN, so they have a simple explain.
CREATE TABLE t1 (i INT);
DROP TABLE t1;

-- Limit pushed into filesort.
CREATE TABLE t1 (a INTEGER, b INTEGER);
INSERT INTO t1 VALUES (1,3), (2,4), (1,5),
(1,3), (2,1), (1,5), (1,7), (3,1),
(3,2), (3,1), (2,4);
DROP TABLE t1;

-- LATERAL, with two different invalidators. One of them is pushed up above
-- the join, because it's an outer join.
CREATE TABLE t1 ( a INTEGER );
CREATE TABLE t2 ( a INTEGER );
CREATE TABLE t3 ( a INTEGER );
DROP TABLE t1, t2, t3;

-- LATERAL, with a join that's pushed the same way as previously, but not
-- beyond the join involving t1.
CREATE TABLE t1 ( a INTEGER );
CREATE TABLE t2 ( a INTEGER );
CREATE TABLE t3 ( a INTEGER );
CREATE TABLE t4 ( a INTEGER );
  t2 LEFT JOIN t3 USING ( a ) CROSS JOIN
    LATERAL ( SELECT * FROM t4 WHERE t4.a = t3.a LIMIT 1 ) t4d
) ON t1.a = t4d.a;
DROP TABLE t1, t2, t3, t4;

-- Demontrate that we can print the sub-iterator for the WHERE subquery
-- that originally came from a table path.
CREATE TABLE t1 ( f1 INTEGER );
DROP TABLE t1;

-- A non-recursive CTE. The case of multiple uses is tested in derived_correlated.
CREATE TABLE t1 ( f1 INT );
CREATE TABLE t2 ( f1 INT );
DROP TABLE t1;
DROP TABLE t2;

-- A simple semijoin.
CREATE TABLE t1 (i INTEGER);
CREATE TABLE t2 (i INTEGER);
DROP TABLE t1, t2;

-- A semijoin of two const tables against a multi-table join.
CREATE TABLE t1 (pk INTEGER PRIMARY KEY, i INTEGER);
CREATE TABLE t2 (pk INTEGER PRIMARY KEY, i INTEGER);
CREATE TABLE t3 (i INTEGER);
CREATE TABLE t4 (i INTEGER);
INSERT INTO t1 VALUES (2, 3);
INSERT INTO t2 VALUES (4, 5);
DROP TABLE t1, t2, t3, t4;

-- Conditions should be pushed up above outer joins, but not above semijoins.
CREATE TABLE t1 (i INTEGER);
CREATE TABLE t2 (i INTEGER);
CREATE TABLE t3 (i INTEGER, j INTEGER);
DROP TABLE t1, t2, t3;

-- Semijoin by materialization;
set @old_opt_switch=@@optimizer_switch;
set optimizer_switch='firstmatch=off';
CREATE TABLE t1 ( a INTEGER, b INTEGER );
INSERT INTO t1 VALUES (1,1), (2,2), (3,3);
DROP TABLE t1;
set @@optimizer_switch=@old_opt_switch;

-- Same, for a NOT IN query (which then becomes an antijoin).
set @old_opt_switch=@@optimizer_switch;
set optimizer_switch='firstmatch=off';
CREATE TABLE t1 ( a INTEGER NOT NULL, b INTEGER NOT NULL );
INSERT INTO t1 VALUES (1,1), (2,2), (3,3);
DROP TABLE t1;
set @@optimizer_switch=@old_opt_switch;

-- Demonstrate that if there's aggregation within the IN, it just becomes
-- an EXISTS clause instead of the strategy above. (If this changes, one would
-- need to modify the setup of MaterializeIterator for semijoin materialization.)
set @old_opt_switch=@@optimizer_switch;
set optimizer_switch='firstmatch=off';
CREATE TABLE t1 ( a INTEGER, b INTEGER );
INSERT INTO t1 VALUES (1,1), (2,2), (3,3);
DROP TABLE t1;
set @@optimizer_switch=@old_opt_switch;

-- Semijoin by duplicate weedout.
set @old_opt_switch=@@optimizer_switch;
set optimizer_switch='firstmatch=off,materialization=off,loosescan=off';
CREATE TABLE t1 ( i INTEGER );
CREATE TABLE t2 ( i INTEGER );
INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 VALUES (2);
DROP TABLE t1;
DROP TABLE t2;
set @@optimizer_switch=@old_opt_switch;

-- Confluent weedout becomes LIMIT 1.
--
-- The only difference between this and the previous query is that t2 has
-- somewhat more data, which flips the join order. This means that the
-- weedout can go over t2 only instead of both tables, which makes it a
-- confluent weedout, which we rewrite to LIMIT 1.
set @old_opt_switch=@@optimizer_switch;
set optimizer_switch='firstmatch=off,materialization=off,loosescan=off';
CREATE TABLE t1 ( i INTEGER );
CREATE TABLE t2 ( i INTEGER );
INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 VALUES (1), (2), (3), (4);
DROP TABLE t1;
DROP TABLE t2;
set @@optimizer_switch=@old_opt_switch;

-- A simple single-table loose scan.
set @old_opt_switch=@@optimizer_switch;
set optimizer_switch='firstmatch=off,materialization=off,duplicateweedout=off,loosescan=on';
CREATE TABLE t1 ( i INTEGER, PRIMARY KEY (i) );
CREATE TABLE t2 ( i INTEGER, INDEX i1 (i) );
INSERT INTO t1 VALUES (2), (3), (4), (5);
INSERT INTO t2 VALUES (1), (2), (3), (4);
DROP TABLE t1;
DROP TABLE t2;
set @@optimizer_switch=@old_opt_switch;
CREATE TABLE t1 (
  col_int_key INTEGER,
  col_json JSON,
  KEY mv_idx ((CAST(col_json->'$[*]' AS CHAR(40) ARRAY)))
);

CREATE TABLE t2 (col_int INTEGER);

DROP TABLE t1, t2;

-- EXPLAIN ANALYZE of a simple query.
CREATE TABLE t1 (a INTEGER, b INTEGER, PRIMARY KEY ( a ));
INSERT INTO t1 VALUES (1,3), (2,4), (3,5);

-- Same, but with some parts that are never executed.
--replace_regex $elide_time
EXPLAIN ANALYZE SELECT * FROM t1 AS a, t1 AS b WHERE a.b=500;
DROP TABLE t1;

-- EXPLAIN ANALYZE FOR CONNECTION makes no sense.
--error ER_NOT_SUPPORTED_YET
EXPLAIN ANALYZE FOR CONNECTION 1;

-- EXPLAIN ANALYZE with FORMAT= is supported, but currently only for FORMAT=TREE.
--error ER_NOT_SUPPORTED_YET
EXPLAIN ANALYZE FORMAT=TRADITIONAL SELECT 1;

-- An information_schema table.
EXPLAIN FORMAT=tree SELECT * FROM INFORMATION_SCHEMA.ENGINES;

-- Union materialization directly into a temporary table (no double materialization).
CREATE TABLE t1 ( f1 INT PRIMARY KEY );
INSERT INTO t1 VALUES (1), (2), (3);

DROP TABLE t1;
CREATE TABLE t1 ( f1 INTEGER );
INSERT INTO t1 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
DROP TABLE t1;

CREATE TABLE t1(a INT, b INT);
CREATE TABLE t2(a INT, b INT);
DROP TABLE t1,t2;

CREATE TABLE t1 ( a INTEGER );
DROP TABLE t1;

CREATE TABLE t1 (a INTEGER);
DROP TABLE t1;

-- The important thing here is that the Materialize node has rows=3 and loops=1,
-- because even though it's been asked to materialize five times, it only materialized
-- one of them. The LIMIT is to avoid temporary table merging.
CREATE TABLE t1 (a INTEGER);
INSERT INTO t1 VALUES (1), (2), (3), (4), (5);
DROP TABLE t1;

-- Sets up an AlternativeIterator in the table access path.
CREATE TABLE t1 (a int);
SET sql_mode='';
SET sql_mode=DEFAULT;
DROP TABLE t1;

CREATE TABLE t1 (a INTEGER);
  SELECT 1 IN (SELECT 1 FROM t1) FROM t1 WHERE 1=2;

DROP TABLE t1;

--
-- Demonstrates printing an index range scan with too many ranges to print
-- (more than three). The pushed index condition is redundant.
--

CREATE TABLE t1 (pk INTEGER NOT NULL, a INTEGER, b INTEGER, KEY (a), KEY (b), PRIMARY KEY (pk));
  SELECT * FROM t1 WHERE a IN (2,4,6,8,10);

-- Also, with printing of a reverse-scan iterator.
EXPLAIN FORMAT=tree
  SELECT * FROM t1 WHERE a IN (2,4,6,8,10) ORDER BY a DESC;

--
-- EXPLAIN ANALYZE on an IndexMergeIterator. Also demonstrates printing of
-- scanning over clustered primary keys. (The filter is redundant.)
--

--replace_regex $elide_time
EXPLAIN ANALYZE
  SELECT /*+ INDEX_MERGE(t1) */ * FROM t1 WHERE pk > 1 OR a > 2 OR b > 3;

DROP TABLE t1;

--
-- Demonstrates printing index skip scan.
--

CREATE TABLE t1 (a INTEGER, b INTEGER, c INTEGER, d INTEGER, e INTEGER, KEY idx1 (a,b,c,d,e));
  SELECT /*+ SKIP_SCAN(t1) */ * FROM t1 WHERE a IN (2,4,6,8,10) AND b=5 AND e BETWEEN 100 AND 200;

DROP TABLE t1;

-- Demonstrates printing of range scans over an index on a string
-- column with a binary collation. Range values used to be printed as a
-- hex strings.

CREATE TABLE t(a VARCHAR(10) COLLATE utf8mb4_0900_bin, KEY (a));
INSERT INTO t VALUES ('abc'), ('def'), ('ghi');
SELECT * FROM t WHERE a > 'abc''def' AND a < CONCAT('z', UNHEX('090A1A5C0D'));
DROP TABLE t;

-- Demonstrates printing of DELETE with an impossible WHERE clause.

CREATE TABLE t(x INTEGER);
INSERT INTO t VALUES (1), (2), (3);

-- Demonstrates EXPLAIN ANALYZE on a DELETE statement.
--replace_regex $elide_time
EXPLAIN ANALYZE DELETE t1 FROM t t1, t t2 WHERE t1.x = t2.x + 1;
SELECT * FROM t;

DROP TABLE t;

CREATE TABLE t(x INTEGER, y INTEGER);
INSERT INTO t VALUES (1, 2), (2, 3), (3, 4);

-- Demonstrates EXPLAIN ANALYZE on an UPDATE statement.
--replace_regex $elide_time
EXPLAIN ANALYZE UPDATE t t1, t t2 SET t1.x = t2.y WHERE t1.x = t2.x;
SELECT * FROM t;

DROP TABLE t;

CREATE TABLE t1 (a INT PRIMARY KEY, b INT);
INSERT INTO t1 VALUES (1,1);

-- Only second CTE reference evaluated.
--replace_regex $elide_time
EXPLAIN ANALYZE
WITH tx AS (SELECT FLOOR(5*RAND(0)) i1 FROM t1 j1 JOIN t1 j2 ON j1.b=j2.a)
(SELECT 1 FROM t1 d1 JOIN t1 d2 ON d1.a=10*d2.a JOIN tx ON d2.b=i1) UNION
SELECT 2 FROM tx;

-- Only second CTE reference evaluated (and no 'ANALYZE').
EXPLAIN FORMAT=TREE
WITH tx AS (SELECT FLOOR(5*RAND(0)) i1 FROM t1 j1 JOIN t1 j2 ON j1.b=j2.a)
(SELECT 1 FROM t1 d1 JOIN t1 d2 ON d1.a=-d2.a JOIN tx ON d2.b=i1) UNION
SELECT 2 FROM tx;

-- Only first CTE reference evaluated.
--replace_regex $elide_time
EXPLAIN ANALYZE
WITH tx AS (SELECT FLOOR(5*RAND(0)) i1 FROM t1 j1 JOIN t1 j2 ON j1.b=j2.a)
SELECT 2 FROM tx UNION
(SELECT 1 FROM t1 d1 JOIN t1 d2 ON d1.a=-d2.a JOIN tx ON d2.b=i1);

-- Both CTE references evaluated.
--replace_regex $elide_time
EXPLAIN ANALYZE
WITH tx AS (SELECT FLOOR(5*RAND(0)) i1 FROM t1 j1 JOIN t1 j2 ON j1.b=j2.a)
SELECT 2 FROM tx UNION
(SELECT 1 FROM t1 d1 JOIN t1 d2 ON d1.a=d2.a JOIN tx ON d2.b=i1);

-- No CTE reference evaluated.
--replace_regex $elide_time
EXPLAIN ANALYZE
WITH tx AS (SELECT FLOOR(5*RAND(0)) i1 FROM t1 j1 JOIN t1 j2 ON j1.b=j2.a)
(SELECT 1 FROM t1 d1 JOIN t1 d2 ON d1.a=10*d2.a JOIN tx ON d2.b=i1) UNION
(SELECT 1 FROM t1 d1 JOIN t1 d2 ON d1.a=-d2.a JOIN tx ON d2.b=i1);

-- CTE executed in subquery only.
--replace_regex $elide_time
EXPLAIN ANALYZE
WITH x1 AS (SELECT MAX(a) AS m1 FROM t1 GROUP BY b)
SELECT * FROM x1 y1 WHERE
  y1.m1 = (SELECT MAX(m1) FROM x1) AND ABS(y1.m1) = (SELECT MIN(m1) FROM x1);
SELECT * FROM t1 y1 LEFT JOIN t1 y2 ON y1.a=-y2.a
WHERE y1.b+y2.b = (SELECT MAX(m1) FROM x1);

DROP TABLE t1;

CREATE TABLE t1(i INT, j INT);
INSERT INTO t1 VALUES (0,0),(0,1),(0,2),(1,0),(1,1),(1,2),(2,0),(2,1),(2,2);

-- Check that we get the right row count for "Aggregate using temporary table".
-- We aggregate three rows in a temporary table even if we just read two of them.
--replace_regex $elide_time
EXPLAIN ANALYZE INSERT INTO t1 SELECT 4, SUM(i) k1 FROM t1 GROUP BY j LIMIT 2;

-- Check that we get the right row count for "Materialize CTE".
-- We materialize three rows even if we just read two of them.
--replace_regex $elide_time
EXPLAIN ANALYZE WITH cte AS (SELECT SUM(i) k1 FROM t1 GROUP BY j)
SELECT * FROM cte LIMIT 2;

DROP TABLE t1;

CREATE TABLE t(
  x INT,
  y INT DEFAULT (x),
  z VARCHAR(128) DEFAULT (REPEAT('z', 128)), KEY (x));
INSERT INTO t(x) VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
INSERT INTO t SELECT * FROM t;
INSERT INTO t SELECT * FROM t;
INSERT INTO t SELECT * FROM t;
INSERT INTO t SELECT * FROM t;

DROP TABLE t;

SET optimizer_switch=default;

CREATE TABLE t1 (a INT NOT NULL, b INT NOT NULL);
SELECT * FROM t1 x1 JOIN t1 x2 ON x2.a=
(SELECT MIN(x3.a) FROM t1 x3 WHERE x1.a=x3.a);
SELECT * FROM t1 x1 LEFT JOIN t1 x2 ON x2.a<
(SELECT MIN(x3.a) FROM t1 x3 WHERE x1.a=x3.a);

DROP TABLE t1;

CREATE TABLE t1 (a INT PRIMARY KEY, b INT);

DROP TABLE t1;