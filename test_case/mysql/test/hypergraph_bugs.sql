
-- This should have been a unit test. But unit tests do not have framework
-- for prepared statements yet. So we are adding this.

--echo --
--echo -- Bug#34402003: HYPERGRAPH BUG: Offload issue with execute statement.
--echo --

CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT);
CREATE TABLE t3(a INT);
INSERT INTO t1 VALUES (1),(2),(5);
INSERT INTO t2 VALUES (2);
INSERT INTO t3 VALUES (3);
SET optimizer_trace='enabled=on';
let $query = SELECT * FROM t1 LEFT JOIN t2 ON t1.a=t2.a JOIN t3 ON t1.a=5;
SELECT
IF(TRACE LIKE '%Left join [companion set %] (extra join condition = (t1.a = 5) AND (t2.a = 5))%',
   'OK', TRACE)
FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE;
SET optimizer_trace="enabled=off";
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

-- This should have been a unit test. But unit tests do not have framework
-- for type "year" yet.
-- We are basically testing that "f1" in the non-equality predicate gets
-- substituted with value "1" propagated from "f1 = 1" predicate which
-- will make the condition to be always true.

--echo --
--echo -- Bug#34080394: Hypergraph Offload issue : Problem in
--echo --               ExtractRequiredItemsForFilter.
--echo --

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
                                      SELECT 1 FROM t1 STRAIGHT_JOIN qn)
                                     SELECT * FROM qn) AS dt1,
                                     (SELECT COUNT(*) FROM t1) AS dt2";
DROP TABLE t1;

CREATE TABLE t(x INT, y INT);
INSERT INTO t VALUES (1, 10), (2, 20), (3, 30);

-- Expect the entire query to be optimized away. It used to produce a
-- join between t and a temporary table containing the result of a
-- "Zero rows" plan.
let $query =
SELECT * FROM
  t RIGHT JOIN
  (SELECT MAX(y) AS m FROM t WHERE FALSE GROUP BY x) AS dt
  ON t.x = dt.m;

-- Similar to the above, but the query cannot be entirely optimized
-- away, since the outer table isn't empty. It used to add a
-- materialization step on top of the zero rows plan for the derived
-- table. Now it should just have zero rows directly on the inner side
-- of the join.
let $query =
SELECT * FROM
  t LEFT JOIN
  (SELECT MAX(y) AS m FROM t WHERE FALSE GROUP BY x) AS dt
  ON t.x = dt.m;

-- Similar case, where the query cannot be entirely optimized away.
-- Verify that the entire inner side of the outer join is optimized
-- away. Only t1 should be accessed.
let $query =
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

-- Neither index nor histogram, so use 10% selectivity estimate.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1,t2 WHERE a=b;

-- Estimate selectivity from ix1.

--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1,t2 WHERE ai=b;

-- Estimate selectivity from ix1 or ix2.

--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1,t2 WHERE ai=bi;

-- Estimate selectivity from ix2.

--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1,t2 WHERE a=bi;

-- Estimate selectivity from histogram on 'a'.

--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1,t2 WHERE ah=b;

-- Estimate selectivity from histogram on 'a' or 'b'.

--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1,t2 WHERE ah=bh;

-- Estimate selectivity from histogram on 'b'.

--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1,t2 WHERE a=bh;

DROP TABLE num, t1, t2;

CREATE TABLE t1 (f1 INTEGER, f2 INTEGER);
let $query =
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

let $query =
WITH subq AS (
  SELECT * FROM t2
  WHERE x IN (SELECT t1.pk FROM t1, t2 AS t3 WHERE t1.x = t3.x)
)
SELECT 1 FROM subq LEFT JOIN t2 AS t4 ON TRUE WHERE subq.x = t4.x;

DROP TABLE t1,t2;

CREATE TABLE t1 (f1 INTEGER, f2 INTEGER);

let $query =
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

-- Graph simplification used to hit an assertion as a result of
-- division by zero caused by information schema tables with zero row
-- estimates.
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

-- Graph simplification used to hit an assertion as a result of
-- division by zero caused by zero row estimates from MyISAM. (InnoDB
-- never gives zero row estimates, not even for empty tables, whereas
-- MyISAM does.)
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

