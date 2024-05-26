CREATE TABLE t1(a, b);
CREATE INDEX i1 ON t1(a);
CREATE INDEX i2 ON t1(b);
BEGIN;
SELECT * FROM t1 WHERE a < 500;
SELECT * FROM t1 WHERE b = 810000 AND NOT (a < 500);
SELECT * FROM t1 WHERE a < 90000;
SELECT * FROM t1 WHERE b = 8100000000 AND NOT (a < 90000);