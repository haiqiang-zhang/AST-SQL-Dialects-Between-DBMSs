CREATE TABLE t0(a, b, c);
INSERT INTO t0 VALUES(1, 2, 3);
SELECT * FROM t0;
BEGIN;
SELECT *  FROM t0;
SELECT * FROM t0;