-- The row estimate for "x1 LEFT JOIN (x2 LEFT JOIN x3)" may be different from that of
--  "(x1 LEFT JOIN x2) LEFT JOIN x3" (see bug #33550360 "Inconsistent row estimates
-- in the hypergraph optimizer"). Then the the row estimate for GROUP BY will also depend
-- on the join order. This triggers the assert (i.e. bug#34861693).
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT x1.a+0 k, COUNT(x1.b) FROM t1 x1
  LEFT JOIN t2 x2 ON x1.b=x2.a
  LEFT JOIN t1 x3 ON x2.b=x3.a GROUP BY k;

DROP TABLE t1,t2,num;

CREATE TABLE num10 (n INT);
INSERT INTO num10 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

CREATE TABLE t1(a INT, b INT, c INT);

INSERT INTO t1 SELECT NULL, x1.n+x2.n*10, NULL FROM num10 x1, num10 x2;
INSERT INTO t1 VALUES (NULL, 0, 0);

-- Row estimate should not be zero, even if histogram was built on empty table.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT b FROM t1 GROUP BY b;

-- Row estimate should not be zero, even if histogram was built on empty table.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT b FROM t1 WHERE b=c;

-- Prior to the fix, this would trigger the assert, as we would estimate
-- zero distinct values for 'a'.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT a,b FROM t1 GROUP BY a,b;

-- Now there is an updated histogram (built on a non-empty table),
-- and thus a better estimate.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT b FROM t1 WHERE b=c;

-- Estimate should be two rows (NULL and 0).
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT c FROM t1 GROUP BY c;

DROP TABLE num10, t1;

CREATE TABLE t2(a INT, b INT);

INSERT INTO t2 VALUES (0, 0), (0, 1), (1, 2), (NULL, 3), (NULL, 4), (NULL, 5);

-- Estimate should be 1.5 rows (i.e. 25% of the table), as there are two distinct
-- values, and 'a' is NULL for 50% of the rows.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t2 WHERE a=b;

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

-- Since [a,b] is a prefix of the primary key, we use the selectivity of this prefix instead
-- of multiplying individual sekectivities of each field.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 x1, t1 x2 WHERE x1.a=x2.a AND x1.b=x2.b;

-- [a,b,c] is also a prefix of the primary key.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 x1, t1 x2, t1 x3
  WHERE x1.a=x2.a AND x1.b=x2.b AND x2.c=x3.c AND x2.d=x3.d;

-- Prefix of k1.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 x1, t1 x2 WHERE x1.e=x2.e AND x1.f=x2.f;

-- Prefix of k1.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 x1, t1 x2 WHERE x1.e=x2.e AND x1.f=x2.f AND x1.g=x2.g;

-- 'a' and 'e' are prefixes of two separate keys, so we multiply the selectivity of each.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 x1, t1 x2 WHERE x1.a=x2.a AND x1.e=x2.e;

-- [a,b] and [e,f] are index prefixes. Multiply the selectivity of each prefix.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 x1, t1 x2 WHERE x1.a=x2.a AND x1.b=x2.b
   AND x1.e=x2.e AND x1.f=x2.f;

-- [x2.a, x2.b] form an index prefix, but they are joined with different tables
-- (x1 and x3). Therefore we derive the selectivity for x2.a from the
-- primary key, and the selectivty of x2.b from the histogram for that field.
-- And then we multiply these selectivities.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 x1, t1 x2, t1 x3 WHERE x1.a=x2.a AND x2.b=x3.b;

-- Mix of field=field and field=constant
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 x1, t1 x2 WHERE x1.a=x2.a AND x1.b=8;
   AND x1.c=8;
   AND x1.c=8;

-- Join on entire primary key.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 x1, t1 x2 WHERE x1.a=x2.a AND x1.b=x2.b
   AND x1.c=x2.c;

-- field=field on single table.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 WHERE a=b;

-- Cycle x1->x2->x3 in predicate.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE FORMAT=TREE SELECT * FROM t1 x1, t1 x2, t1 x3
  WHERE x1.a=x2.a AND x2.b=x3.b AND x3.c=x1.c;

-- Cap on most selective unique key (k2).
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 JOIN num10 ON h=n;

-- Cap on unique key k2 takes priority over [t1.a,t1.b] index prefix.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 x1, t1 x2, t1 x3 WHERE
  x1.a=x2.a AND x1.b=x2.b AND x1.b=x3.h;

-- x3.a is missing on the inner side of the left join. Therefore we use
-- histograms rather than the [x3.a, x3.b] index prefix for finding the
-- selectivity of x3.b=x1.d.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 x1 LEFT JOIN
  (t1 x2 JOIN t1 x3 ON x2.a=x3.a AND x2.b=x3.b) ON x3.b=x1.d;

-- Implicit cast from VARCHAR to INT.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 x1 JOIN t1 x2 ON x1.a=x2.v AND x1.b=x2.b;

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

-- 'c<70' is cheaper even if it is less selective, so evaluate that first.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT 1 FROM t1 x1 WHERE x1.c IN
(SELECT c FROM t1 x2 WHERE  b<"150" AND c<70);

-- Even if 'c<80' is cheaper, its selectivity is so low that it should be
-- evaluated last.
--replace_regex $elide_costs
EXPLAIN  FORMAT=TREE SELECT 1 FROM t1 WHERE b<"150" AND c<80;
CREATE FUNCTION foo(i INT)
  RETURNS INT
  LANGUAGE SQL
BEGIN
  RETURN i+1;
END $$
DELIMITER ;

-- Function call should be evaluated last.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT 1 FROM t1 WHERE foo(2)=3 AND c=5;

DROP FUNCTION foo;
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

-- We estimate selectivity of <field>=<independent expression> as
-- 1/<num distinct values of field>. If there is a histogram on <field>,
-- or if it is the first field of an (non-hash) index, then the (estimated)
-- number of distinct values is directly available. If it is the second or
-- subsequent field of an index, we do not know to what extent <field> is
-- correlated with the preceeding fields. In this case, we estimate the
-- selectivity as the geometric mean of the two extermes:
-- 1) Uncorrelated:
--    selectivity = records_per_key(prefix+key) / rows_in_table
--
-- 2) prefix is functionally dependent on field:
--    selectivity = records_per_key(prefix+key) / records_per_key(prefix)

