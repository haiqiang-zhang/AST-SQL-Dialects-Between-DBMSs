CREATE TABLE t1 (a int PRIMARY KEY, b varchar(128), KEY(b))
ENGINE = InnoDB
PARTITION BY HASH(a) PARTITIONS 13;
INSERT INTO t1 VALUES (1, 'First row, p1');
INSERT INTO t1 VALUES (0, 'First row, p0'), (2, 'First row, p2'),
                      (3, 'First row, p3'), (4, 'First row, p4');
INSERT INTO t1 VALUES (1 * 13, 'Second row, p0'), (2 * 13, 'Third row, p0'),
                      (3 * 13, 'Fourth row, p0'), (4 * 13, 'Fifth row, p0');
CREATE TABLE t2 SELECT a, b FROM t1 WHERE a in (0, 1, 13, 113);
SELECT * FROM t2 ORDER by a;
DROP TABLE t2;
CREATE TABLE t2 SELECT a, b FROM t1 WHERE b LIKE 'First%';
SELECT * FROM t2 ORDER BY a;
DROP TABLE t2, t1;
CREATE TABLE t1 (a INT) PARTITION BY HASH (a) PARTITIONS 3;
INSERT INTO t1 VALUES (1), (3), (9), (2), (8), (7);
CREATE TABLE t2 SELECT * FROM t1 PARTITION (p1, p2);
SELECT * FROM t2;
DROP TABLE t2;
CREATE TABLE t2 SELECT * FROM t1 WHERE a IN (1, 3, 9);
SELECT * FROM t2;
DROP TABLE t1, t2;
