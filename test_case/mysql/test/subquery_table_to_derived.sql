
SET OPTIMIZER_SWITCH="subquery_to_derived=on";

CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES(1,10),(2,20),(3,30);

CREATE TABLE t2 (a INT, b INT);
INSERT INTO t2 VALUES(1,10),(2,20),(3,30),(1,110),(2,120),(3,130);

-- IN

let $query=
SELECT * FROM t1 ot
WHERE ot.b<0 OR ot.a IN (SELECT it.a+1 FROM t2 it);

-- Test optimizer_switch

SET OPTIMIZER_SWITCH="subquery_to_derived=off";
SET OPTIMIZER_SWITCH="subquery_to_derived=on";

-- IN with two identically-named expressions in SELECT list:
-- the renaming of expressions is meant to disambiguate
-- them when moved to the derived table, which is necessary to:
-- - have a working table
-- - have correct LEFT JOIN equalities.
-- We also have two identical expressions in SELECT list and
-- WHERE.

let $query=
SELECT * FROM t1 ot
WHERE ot.b<0 OR (ot.a,ot.a+1,ot.a+2)
 IN (SELECT it.a+1 AS myname,it.a+2 AS myname,it.a+3 FROM t2 it
     WHERE it.a+3=ot.a+2);

-- Decorrelated EXISTS(SELECT *)

let $query=
SELECT * FROM t1 ot
WHERE ot.b<0 OR EXISTS(SELECT * FROM t2 it WHERE ot.a=it.a+1);

-- Decorrelated EXISTS(SELECT columns)

-- Substituting the selected expressions with constants matters for not
-- emitting duplicates

let $query=
SELECT * FROM t1 ot
WHERE ot.b<0 OR EXISTS(SELECT it.b FROM t2 it WHERE ot.a=it.a+1);

-- And also for removing superfluous correlation of the SELECT list

let $query=
SELECT * FROM t1 ot
WHERE ot.b<0 OR EXISTS(SELECT it.b,ot.b FROM t2 it WHERE ot.a=it.a+1);

-- If using a view, PS makes it more tricky: when 2nd resolution starts, the "1"
-- which was put in the SELECT list of EXISTS, is overwritten by
-- rollback_item_tree_changes();
CREATE view v2 AS SELECT * FROM t2;

-- IN deep inside AND/ORs

let $query=
SELECT * FROM t1 ot
WHERE ot.b<0 OR (ot.b<0 AND (ot.b<0 OR ot.a IN (SELECT it.a+1 FROM t2 it)));

-- For code coverage: when we decorrelate, and the subquery contains a
-- derived table:

let $query=
SELECT * FROM t1 ot
WHERE ot.b<0 OR ot.a IN (SELECT it.a+1 FROM (SELECT * FROM t2 LIMIT 1) it
                         WHERE it.a+3=ot.a+1);

-- Single-table UPDATE: we can transform the subquery to derived, by first
-- converting to multi-table UPDATE.

BEGIN;

let $query=
UPDATE t1 ot SET a=a*100
WHERE ot.b<0 OR ot.a IN (SELECT it.a+1 FROM t2 it);

SELECT * FROM t1;

-- Undo the above
ROLLBACK;

-- Multi-table UPDATE

BEGIN;

let $query=
UPDATE t1 ot, (SELECT 1) AS dummy
SET a=a*100
WHERE ot.b<0 OR ot.a IN (SELECT it.a+1 FROM t2 it);

SELECT * FROM t1;

-- Single-table DELETE

BEGIN;

let $query=
DELETE FROM t1 ot
WHERE ot.b<0 OR ot.a IN (SELECT it.a+1 FROM t2 it);

SELECT * FROM t1;

-- Multi-table DELETE

BEGIN;
let $query=
DELETE ot.* FROM t1 ot, (SELECT 1) AS dummy
WHERE ot.b<0 OR ot.a IN (SELECT it.a+1 FROM t2 it);

SELECT * FROM t1;

-- Same, in a SP

CREATE PROCEDURE del()
DELETE ot.* FROM t1 ot, (SELECT 1) AS dummy
WHERE ot.b<0 OR ot.a IN (SELECT it.a+1 FROM t2 it);

SELECT * FROM t1;
SELECT * FROM t1;
SELECT * FROM t1;

SELECT * FROM t1;
DROP PROCEDURE del;

DROP TABLE t1,t2;
DROP view v2;

CREATE TABLE t1 (col_varchar_key VARCHAR(1));
CREATE TABLE t2
SELECT 1 FROM t1 WHERE
col_varchar_key IN (SELECT  1 FROM t1
                    WHERE ('f', 'f') IN (SELECT 1, COUNT(1) FROM t1));
DROP TABLE t1;

CREATE TABLE t1 (
  field2 VARCHAR(2),
  field3 BIGINT
);

