CREATE TABLE t0 (
  i0 INTEGER
);

INSERT INTO t0 VALUES (0),(1),(2),(3),(4);

CREATE TABLE t1 (f1 INTEGER, f2 INTEGER, f3 INTEGER,
                 KEY(f1), KEY(f1,f2), KEY(f3));
INSERT INTO t1
SELECT i0, i0 + 10*i0,
       i0 + 10*i0 + 100*i0
FROM t0 AS a0;
INSERT INTO t1
SELECT i0, i0 + 10*i0,
       i0 + 10*i0 + 100*i0
FROM t0 AS a0;
INSERT INTO t1 VALUES (NULL, 1, 2);
INSERT INTO t1 VALUES (NULL, 1, 3);

SET optimizer_switch="derived_merge=off,derived_condition_pushdown=on";
let query = SELECT * FROM (SELECT f1, f2 FROM t1) as dt WHERE f1 > 2;

-- Test with a condition that has AND. Entire condition is pushed to
-- derived table.
let query = SELECT * FROM (SELECT f1, f2 FROM t1) as dt
            WHERE f1 < 3 and f2 > 11;

-- Same as above with three conditions in an AND
let query = SELECT * FROM (SELECT f1, f2, f3 FROM t1) as dt
            WHERE f1 > 2 and f2 < 25 and f3 > 200;

-- Same as above with three conditions with both AND and OR
let query = SELECT * FROM (SELECT f1, f2, f3 FROM t1) as dt
            WHERE f1 > 3 and f2 < 50 or f3 > 200;
let query = SELECT t1.f2 as f2, dt.f1 as f1, dt.f3 as f3 FROM t1,
            (SELECT f1, f2, f3 FROM t1) as dt
            WHERE (dt.f1 = 6) or( t1.f2 = 50 and dt.f3 = 200);

-- Test for pushing condition down partially
-- Fix test instability with join order hint
let query = SELECT /*+ JOIN_ORDER(t0, dt) */ * FROM
            (SELECT f1, f2, f3 FROM t1) as dt, t0
            WHERE f1 > 3 and f2 < 50 and i0 > 3;

-- Test with nested derived tables with simple WHERE condition
let query = SELECT * FROM (SELECT * FROM (SELECT * FROM t1) as dt1) as dt2
            WHERE f1 > 3 and f2 < 50 and f3 > 200;

-- Simple derived tables with complex WHERE conditions
let query = SELECT * FROM (SELECT f1, f2, f3 FROM t1) as dt
            WHERE (f1 > 2 and f2 < 35) and (f1+f3) > 300;

let query = SELECT * FROM (SELECT f1, f2, f3 FROM t1) as dt
            WHERE (f1 > 2 and f2 < 35) or (f1+f3) > 300 or (f1 < 2);

let query = SELECT * FROM (SELECT f1, f2 FROM t1) as dt1,
                          (SELECT f3 FROM t1) as dt2
                          WHERE (f1 > 2 and f2 < 35) and (f1+f3) > 300
                          and (f3 < 400);

-- Nested derived tables with complex WHERE conditions
let query = SELECT * FROM (SELECT * FROM (SELECT f1, f2 FROM t1) as dt1,
                                         (SELECT f3 FROM t1) as dt2) as dt3
                          WHERE (f1 > 2 and f2 < 35) and (f1+f3) > 200
                               and (f3 < 300);

-- Nested derived table with fields that have different aliases
let query = SELECT i, j, k FROM (SELECT f1 as i, f2 as j, f2 as k FROM t1) as dt
            WHERE i > 1 and i+j > 40;

let query = SELECT i, j, k
            FROM (SELECT l as i, m as j, n as k
                  FROM (SELECT f1 as l, f2 as m, f3 as n
                        FROM t1) as dt1 ) as dt2
            WHERE i > 1 and i+j > 40;

let query = SELECT i, j, l, m, n
           FROM (SELECT f1 as i, f2 as j FROM t1 ) as dt1 ,
                (SELECT f1 as l, f2 as m, f3 as n FROM t1) as dt2
           WHERE i > 1 and i+j > 40 and m < 20 and m+i > 20;
let query = SELECT * FROM
(SELECT (i+j) AS g, f1 FROM
 (SELECT (f1+f2) AS i, (f1-f2) AS j FROM
  (SELECT f1+10 AS f1, f2+10 AS f2 FROM t1) AS dt0)
 AS dt1,
 (SELECT f1, f2 FROM t1) AS dt2) AS dt3 WHERE g > 26 and g+f1 > 31;


-- Test with nested derived tables that are expressions in underlying derived
-- tables.
let query = SELECT l, m  FROM (SELECT (i+3) as l, (j+4) as m FROM
                               (SELECT (f1+f2) as i, (f3+10) as j FROM t1) as
                               dt1) as dt2 WHERE l > 20 and l+m > 10 ;

-- Test with projection list for derived tables
let query = SELECT i FROM (SELECT f1 FROM t1) as dt(i) WHERE i > 10;

let query = SELECT m FROM (SELECT k+2 as l
                           FROM (SELECT f1+f2 as j
                                 FROM t1) as dt1(k)) as dt(m)
            WHERE m > 30;