-- Make estimate from index, even if value is unknown.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE b=FLOOR(RAND(0));

-- Make estimate from histogram, even if value is unknown.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE c=FLOOR(RAND(0));

-- Make estimate from histogram, even if value is unknown. Note that the field
-- is on the right hand side of '='.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE FLOOR(RAND(0))=c;

-- Make estimate from second field of index. Since 'b' and 'd' are independent,
-- the estimate will be too low.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE d=FLOOR(RAND(0));

-- Make estimate from second field of index. Since 'b' in functionally dependent
-- on 'e', the estimate will be too high.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE e=FLOOR(RAND(0));

-- Make estimate from second field of index. Since 'b' and 'd' are independent,
-- the estimate will be too low.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE d=0;

-- Make estimate from second field of index. Since 'b' in functionally dependent
-- on 'e', the estimate will be too high.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE e=0;

-- Make estimate from second field of indexes k3 and k4.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE g=FLOOR(RAND(0));

-- Make estimate from index, even if value is unknown.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE b=(SELECT MIN(b) FROM t1);

-- Make estimate from histogram, even if value is unknown.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE c=(SELECT MIN(b) FROM t1);

-- Use histogram or index to make estimate for <field>!=<expression>
-- predicates.

-- Make estimate from index, even if value is unknown.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE b<>FLOOR(RAND(0));

-- Make estimate from histogram, even if value is unknown.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE c<>FLOOR(RAND(0));

-- Make estimate from histogram, even if value is unknown. Note that the field
-- is on the right hand side of '<>'.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE FLOOR(RAND(0))<>c;

-- Make estimate from index, even if value is unknown.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE b<>(SELECT MIN(b) FROM t1);

-- Make estimate from histogram, even if value is unknown.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE c<>(SELECT MIN(b) FROM t1);

-- Make estimate from second field of index.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE d<>(SELECT MIN(b) FROM t1);

-- Make estimate from second field of index.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT 1 FROM t1 WHERE e<>(SELECT MIN(b) FROM t1);

-- Subquery with column resolved in outer reference (OUTER_REF_TABLE_BIT).
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE FORMAT=TREE SELECT * FROM t1 x1 WHERE d =
(SELECT MIN(g) FROM t1 x2 WHERE x1.b<>x2.b);

DROP TABLE t1;

CREATE TABLE t1 (
  a INT PRIMARY KEY,
  b INT,
  c INT,
  d INT,
  e INT,
  KEY k1 (b,c)
);

-- To reproduce this bug we use a query with:
-- - A top-level semi-join, so that we get one CompanionSet for the
--   root and one for the inner-join.
-- - A cyclic dependency between x2, x3 and x4.
-- - Terms comparing both the first and second field in a key to
--   other fields.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT 1 FROM t1 x1 WHERE EXISTS
(SELECT 1 FROM t1 x2, t1 x3, t1 x4
  WHERE x2.b=x3.d AND x2.c=x3.e AND x3.d=x4.b AND x2.e=x4.e);

DROP TABLE t1;

-- Test case for post-push fix for commit with
-- 'Change-Id: I40156663f32a407490b066a566abe72b356cfda9'. Fix for UBSAN
-- error: building reference to dereferenced null pointer.
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

-- To trigger this bug we need a query with:
-- - A ROWID_UNION access path.
-- - A predicate giving a selectivity estmate of zero (prior to the fix).
-- - An expensive filter condition.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 x0 WHERE (b=3 OR c=4) AND a <>
(SELECT MAX(x1.a+x2.a) FROM t2 x1 JOIN t2 x2 ON x1.b<x2.b);

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

-- The assert was triggered by an independent singlerow subselect as a filter
-- condition.

