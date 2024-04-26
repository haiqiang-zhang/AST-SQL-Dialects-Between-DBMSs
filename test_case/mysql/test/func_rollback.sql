--           ROLLBACK of statement
-- Essential of the bug:
-- - A SELECT using a FUNCTION processes a table.
-- - The SELECT affects more than row.
-- - The FUNCTION modifies a table.
-- - When processing the non first matching row, the function fails.
--   But the modification caused by the function when the SELECT processed the
--   first matching row is not reverted.
--   
-- Goal of this test:  Attempts to catch a situation where
-- - a statement A involving the execution of one or more functions is run
-- - the function/functions themself contain one or more statements
--   modifying a table
-- - one of the modifying statements within one of the functions fails
-- - the table remains at least partially modified
--
-- = There is no automatic ROLLBACK of changes caused by the failing
--     statement A.
-- = Statement A is not atomic.
--
-- Notes:
-- - The table to be modified must use a transactional storage engine.
--   For example MyISAM cannot avoid the situation above.
-- - Some comments assume that the rows of the table t1_select are processed
--   in the order of insertion. That means
--      SELECT f1,f2 FROM t1_select
--   should have the same result set and row order like
--   SELECT f1,f2 FROM t1_select ORDER BY f1;
--   Inserting NULL into a column that has been declared NOT NULL.
--   For multiple-row INSERT statements or INSERT INTO ... SELECT statements,
--   the column is set to the implicit default value for the column data type.
--
-- Created:
-- 2008-04-09 mleich
--

let $fixed_bug_35877 = 0;

let $from_select = SELECT 1 AS f1,1 AS f2 UNION ALL SELECT 1,NULL;

let $engine = InnoDB;
DROP TABLE IF EXISTS t1_select;
DROP TABLE IF EXISTS t1_aux;
DROP TABLE IF EXISTS t1_not_null;
DROP VIEW IF EXISTS v1_not_null;
DROP VIEW IF EXISTS v1_func;
DROP TABLE IF EXISTS t1_fail;
DROP FUNCTION IF EXISTS f1_simple_insert;
DROP FUNCTION IF EXISTS f1_two_inserts;
DROP FUNCTION IF EXISTS f1_insert_select;

SET SESSION AUTOCOMMIT=0;
SET SESSION sql_mode = '';

CREATE TABLE t1_select (f1 BIGINT, f2 BIGINT) ENGINE = MEMORY;
INSERT INTO t1_select(f1,f2) VALUES (1,-1),(2,NULL),(3,0),(4,1),(5,2);
SELECT * FROM t1_select;
CREATE TABLE t1_not_null (f1 BIGINT, f2 BIGINT NOT NULL)
ENGINE = $engine;
SELECT * FROM t1_not_null;
CREATE TABLE t1_aux (f1 BIGINT, f2 BIGINT)
ENGINE = $engine;
SELECT * FROM t1_aux;

-- FUNCTION with "simple" INSERT
delimiter //;
CREATE FUNCTION f1_simple_insert(my_f1 INTEGER) RETURNS INTEGER
BEGIN
   INSERT INTO t1_not_null SET f1 = 10, f2 = my_f1;
SELECT f1_simple_insert(1);
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null;
SELECT f1_simple_insert(1) FROM t1_select;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null;
SELECT f1_simple_insert(NULL);
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT f1_simple_insert(NULL) FROM t1_select;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT f1_simple_insert(f2) FROM t1_select;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT f1_simple_insert(1),f1_simple_insert(NULL);
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT f1_simple_insert(NULL),f1_simple_insert(1);
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT f1_simple_insert(f1),f1_simple_insert(f2) FROM t1_select;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT f1_simple_insert(f2),f1_simple_insert(f1) FROM t1_select;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT f1_simple_insert(f1_simple_insert(NULL)) FROM t1_select;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT f1_simple_insert(f1_simple_insert(1) + NULL) FROM t1_select;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
DROP FUNCTION f1_simple_insert;

-- FUNCTION with INSERT ... SELECT
delimiter //;
let $f1_insert_select =
CREATE FUNCTION f1_insert_select(my_f1 INTEGER) RETURNS INTEGER
BEGIN
   INSERT INTO t1_not_null SELECT * FROM t1_select WHERE f1 = my_f1;
SELECT f1_insert_select(2);
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
DROP FUNCTION f1_insert_select;
SET SESSION sql_mode = 'traditional';
SELECT f1_insert_select(2);
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
DROP FUNCTION f1_insert_select;
SET SESSION sql_mode = '';

-- FUNCTION with two simple INSERTs
--echo
--echo -- Function tries to
--echo --    1. INSERT statement: Insert one row with NULL -> NOT NULL violation
--echo --    2. INSERT statement: Insert one row without NULL
-- I guess the execution of the function becomes aborted just when the
-- error happens.
delimiter //;
CREATE FUNCTION f1_two_inserts() RETURNS INTEGER
BEGIN
   INSERT INTO t1_not_null SET f1 = 10, f2 = NULL;
   INSERT INTO t1_not_null SET f1 = 10, f2 = 10;