-- Test with aggregated query
let query = SELECT f1 FROM (SELECT f1, SUM(f2) FROM t1 GROUP BY f1) as dt
            WHERE f1 > 3;

let query = SELECT f1 FROM (SELECT f1, f2, SUM(f3) FROM t1 GROUP BY f1,f2) as dt
            WHERE f1+f2 > 30;

let query = SELECT f1
           FROM (SELECT f1, SUM(f2) FROM t1 GROUP BY f1 WITH ROLLUP) as dt
           WHERE f1 IS NULL;

let query = SELECT *
            FROM (SELECT f1 as j, SUM(f2) as sum
                  FROM t1 GROUP BY f1 WITH ROLLUP) as dt WHERE j+sum > 50 OR
            j IS NULL;

-- Same, with a pre-existing condition in HAVING:

let query = SELECT *
            FROM (SELECT f1 as j, SUM(f2) as sum
                  FROM t1 GROUP BY f1 WITH ROLLUP
                  HAVING AVG(f2) > 1) AS dt WHERE j+sum > 50 OR
            j IS NULL;

-- Test with ORDER BY. We should be able to push the condition
let query = SELECT f1 FROM (SELECT f1, f2 FROM t1 ORDER BY f2) as dt
            WHERE f1 > 3;

-- Test with ORDER BY AND LIMIT. Now we should not be pushing the condition
-- down as it will change the result for ORDER BY with LIMIT which changes the
-- result of the derived table and there by changing the final result set
let query = SELECT f1 FROM (SELECT f1, f2 FROM t1 ORDER BY f2 LIMIT 4) as dt
            WHERE f1 > 0 ;
let query = SELECT f1 FROM (SELECT f1, f2 FROM t1 LIMIT 4) as dt WHERE f1 > 0;

-- Test with WINDOW FUNCTIONS.
-- ONLY_FULL_GROUP_BY flags some of these query.  However if f1 was a primary
-- key these would be valid queres. So we switch off the mode, just for testing
-- purpose.

-- We cannot push past window function as we need the entire result set for
-- window function to give correct results.  So the condition will not be
-- pushed down to derived table.
set sql_mode="";
let query = SELECT * FROM (SELECT f1, SUM(f2) OVER() FROM t1 GROUP BY f1) as dt
            WHERE f1 > 2;

-- We can push past window function as we partiiton on f1. It is further pushed
-- past group by to the WHERE clause of the derived table.
let query = SELECT *
            FROM (SELECT f1, SUM(f2) OVER(PARTITION BY f1)
                  FROM t1 GROUP BY f1) as dt WHERE f1 > 2;

-- We can push past window function as we partition on f2. But cannot push past
-- group by. So pushed condition stays in the HAVING clause of the derived
let query = SELECT *
            FROM (SELECT f1, f2, SUM(f3) OVER(PARTITION BY f2)
                  FROM t1 GROUP BY f1) as dt WHERE f2 > 30;

-- We can pushdown only a part of the condition to the derived table. "f2" is
-- not part of the partition clause of window function
let query = SELECT *
            FROM (SELECT f1, f2, SUM(f3) OVER(PARTITION BY f1)
                  FROM t1 GROUP BY f1) as dt
            WHERE f1 > 2 and f2 > 30 and (f1+f2) > 40;

-- We can push past window function partially and past group by partially here.
let query = SELECT *
            FROM (SELECT f1, f2, SUM(f3) OVER(PARTITION BY f1,f2)
                  FROM t1 GROUP BY f1) as dt
            WHERE f1 > 2 and f2 > 30 and (f1+f2) > 40;

-- We can push past window function and group by for condition "f1 > 2". The
-- other two conditions will stay in HAVING clause (Testing with expressions
-- having fields from partition clause)
let query = SELECT *
            FROM (SELECT f1, f2, SUM(f3) OVER(PARTITION BY f1,f2),
                  AVG(f3) OVER (PARTITION BY f1)
                  FROM t1 GROUP BY f1) as dt
            WHERE f1 > 2 and f2 > 30 and (f1+f2) > 40;

-- Test with partition on aggregation and condition having this aggregation in
-- the condition.
let query = SELECT *
            FROM (SELECT f1, SUM(f2) as SUM, AVG(f3) OVER (PARTITION BY SUM(f2))
                  FROM t1 GROUP BY f1) as dt
            WHERE SUM > 40;
let query = SELECT *
            FROM (SELECT f1, SUM(f2) OVER (PARTITION by f1,f2),
                  AVG(f3) OVER (PARTITION BY f2,f1),
                  FIRST_VALUE(f3) OVER (PARTITION by f1)
                  FROM t1) as dt
            WHERE f1 > 2 ;

-- Test with multiple window functions with different columns in partition.
-- Should not push the condition down.
let query = SELECT *
            FROM (SELECT f1, SUM(f1) OVER (PARTITION by f2),
                  AVG(f2) OVER (PARTITION BY f1)
                  FROM t1) as dt
            WHERE f1 > 2 ;
set sql_mode=default;

