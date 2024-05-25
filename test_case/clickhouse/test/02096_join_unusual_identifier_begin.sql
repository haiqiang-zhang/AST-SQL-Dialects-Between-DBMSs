DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;
CREATE TABLE t1 ( `a1` Int64, `1a1` Int64 ) ENGINE = Memory;
INSERT INTO t1 VALUES (1, 1);
CREATE TABLE t2 ( `b1` Int64, `1b1` Int64 ) ENGINE = Memory;
INSERT INTO t2 VALUES (1, 1);
CREATE TABLE t3 ( `c1` Int64, `1c1` Int64 ) ENGINE = Memory;
INSERT INTO t3 VALUES (1, 1);
SELECT
    *
FROM t1 AS t1
INNER JOIN t2 AS t2 ON t1.a1 = t2.b1
INNER JOIN t3 AS t3 ON t1.a1 = t3.c1;
SELECT t2.`1b1` FROM t1 JOIN t2 ON a1 = b1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;
