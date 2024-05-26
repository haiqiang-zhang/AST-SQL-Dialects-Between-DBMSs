SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE TABLE t1 (x INT, y INT);
INSERT INTO t1 VALUES (3, 3), (1, 1);
CREATE TABLE t2 (y INT, z INT);
INSERT INTO t2 VALUES (2, 2), (4, 4);
CREATE TABLE new_table AS (SELECT x, y FROM t1 UNION ALL BY NAME SELECT y, z FROM t2);