-- Test with parameters for prepared statements.
-- Conditions having parameters can be pushed down.
let query = SELECT f1
            FROM (SELECT f1 FROM t1) as dt WHERE f1 > ?;
SET @p1 = 3;
DROP PREPARE p;

let query = SELECT l, m
            FROM (SELECT (i+3) as l, (j+4) as m
                  FROM (SELECT (f1+f2) AS i, (f3+?) AS j
                        FROM t1) AS dt1
                       ) AS dt2
            WHERE l > 20 and l+m > 10 ;
SET @p1 = 1;

-- Test for not supported conditions.

-- Test with non-deterministic expressions in column of derived
-- table. These cannot be pushed down.
let query = SELECT * FROM (SELECT RAND() as a FROM t1) as dt
            WHERE a > 0.5;

-- Test with non-deterministic expressions in conditions. These can be
-- pushed down, but not so early that they would modify the order of
-- operations in the computation of the derived table's content.

-- RAND goes to HAVING, <10 goes to WHERE
let query = SELECT * FROM (SELECT f1, SUM(f2) FROM t1 GROUP BY f1) as dt
            WHERE f1 > 3*RAND() AND f1 < 10;

-- RAND doesn't move, <10 goes to WHERE
let query = SELECT * FROM
            (SELECT f1, SUM(f2) OVER(PARTITION BY f1) FROM t1) as dt
            WHERE f1 > 3*RAND() AND f1 < 10;

-- RAND and <10 go to WHERE
let query = SELECT * FROM
            (SELECT f1 FROM t1) as dt
            WHERE f1 > 3*RAND() AND f1<10;

-- With WHERE condition having a subquery
let query = SELECT f1 FROM
(SELECT (SELECT 1 FROM t1 LIMIT 1) as f1 FROM t1) as dt WHERE f1 = 1;

-- With WHERE condition having a stored routine: it is pushed down more
-- if it is deterministic
DELIMITER |;
CREATE FUNCTION p() RETURNS INTEGER
BEGIN
  DECLARE retn INTEGER;
  SELECT count(f1) FROM t1 INTO retn;

let query = SELECT * FROM (SELECT f1, SUM(f2) FROM t1 GROUP BY f1) as dt
            WHERE p() = 1;
DROP FUNCTION p;
CREATE FUNCTION p() RETURNS INTEGER DETERMINISTIC
BEGIN
  DECLARE retn INTEGER;
  SELECT count(f1) FROM t1 INTO retn;
DROP FUNCTION p;
CREATE PROCEDURE p()
BEGIN
  DECLARE val INTEGER;
  SET val = 2;
  SELECT AVG(f1) FROM (SELECT * FROM t1) as dt WHERE f2 > val;
DROP PROCEDURE p;

-- Test with CTE's.  Condition pushdown to CTE's is allowed only if the
-- underlying derived tables are not referenced multiple times.

-- With this definition, we should be able to pushdown.
let query = SELECT * FROM ((WITH qn AS (SELECT 10*f1 as f1 FROM t1),
qn2 AS (SELECT 3*f1 AS f2 FROM qn)
SELECT * from qn2)) as dt WHERE f2 > 1;

-- With this definition we cannot push the condition down. Note that qn is
-- reference multiple times.
let query = SELECT * FROM ((WITH qn AS (SELECT 10*f1 as f1 FROM t1),
qn2 AS (SELECT 3*f1 AS f2 FROM qn)
SELECT * from qn,qn2)) as dt WHERE f1 < 10 and f2 > 1;


-- With derived tables part of JOINS
let query = SELECT * FROM t1 JOIN (SELECT f1, f2 FROM t1) as dt USING (f2)
            WHERE dt.f1 > 31 and t1.f2  > 40;

-- No pushdown as 'dt' is on the right side of a LEFT JOIN
let query = SELECT * FROM t1 LEFT JOIN (SELECT f1, f2 FROM t1) as dt USING (f2)
            WHERE dt.f1 is null;

-- Pushdown of WHERE happens after conversion from LEFT JOIN to INNER
-- JOIN in FROM, so it is possible here:
let query = SELECT * FROM t1 LEFT JOIN (SELECT f1, f2 FROM t1) as dt USING (f2)
            WHERE dt.f1 > 3;

let query = SELECT * FROM t1 INNER JOIN (SELECT f1, f2 FROM t1) as dt
            ON dt.f1 > 3;

-- Alas the pushed condition cannot, inside the derived table,
-- trigger a conversion to inner join, as simplify_joins() in the
-- derived table is done first.

let query = SELECT * FROM t1 INNER JOIN(SELECT t2.f1, t2.f2 FROM t1
            LEFT JOIN t1 AS t2 ON TRUE) AS dt ON dt.f1 > 3;

-- Test with both merge and derived combination
set optimizer_switch="derived_merge=on";
let query = SELECT * FROM (SELECT * FROM (SELECT f1, SUM(f2) AS sum
                                          FROM t1 GROUP BY f1) as dt1
                           WHERE f1 > 10) dt2 WHERE sum > 10;
let query = SELECT * FROM (SELECT f1, SUM(f2) AS sum
                           FROM (SELECT f1, f2 FROM t1 WHERE f1 > 10) as dt1
                           GROUP BY f1) dt2 WHERE sum > 10;