CREATE TABLE t2 (
  col_int INT,
  pk INT
);

SELECT 1 FROM t1
WHERE (field2 ,field3) IN
(
 SELECT STRAIGHT_JOIN
        1 AS field2 ,
        ( SELECT 1 AS SQ1_field1 FROM t2 AS SQ1_alias1
          WHERE SQ1_alias1.col_int != alias1.pk) AS field3
 FROM t2 AS alias1 GROUP BY field2,field3
);

DROP TABLE t2,t1;

-- we must block semijoin to test the conversion to derived table
SET OPTIMIZER_SWITCH="semijoin=off";

CREATE TABLE t1(a INT);
CREATE TABLE t2(b INT);
INSERT INTO t1 VALUES(1);
INSERT INTO t2 VALUES(2),(3);
let $query=
SELECT * FROM t1
  WHERE NOT EXISTS(SELECT * FROM t2 WHERE t1.a<>t2.b);
let $query=
SELECT * FROM t1
  WHERE NOT EXISTS(SELECT * FROM t2 WHERE t1.a<>t2.b) OR t1.a>0;
let $query=
SELECT * FROM t1
    WHERE NOT EXISTS(SELECT * FROM t2 WHERE t1.a<>t2.b) AND t1.a>0;
SELECT * FROM t1
    WHERE EXISTS(SELECT * FROM t2 WHERE t1.a<>t2.b) AND t1.a>0;
SELECT * FROM t1
    WHERE NOT EXISTS(SELECT * FROM t2 WHERE t1.a>=t2.b) AND t1.a>0;
SELECT * FROM t1
    WHERE NOT EXISTS(SELECT * FROM t2 WHERE t1.a>t2.b) AND t1.a>0;
SELECT * FROM t1
    WHERE NOT EXISTS(SELECT * FROM t2 WHERE t1.a<=t2.b) AND t1.a>0;
SELECT * FROM t1
    WHERE NOT EXISTS(SELECT * FROM t2 WHERE t1.a<t2.b) AND t1.a>0;
SELECT * FROM t1
    WHERE NOT EXISTS(SELECT * FROM t2 WHERE t2.b<t1.a) AND t1.a>0;

DROP TABLE t1,t2;
SET OPTIMIZER_SWITCH="semijoin=on";

CREATE TABLE t1 ( pk INTEGER );
CREATE TABLE t2 ( a INTEGER );
CREATE TABLE t3 ( b INTEGER );

-- subquery_to_derived adds a DISTINCT to this query,
-- which the hypergraph optimizer can't handle yet.
-- It should error out and be properly skipped, instead of
-- being treated as false and then crashing on re-optimize.
SELECT *
  FROM t1 LEFT JOIN t2 ON 2 IN (
    SELECT COUNT(*) FROM t1
    WHERE NOT EXISTS ( SELECT b FROM t3 )
    GROUP BY pk
  );

DROP TABLE t1, t2, t3;
CREATE TABLE t1 (c0 INT);
INSERT INTO t1 VALUES (1), (2);

SELECT 1 FROM t1 WHERE NOT EXISTS (VALUES ROW(1),ROW(2));
SELECT c0 FROM t1 WHERE NOT EXISTS (VALUES ROW(1),ROW(2));

SELECT 1 FROM t1 WHERE EXISTS (VALUES ROW(1),ROW(2));
SELECT c0 FROM t1 WHERE EXISTS (VALUES ROW(1),ROW(2));

SELECT 1 FROM (SELECT 5) t1(c0) WHERE EXISTS (VALUES ROW(1),ROW(2));
SELECT c0 FROM t1 WHERE EXISTS (VALUES ROW(1),ROW(2) LIMIT 1 OFFSET 0);
SELECT c0 FROM t1 WHERE EXISTS (VALUES ROW(1),ROW(2) LIMIT 1 OFFSET 1);
SELECT c0 FROM t1 WHERE EXISTS (VALUES ROW(1),ROW(2) LIMIT 1 OFFSET 2);
SELECT c0 FROM t1 WHERE EXISTS (VALUES ROW(1),ROW(2) LIMIT 0);
SELECT c0 FROM t1 WHERE EXISTS (VALUES ROW(1),ROW(2) LIMIT 1);
                WHERE EXISTS (VALUES ROW(1),ROW(2) LIMIT 1 OFFSET ?)';

SET @n=0;

SET @n=1;

SET @n=2;
SET @n=0;

SET @n=1;

DROP PREPARE p;

DROP TABLE t1;

CREATE TABLE t1 (col varchar(1));
SELECT col
FROM t1
WHERE col >= (SELECT MAX(CONCAT('nz' COLLATE utf8mb4_la_0900_as_cs)) FROM t1);

DROP TABLE t1;
