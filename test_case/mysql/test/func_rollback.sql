DROP TABLE IF EXISTS t1_select;
DROP TABLE IF EXISTS t1_aux;
DROP TABLE IF EXISTS t1_not_null;
DROP VIEW IF EXISTS v1_not_null;
DROP VIEW IF EXISTS v1_func;
DROP TABLE IF EXISTS t1_fail;
DROP FUNCTION IF EXISTS f1_simple_insert;
DROP FUNCTION IF EXISTS f1_two_inserts;
DROP FUNCTION IF EXISTS f1_insert_select;
CREATE TABLE t1_select (f1 BIGINT, f2 BIGINT) ENGINE = MEMORY;
INSERT INTO t1_select(f1,f2) VALUES (1,-1),(2,NULL),(3,0),(4,1),(5,2);
SELECT * FROM t1_select;
DROP TABLE t1_select;
