CREATE TABLE t (x INT);
INSERT INTO t VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);
CREATE TABLE t1 (x INT);
CREATE TABLE t2 (x INT);
CREATE TABLE t3 (x INT);
INSERT INTO t1 SELECT 10*tens.x + ones.x FROM t AS ones, t AS tens;
INSERT INTO t2 SELECT 10*tens.x + ones.x FROM t AS ones, t AS tens;
INSERT INTO t3 SELECT 10*tens.x + ones.x FROM t AS ones, t AS tens;
DROP TABLE t, t1, t2, t3;