-- Test when an inner derived table is merged

--sorted_result
SELECT * FROM
 (SELECT f1 FROM (SELECT f1 FROM t1) AS dt1 GROUP BY f1) AS dt2
 WHERE f1 > 3;
SELECT * FROM
 (SELECT dt1.f1 FROM (SELECT f1 FROM t1) AS dt1, t1 AS t0
  GROUP BY dt1.f1) AS dt2
WHERE dt2.f1 > 3;

-- Test with const conditions: shouldn't be pushed down (no benefit)
let query= SELECT /*+ no_merge(dt,dt1) */ * FROM
((SELECT f1, f2 FROM t1) as dt, (SELECT f1, f2 FROM t1) as dt1) WHERE FALSE;

-- Test for optimizer hints DERIVED_CONDIITON_PUSHDOWN and
-- NO_DERIVED_CONDITION_PUSHDOWN

-- Optimizer switch condition_pushdown_to_derived is ON. But hint will override
-- the switch. So condition pushdown does not happen.
set optimizer_switch="derived_merge=off";
let query = SELECT /*+ NO_DERIVED_CONDITION_PUSHDOWN(dt2) */ * FROM
(SELECT * FROM (SELECT * FROM t1) as dt1) as dt2 WHERE f1 > 3;
let query = SELECT /*+ NO_DERIVED_CONDITION_PUSHDOWN() */ * FROM
(SELECT * FROM (SELECT * FROM t1) as dt1) as dt2 WHERE f1 > 3;
set optimizer_switch="derived_condition_pushdown=off";
let query = SELECT /*+ DERIVED_CONDITION_PUSHDOWN(dt2) */ * FROM
(SELECT /*+ NO_DERIVED_CONDITION_PUSHDOWN(dt1) */ * FROM
 (SELECT * FROM t1) as dt1) as dt2 WHERE f1 > 3;
set optimizer_switch=default;
SELECT f1 FROM (SELECT DISTINCT * FROM t1 WHERE f2 = 4) AS alias1
WHERE ( alias1 . f1 = 24 AND alias1 . f3 = 101 );
SELECT f1 FROM (SELECT DISTINCT * FROM t1 WHERE f2 = 4) AS alias1
WHERE ( alias1 . f1 BETWEEN 24 AND 30 AND alias1 . f3 BETWEEN 101 and 103);

DROP TABLE t0, t1;

CREATE TABLE t(f0 INTEGER PRIMARY KEY, f1 INTEGER,f2 INTEGER);
SELECT NULL IN(SELECT (f1 between 0 and 1)
 FROM (SELECT f1 FROM t WHERE  (@b:=NULL) - f2)as dt
);

DROP TABLE t;

-- Force optimizer to materialize the information schema table/view
set optimizer_switch="derived_merge=off";
SELECT 1 FROM information_schema.tables WHERE 12 IN (CONCAT_WS(TABLE_ROWS, ''));

set optimizer_switch="derived_merge=on";

CREATE TABLE t1(g INTEGER);

-- For the following statement, condition "w.g is null" is pushed down to the
-- derived table "w". In doing so, it should not crash because of a bad error
-- state.
SELECT w.g FROM t1 INNER JOIN (
SELECT g, ROW_NUMBER() OVER (PARTITION BY g) AS r FROM t1
) w ON w.g=t1.g AND w.r=1 WHERE w.g IS NULL;

DROP TABLE t1;

CREATE TABLE t(f1 INTEGER);

SELECT a1, a2
 FROM (SELECT MAX(f1) AS a1 FROM t) as dt1,
 (SELECT @a AS a2 FROM t) as dt2
 WHERE dt1.a1 <= dt2.a2;

DROP TABLE t;

CREATE TABLE t(f1 INTEGER);
CREATE ALGORITHM=temptable VIEW v AS SELECT f1 FROM t;
SELECT f1 FROM (SELECT f1 FROM v) AS dt1 NATURAL JOIN v dt2 WHERE f1 > 5;

DROP TABLE t;
DROP VIEW v;

CREATE TABLE t1(f1 INTEGER, KEY(f1));
CREATE TABLE t2(f1 INTEGER);
INSERT INTO t1 VALUES (1),(2),(3),(4),(5);
CREATE ALGORITHM=temptable VIEW v AS SELECT f1 FROM t1;
INSERT INTO t2 SELECT * FROM v WHERE f1=2;
UPDATE t2 SET f1=3 WHERE f1 IN (SELECT f1 FROM v WHERE f1=2);
DELETE FROM t2 WHERE f1 IN (SELECT f1 FROM v WHERE f1=3);

DROP TABLE t1;
DROP TABLE t2;
DROp VIEW v;

CREATE TABLE t1(f1 INTEGER);
INSERT INTO t1 VALUES (100),(200),(300),(400),(500);

let query = SELECT *
            FROM (SELECT f1, (@rownum_r := @rownum_r + 1) AS r FROM t1) AS dt
            WHERE dt.f1 = 300;

SET @rownum_r=0;
SET @rownum_r=0;

