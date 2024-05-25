CREATE TABLE t0(a INTEGER);
CREATE TABLE t1(a INTEGER);
INSERT INTO t1 VALUES(1);
CREATE TABLE t2(a INTEGER);
INSERT INTO t2 VALUES(5), (8);
CREATE TABLE t6(a INTEGER);
INSERT INTO t6 VALUES(7), (1), (0), (5), (1), (4);
CREATE TABLE t8(a INTEGER);
INSERT INTO t8 VALUES(1), (3), (5), (7), (9), (7), (3), (1);
SELECT *
FROM t2 AS nt2
WHERE 1 IN (SELECT it1.a
            FROM t1 AS it1 JOIN t6 AS it3 ON it1.a=it3.a);
SELECT *
FROM t2 AS nt2
WHERE 1 IN (SELECT it1.a
            FROM t1 AS it1 JOIN t6 AS it3 ON it1.a=it3.a);
SELECT *
FROM t2 AS nt2, t8 AS nt4
WHERE 1 IN (SELECT it1.a
            FROM t1 AS it1 JOIN t6 AS it3 ON it1.a=it3.a);
SELECT *
FROM t2 AS nt2, t8 AS nt4
WHERE 1 IN (SELECT it1.a
            FROM t1 AS it1 JOIN t6 AS it3 ON it1.a=it3.a);
SELECT *
FROM t0 AS ot1, t2 AS nt3
WHERE ot1.a IN (SELECT it2.a
                FROM t1 AS it2 JOIN t8 AS it4 ON it2.a=it4.a);
SELECT *
FROM t0 as ot1, t2 AS nt3
WHERE ot1.a IN (SELECT it2.a
                FROM t1 AS it2 JOIN t8 AS it4 ON it2.a=it4.a);
DROP TABLE t0, t1, t2, t6, t8;
