BEGIN;
CREATE TABLE t1(a, b);
CREATE TABLE t2(a PRIMARY KEY, b);
INSERT INTO t2 SELECT * FROM t1;
BEGIN;
SELECT count(*) FROM t1;
PRAGMA cache_size = 10;
BEGIN;
