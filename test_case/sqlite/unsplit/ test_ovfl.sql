PRAGMA cache_size = 10;
CREATE TABLE t1(c1 TEXT, c2 TEXT);
BEGIN;
SELECT sum(length(c2)) FROM t1;