DROP TABLE t1;

-- Tests for WL#13730 - Condition pushdown to derived table with unions.
-- WL#349 adds INTERSECT and EXCEPT: added some tests also for those
-- set operators.

--setup tables
CREATE TABLE t0 (
  i0 INTEGER
);

INSERT INTO t0 VALUES (0),(1),(2),(3),(4);

CREATE TABLE t1 (f1 INTEGER, f2 INTEGER, f3 INTEGER,
                 KEY(f1), KEY(f1,f2), KEY(f3));
INSERT INTO t1
SELECT i0, i0 + 10*i0,
       i0 + 10*i0 + 100*i0
FROM t0 AS a0;
INSERT INTO t1
SELECT i0, i0 + 10*i0,
       i0 + 10*i0 + 100*i0
FROM t0 AS a0;
INSERT INTO t1 VALUES (NULL, 1, 2);
INSERT INTO t1 VALUES (NULL, 1, 3);

CREATE TABLE t2 LIKE t1;
INSERT INTO t2 SELECT * FROM t1;

-- Test with simple WHERE condition that needs to be pushed
let query = SELECT *
            FROM (SELECT f1, f2 FROM t1
		  UNION
		  SELECT f1, f2 FROM t2) as dt
	    WHERE f1 > 2;

-- Same, with INTERSECT
let query = SELECT *
            FROM (SELECT f1, f2 FROM t1
                  INTERSECT
                  SELECT f1, f2 FROM t2) as dt
            WHERE f1 > 2;

-- Same, with EXCEPT
let query = SELECT *
            FROM (SELECT f1, f2 FROM t1
                  EXCEPT
                  SELECT f1, f2 FROM t2) as dt
            WHERE f1 > 2;

-- Test with nested derived tables
let query = SELECT *
            FROM (SELECT * FROM (SELECT * FROM t1
                                 UNION
                                 SELECT * FROM t1) as dt1
                  UNION
                  SELECT * FROM t2) as dt2
            WHERE (f1+f2) > 22;

-- Same, with INTERSECT
let query = SELECT *
            FROM (SELECT * FROM (SELECT * FROM t1
                                 INTERSECT
                                 SELECT * FROM t1) as dt1
                  INTERSECT
                  SELECT * FROM t2) as dt2
            WHERE (f1+f2) > 22;

-- Nested derived table with fields that have different aliases
let query = SELECT i, j, k
            FROM (SELECT f1 as i, f2 as j, f3 as k FROM t1
                  UNION
                  SELECT f1 as l, f2 as m, f3 as n FROM t2) as dt
            WHERE i > 1 and i+j > 40 and k < 500;

-- With expressions in the underlying derived tables.
let query = SELECT i, j
            FROM (SELECT f1+f2 as i, f2+f3 as j FROM t1
                  UNION
                  SELECT f1 as l, f2+f3 as m FROM t2) as dt
            WHERE i > 30 and i+j > 300;

-- Same, with INTERSECT
let query = SELECT i, j
            FROM (SELECT f1+f2 as i, f2+f3 as j FROM t1
                  INTERSECT
                  SELECT f1 as l, f2+f3 as m FROM t2) as dt
            WHERE i > 30 and i+j > 300;

-- Test with projection list for derived tables
let query = SELECT i
            FROM (SELECT f1 FROM t1
                  UNION
                  SELECT f2 FROM t2) as dt(i)
            WHERE i > 10;

-- Test with aggregated query
let query = SELECT *
            FROM (SELECT f1, SUM(f2) FROM t1 GROUP BY f1
                  UNION
                  SELECT f1, f2 FROM t1) as dt
            WHERE f1 > 3;

-- Same, with a pre-existing condition in HAVING:
let query = SELECT *
            FROM (SELECT f1 as j, SUM(f2) as sum
                  FROM t1 GROUP BY f1 WITH ROLLUP
                  HAVING AVG(f2) > 1
                  UNION ALL
                  SELECT f1 as j, SUM(f2) as sum
                  FROM t1 GROUP BY f1) AS dt
            WHERE j+sum > 50 OR j IS NULL;

-- Test with ORDER BY. We should be able to push the condition
let query = SELECT f1
            FROM (SELECT f1, f2 FROM t1
                  UNION
                  SELECT f1, f2 FROM t2 ORDER BY f2) as dt
            WHERE f1 > 3;

-- Test with WINDOW FUNCTIONS.
-- We can push past window function and group by.
let query = SELECT *
            FROM (SELECT f1, f2, SUM(f2) OVER(PARTITION BY f1,f2)
                  FROM t1 GROUP BY f1, f2
                  UNION ALL
                  SELECT f1, f2, SUM(f2) OVER(PARTITION BY f1,f2)
                  FROM t2 GROUP BY f1,f2) as dt
            WHERE f1 > 2 and f2 > 30 and (f1+f2) > 40;

-- Same, with INTERSECT
let query = SELECT *
            FROM (SELECT f1, f2, SUM(f2) OVER(PARTITION BY f1,f2)
                  FROM t1 GROUP BY f1, f2
                  INTERSECT ALL
                  SELECT f1, f2, SUM(f2) OVER(PARTITION BY f1,f2)
                  FROM t2 GROUP BY f1,f2) as dt
            WHERE f1 > 2 and f2 > 30 and (f1+f2) > 40;