SELECT f1_two_inserts();
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
DROP FUNCTION f1_two_inserts;
CREATE FUNCTION f1_two_inserts() RETURNS INTEGER
BEGIN
   INSERT INTO t1_not_null SET f1 = 10, f2 = 10;
   INSERT INTO t1_not_null SET f1 = 10, f2 = NULL;
SELECT f1_two_inserts();
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
let $f1_insert_with_two_rows =
CREATE FUNCTION f1_insert_with_two_rows() RETURNS INTEGER
BEGIN
   INSERT INTO t1_not_null(f1,f2) VALUES (10,10),(10,NULL);
SELECT f1_insert_with_two_rows();
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
DROP FUNCTION f1_insert_with_two_rows;
SET SESSION sql_mode = 'traditional';
SELECT f1_insert_with_two_rows();
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SET SESSION sql_mode = '';
SELECT 1 FROM t1_select t1
WHERE 1 = (SELECT f1_insert_with_two_rows() FROM t1_select t2
           WHERE t2.f1 = t1.f1);
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT 1 FROM t1_select t1, t1_select t2
WHERE t1.f1 = t2.f1 AND t2.f1 = f1_insert_with_two_rows();
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT STRAIGHT_JOIN * FROM t1_select t2 RIGHT JOIN t1_select t1
ON t1.f1 = t1.f1 WHERE 1 = f1_insert_with_two_rows();

DROP FUNCTION f1_insert_with_two_rows;
SELECT 1
UNION ALL
SELECT f1_two_inserts();
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
INSERT INTO t1_aux SET f1 = 1, f2 = f1_two_inserts();
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
INSERT INTO t1_aux SELECT 1, f1_two_inserts();
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_aux ORDER BY f1,f2;
INSERT INTO t1_aux VALUES(1,f1_two_inserts());
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_aux ORDER BY f1,f2;
INSERT INTO t1_aux VALUES (1,1);
DELETE FROM t1_aux WHERE f1 = f1_two_inserts();
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_aux ORDER BY f1,f2;
UPDATE t1_aux SET f2 = f1_two_inserts() + 1;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_aux ORDER BY f1,f2;
UPDATE t1_aux SET f2 = 2 WHERE f1 = f1_two_inserts();
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_aux ORDER BY f1,f2;
CREATE VIEW v1_func AS SELECT f1_two_inserts() FROM t1_select;
SELECT * FROM v1_func;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
DROP VIEW v1_func;
CREATE TABLE t1_fail AS SELECT f1_two_inserts() FROM t1_select;
SELECT * FROM t1_not_null ORDER BY f1,f2;
CREATE TABLE t1_fail AS SELECT * FROM t1_select WHERE 1 = f1_two_inserts();
SELECT * FROM t1_not_null ORDER BY f1,f2;
--

--echo
--echo -- FUNCTION in ORDER BY
--error ER_BAD_NULL_ERROR
SELECT * FROM t1_select ORDER BY f1,f1_two_inserts();
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT AVG(f1_two_inserts()) FROM t1_select;
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT 1 FROM t1_select HAVING AVG(f1) = f1_two_inserts() + 2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
DROP FUNCTION f1_two_inserts;
CREATE VIEW v1_not_null AS SELECT f1,f2 FROM t1_not_null WITH CHECK OPTION;
CREATE FUNCTION f1_two_inserts_v1() RETURNS INTEGER
BEGIN
   INSERT INTO v1_not_null SET f1 = 10, f2 = 10;
   INSERT INTO v1_not_null SET f1 = 10, f2 = NULL;
SELECT f1_two_inserts_v1();
SELECT * FROM t1_not_null ORDER BY f1,f2;
SELECT * FROM t1_not_null ORDER BY f1,f2;
DROP FUNCTION f1_two_inserts_v1;
DROP VIEW v1_not_null;
CREATE TABLE t1_parent (f1 BIGINT, f2 BIGINT, PRIMARY KEY(f1))
ENGINE = $engine;
INSERT INTO t1_parent VALUES (1,1);
CREATE TABLE t1_child (f1 BIGINT, f2 BIGINT, PRIMARY KEY(f1),
FOREIGN KEY (f1) REFERENCES t1_parent(f1))
ENGINE = $engine;
CREATE FUNCTION f1_two_inserts() RETURNS INTEGER
BEGIN
   INSERT INTO t1_child SET f1 = 1, f2 = 1;
   INSERT INTO t1_child SET f1 = 2, f2 = 2;
SELECT f1_two_inserts();
SELECT * FROM t1_child;
DROP TABLE t1_child;
DROP TABLE t1_parent;
DROP FUNCTION f1_two_inserts;

-- Cleanup
DROP TABLE t1_select;
DROP TABLE t1_aux;
DROP TABLE t1_not_null;