--replace_regex $elide_costs_and_rows
EXPLAIN FORMAT=TREE SELECT b FROM t1 x1
  WHERE c < 1 AND c = (SELECT MAX(b) FROM t1 x2);

DROP TABLE t1;

CREATE TABLE t1 (a INT, b INT, KEY k1 (a));

INSERT INTO t1 VALUES (1,1),(2,2),(1,1),(2,2),(1,1),(2,2),(1,1),(2,2),(1,1),(2,2),(1,1),(2,2);

-- The code that made row estimates for aggregation did not understand that
-- 'a' was a field, since it was represented by an Item_ref rather than an
-- Item_field. Therefore, it ignored the k1 index, and used a rule of thumb
-- instead (the square root of the number of input rows).
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT a, COUNT(*) FROM
  (SELECT x1.a FROM t1 x1, t1 x2 WHERE x1.b = x2.a) AS dt GROUP BY a;

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

-- c=NULL is always false and should not affect the row estimate.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE b=5 OR c=NULL;

-- 'c<=>NULL' and 'c IS NULL' are equivalent and should get the same row
-- estimate.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE b=5 OR c<=>NULL;

-- b=NULL is always false and should not affect the row estimate.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE b=NULL OR c=5;

-- b<=>NULL is always false and should not affect the row estimate.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE b<=>NULL OR c=5;

-- Use index for selectivity estimate.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE b<=>FLOOR(RAND(0));

-- Use index for selectivity estimate.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE c<=>FLOOR(RAND(0));

-- c=NULL is always false and should not affect the row estimate.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE b=5 OR c=NULL;

-- 'c<=>NULL' and 'c IS NULL' are equivalent and should get the same row
-- estimate (from the histogram).
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE b=5 OR c<=>NULL;

-- b=NULL is always false and should not affect the row estimate.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE b=NULL OR c=5;

-- b<=>NULL is always false and should not affect the row estimate.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE b<=>NULL OR c=5;

-- Use index for selectivity estimate.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE b<=>FLOOR(RAND(0));

-- Use index for selectivity estimate.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE c<=>FLOOR(RAND(0));

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

-- Simple semijoin. The row estimate should be:
-- CARD(t1) * CARD("SELECT DISTINCT l FROM t2") * SELECTIVITY(t1.a=t2.l)
-- = 30 * 10 * 1/30 = 10.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 WHERE t1.a IN (SELECT t2.l FROM t2);

-- Semijoin that is not an equijoin.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 WHERE EXISTS
(SELECT 1 FROM t2 WHERE t1.a=t2.l AND t1.b<>t2.k);

-- Semijoin refering same inner field ('l') multiple times.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 WHERE EXISTS
(SELECT 1 FROM t2 WHERE t2.l+ABS(t2.l)=t1.a);

-- Semijoin refering multiple inner fields.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 WHERE EXISTS
(SELECT 1 FROM t2 WHERE t2.k+t2.l=t1.a);

-- Simple antijoin.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 WHERE NOT EXISTS
(SELECT 1 FROM t2 WHERE t1.a=t2.l);

-- Antijoin that is not an equijoin.
--replace_regex $elide_costs_and_time
EXPLAIN ANALYZE SELECT * FROM t1 WHERE NOT EXISTS
(SELECT 1 FROM t2 WHERE t1.a=t2.l AND t1.b<>t2.k);

-- Semijoin with row estimate from inner operand less than one.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE a IN
(SELECT t2.l FROM t2 WHERE t2.l<0);

-- Semijoin with constant inner operand.
--replace_regex $elide_costs
EXPLAIN FORMAT=TREE SELECT * FROM t1 WHERE t1.a IN (SELECT 5 FROM t2);

DROP TABLE t1,t2;

CREATE TABLE t(x INT, y INT);
INSERT INTO t VALUES (1, 2), (2, 3);

SET optimizer_switch='hypergraph_optimizer=off';

SET optimizer_switch='hypergraph_optimizer=on';

SET optimizer_switch='hypergraph_optimizer=off';

SET optimizer_switch='hypergraph_optimizer=on';

SET optimizer_switch='hypergraph_optimizer=off';

DROP TABLE t;

CREATE TABLE t(x VARCHAR(100), FULLTEXT KEY (x));
INSERT INTO t VALUES ('abc'), ('xyz'), ('abc abc');

SET optimizer_switch='hypergraph_optimizer=on';

SET optimizer_switch='hypergraph_optimizer=off';

SET optimizer_switch='hypergraph_optimizer=on';

SET optimizer_switch='hypergraph_optimizer=off';

SET optimizer_switch='hypergraph_optimizer=on';

DROP TABLE t;

SET optimizer_switch='hypergraph_optimizer=default';