set sql_mode=default;

-- Test with parameters. Pushdown is allowed for conditions having
-- parameters.
let query = SELECT f1
            FROM (SELECT f1 FROM t1
                  UNION
                  SELECT f1 FROM t1) as dt WHERE f1 > ?;
SET @p1 = 3;
DROP PREPARE p;

let query = SELECT l,m
            FROM (SELECT (i+10+?) as l, (j+11+?) as m
                  FROM (SELECT (f1+f2) as i, (f3+?) as j
                        FROM t1 UNION
                        SELECT (f1+f3) as i, (f2+?) as j
                        FROM t2) as dt1
                  GROUP BY l,m) as dt2
            WHERE l > 20 and ?-m+? > 10;
SET @p1=1, @p2=2, @p3=3, @p4=4, @p5=5, @p6=6;

-- Test for not supported conditions.
-- Test with non-deterministic expressions in column of derived
-- table. These cannot be pushed down.
let query = SELECT *
            FROM (SELECT f1 as a FROM t1
                  UNION ALL
                  SELECT RAND() as a FROM t1) as dt
            WHERE a > 0.5;

-- Having non-deterministic expressions in the where condition
-- cannot be pushed down if derived table has unions (without
-- unions we do).
let query = SELECT *
            FROM (SELECT f1, SUM(f2) FROM t1 GROUP BY f1
                  UNION ALL
                  SELECT f1, f2 FROM t1) as dt
            WHERE f1 > 3*RAND() AND f1 < 10;

-- Same, with INTERSECT
let query = SELECT *
            FROM (SELECT f1, SUM(f2) FROM t1 GROUP BY f1
                  INTERSECT ALL
                  SELECT f1, f2 FROM t1) as dt
            WHERE f1 > 3*RAND() AND f1 < 10;

-- With WHERE condition having a subquery. This cannot be pushed
-- down.
let query = SELECT f1
            FROM (SELECT f1 FROM t1
                  UNION ALL
                  SELECT (SELECT 1 FROM t1 LIMIT 1) as f1 FROM t1) as dt
            WHERE f1 = 1;

-- With query expression having LIMIT. This cannot be pushed down.
let query = SELECT f1
            FROM (SELECT f1 FROM t1
                  UNION ALL
                  SELECT f1 FROM t1 LIMIT 1) as dt
            WHERE f1 = 1;
let query = SELECT f1
            FROM (SELECT f1 FROM t1
                  UNION ALL
                  (SELECT f1 FROM t1 LIMIT 1)) as dt
            WHERE f1 = 1;

-- With WHERE condition referencing a stored function: it is pushed down
-- if it is deterministic.
DELIMITER |;
CREATE FUNCTION p() RETURNS INTEGER
BEGIN
  DECLARE retn INTEGER;
  SELECT count(f1) FROM t1 INTO retn;

let query = SELECT *
            FROM (SELECT f1, SUM(f2) FROM t1 GROUP BY f1
                  UNION
                  SELECT f1, f2 FROM t1) as dt
            WHERE p() = 1;
DROP FUNCTION p;
CREATE FUNCTION p() RETURNS INTEGER DETERMINISTIC
BEGIN
  DECLARE retn INTEGER;
  SELECT 1 INTO retn;
DROP FUNCTION p;

-- Conditions having SP variables can be pushed down
DELIMITER |;
CREATE PROCEDURE p()
BEGIN
  DECLARE val INTEGER;
  SET val = 2;
                      FROM (SELECT * FROM t1
                            UNION
                            SELECT * FROM t1) as dt
                      WHERE f2 > val;
  SELECT AVG(f1)
  FROM (SELECT * FROM t1
        UNION
        SELECT * FROM t1) as dt
  WHERE f2 > val;
DROP PROCEDURE p;

-- Test with CTE's.  Condition pushdown to recursive CTE's is not allowed

let query = WITH recursive qn AS
              (SELECT 10*f1 as f1 FROM t1
               UNION
               SELECT * FROM qn) SELECT * FROM qn WHERE f1 > 1;

-- With derived tables part of JOINS
-- Should be able to pushdown dt.f1 > 31 to derived table dt
let query = SELECT *
            FROM t1 JOIN (SELECT f1, f2 FROM t1
                          UNION SELECT f1, f2 FROM t1) as dt USING (f2)
            WHERE dt.f1 > 31 and t1.f2  > 40;

-- Same, with INTERSECT
let query = SELECT *
            FROM t1 JOIN (SELECT f1, f2 FROM t1
                          EXCEPT SELECT f1, f2 FROM t1) as dt USING (f2)
            WHERE dt.f1 > 31 and t1.f2  > 40;

-- Test with both merged and materialized combination
let query = SELECT *
            FROM (SELECT *
                  FROM (SELECT f1, f2 FROM t1
                        UNION
                        SELECT f1, f2 FROM t1) as dt1
                  WHERE f1 > 10) dt2
            WHERE f2 > 30;

let query = SELECT *
            FROM (SELECT f1, f2
                  FROM (SELECT f1+f2 as f1, f2 FROM t1) as dt1
                  UNION
                  SELECT f1, f2 FROM t1) as dt2
            WHERE f1 > 30;
CREATE ALGORITHM=temptable VIEW v AS (SELECT f1,f2,f3 FROM t1
                                      UNION
                                      SELECT f1,f2,f3 FROM t1);
INSERT INTO t2 SELECT * FROM v WHERE f1=2;
UPDATE t2 SET f1=3 WHERE f1 IN (SELECT f1 FROM v WHERE f1=2);
                    SET t2.f1 = t2.f1 + v.f1
                    WHERE v.f2 > 10;
UPDATE t2 JOIN v ON t2.f2=v.f2 SET t2.f1 = t2.f1 + v.f1 WHERE v.f2 > 10;
DELETE FROM t2 WHERE f1 IN (SELECT f1 FROM v WHERE f1=3);
DELETE t2 FROM t2 JOIN v ON t2.f2=v.f2 WHERE v.f2 > 10;

DROP VIEW v;
DROP TABLE t0;
DROP TABLE t1;
DROP TABLE t2;

-- Code coverage
-- Test the need for considering hidden fields added (while setting up
-- temporary table for a materialized derived table) to correectly get
-- the position of a derived table expression in its query block.

CREATE TABLE t1(f1 VARBINARY(10000));

SELECT * FROM (SELECT f1 FROM t1 UNION SELECT f1 FROM t1) as dt WHERE f1 > '10';

DROP TABLE t1;

CREATE TABLE t1(f1 INTEGER, f2 INTEGER);
CREATE VIEW v1 AS SELECT * FROM t1 UNION SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM v1;

-- The following query should not error out while resolving the
-- field "v2.f2" during condition pushdown.
-- The natural join changes the context for the fields to point
-- to the tables in the join list. During simplification of joins,
-- the join list starts pointing to the underlying tables of the view
-- v2 since this view was merged. This made the resolving of field
-- v2.f2 error out since it tried to find the field in view v1.
-- We now use the expression in the underlying table of a merged view
-- for cloning during condition pushdown.
SELECT t1.f1 FROM t1 JOIN v2 USING(f2) WHERE v2.f2 = 1;

DROP TABLE t1;
DROP VIEW v1;
DROP VIEW v2;

-- Original query from bugpage
SELECT a.table_name, d.table_name
FROM information_schema.key_column_usage a
     JOIN information_schema.table_constraints b
     USING (table_schema , table_name , constraint_name)
     JOIN information_schema.referential_constraints c
     ON (c.constraint_name = b.constraint_name AND
         c.table_name = b.table_name AND
         c.constraint_schema = b.table_schema)
     LEFT JOIN information_schema.table_constraints d
     ON (a.referenced_table_schema = d.table_schema AND
         a.referenced_table_name = d.table_name AND
         d.constraint_type IN ('UNIQUE' , 'PRIMARY KEY'))
WHERE b.constraint_type = 'FOREIGN KEY'
ORDER BY a.table_name , a.ordinal_position;

-- Simplified query
SELECT a.table_name
FROM information_schema.key_column_usage a
     JOIN information_schema.table_constraints b
     USING (table_schema)
WHERE b.constraint_type = 'FOREIGN KEY';

CREATE TABLE t1 (f1 INTEGER);

SET @a = 0;
SELECT COUNT(*) FROM (SELECT SUM(f1) FROM t1) as dt WHERE @a = 1;

DROP TABLE t1;

CREATE TABLE t1 (f1 INTEGER UNSIGNED);
let $query = SELECT *
             FROM (SELECT NOW() AS time FROM t1 WHERE f1 = ?
                   UNION
                   SELECT NOW() AS time FROM t1 WHERE f1 = 0) AS dt
             WHERE time <= ?;
SET @a = 1;
SET @b = '2022-05-06 16:49:45';
SET @a = 2;
SET @b = '2023-05-06 16:49:45';
SET timestamp=UNIX_TIMESTAMP('2023-05-06 16:49:45');
SET timestamp=default;

DROP TABLE t1;

CREATE TABLE t1 (f1 INTEGER);
INSERT INTO t1 VALUES (1);
SELECT * FROM (SELECT f1 FROM t1 UNION SELECT f1 FROM t1) AS dt WHERE f1 <> 0.5;
DROP TABLE t1;

-- We should not see "Access denied" error when the where condition
-- is pushed down to views referencing a system view.

CREATE ALGORITHM=TEMPTABLE VIEW v1 AS
 SELECT VIEW_DEFINITION FROM INFORMATION_SCHEMA.VIEWS;
SELECT * FROM v1 WHERE VIEW_DEFINITION LIKE 'x';

CREATE ALGORITHM=TEMPTABLE VIEW v2 AS SELECT * FROM v1;
SELECT * FROM v2 WHERE VIEW_DEFINITION LIKE 'x';

CREATE ALGORITHM=TEMPTABLE VIEW v3 AS
 SELECT * FROM (SELECT * FROM v1 UNION SELECT * FROM v2) AS dt;
SELECT * FROM v3 WHERE VIEW_DEFINITION LIKE 'x';

DROP VIEW v1, v2, v3;

CREATE TABLE t1 (
  str VARCHAR(200) CHARACTER SET utf16 COLLATE utf16_unicode_ci
) ENGINE=InnoDB DEFAULT CHARACTER SET ascii COLLATE ascii_general_ci;

CREATE TABLE t2 (
  str VARCHAR(200) CHARACTER SET utf16 COLLATE utf16_unicode_ci
) ENGINE=InnoDB DEFAULT CHARACTER SET ascii COLLATE ascii_general_ci;

INSERT INTO t1 VALUES (_utf8mb4'Patch');

let $query =
SELECT dt.str
FROM (SELECT t2.str
      FROM t2
      WHERE t2.str LIKE _latin1'Patc%' ESCAPE _latin1'\\\\'
      UNION ALL
      SELECT t1.str
      FROM t1
      WHERE t1.str LIKE _latin1'Patc%' ESCAPE _latin1'\\\\'
     ) AS dt
WHERE dt.str LIKE _latin1'P%' ESCAPE _latin1'\\\\';

DROP TABLE t1, t2;

CREATE TABLE t1 (f1 INTEGER, f2 INTEGER);
INSERT INTO t1 VALUES (NULL, NULL);

SELECT 1
FROM (SELECT 1
      FROM t1 LEFT JOIN (SELECT 1 AS f1 FROM t1) AS dt1
      ON dt1.f1 = t1.f2
      WHERE dt1.f1 IS NOT NULL) AS dt2,
     (SELECT 1 FROM t1 UNION ALL SELECT 2 FROM t1) AS dt3;

DROP TABLE t1;

CREATE TABLE t1 (f1 TINYINT);

SELECT f1 FROM (SELECT f1 FROM t1 UNION SELECT f1 FROM t1 ) AS dt
WHERE f1 > -32768 OR f1 = 1;

DROP TABLE t1;

SELECT * FROM (SELECT 'å' AS x) AS dt WHERE x = 'å';

CREATE TABLE t1 (f1 VARCHAR(10));
INSERT INTO t1 VALUES('å');

SELECT * FROM (SELECT f1 FROM t1 UNION SELECT f1 FROM t1) AS dt WHERE f1 = 'å';

DROP TABLE t1;

CREATE TABLE t1 (f1 INTEGER);
SELECT f1
FROM t1 JOIN
     LATERAL (SELECT (t1.f1 + t2.f1) AS f2
              FROM t1 AS t2
              GROUP BY f2) AS dt
WHERE f2 = 9;

DROP TABLE t1;

CREATE TABLE t1 (f1 INTEGER, f2 INTEGER);
INSERT INTO t1 VALUES(1,2);
INSERT INTO t1 VALUES (2,2);

SELECT f1, f2 FROM (SELECT f1, f2 FROM t1 GROUP BY f1, f2 WITH ROLLUP) as dt
WHERE f2 IS NULL;

DROP TABLE t1;

CREATE TABLE t1(f1 INTEGER);
INSERT INTO t1 VALUES (NULL);
CREATE TABLE t2(f1 INTEGER);

SELECT dt3.f1
FROM t1 JOIN (SELECT f1
              FROM (SELECT dt1.f1
                    FROM t1
                         LEFT JOIN (SELECT 1 AS f1
                                    FROM t2) AS dt1
                         ON TRUE) AS dt2
              GROUP BY f1) AS dt3
WHERE dt3.f1 IS NOT NULL;

DROP TABLE t1,t2;

CREATE TABLE t1 (f1 INTEGER, f2 VARCHAR(30) COLLATE utf8mb4_bin NOT NULL);
INSERT INTO t1(f2) VALUES ('680519363848');

-- Query from the bug report
let query =
SELECT *
FROM (SELECT IF(f2 = ?, ?, CASE WHEN f2 IS NULL THEN ? ELSE ? END) AS case_f
      FROM t1
      UNION ALL
      SELECT IF(f2 = ?, ?, CASE WHEN f2 IS NULL THEN ? ELSE ? END) AS case_f
      FROM t1) AS dt1
WHERE case_f = ?;

SET @a1 = 'Y';
SET @a2 = 'Y';
SET @a3 = 'N';
SET @a4 = 'Y';
SET @a5 = 'Y';
SET @a6 = 'Y';
SET @a7 = 'N';
SET @a8 = 'Y';
SET @a9 = 'Y';

-- Simplified query
SET optimizer_switch="derived_merge=off";
let query =
SELECT * FROM (SELECT ? AS case_f FROM t1) as dt1 WHERE case_f = 'Y';
SET @a1 = 'Y';

SET optimizer_switch=default;

DROP TABLE t1;
     (SELECT ?) SELECT 1 FROM t2 WHERE t2.f1)
   SELECT 1 FROM t1 JOIN t1 AS t3';

SET @a = 1;
     (SELECT ?+?) SELECT 1 FROM t2 WHERE t2.f1)
   SELECT 1 FROM t1 JOIN t1 AS t3';

SET @a = 1;
SET @b = 2;
