CREATE TABLE t1(x int, y int);
BEGIN;
INSERT INTO t1 VALUES(31,10);
INSERT INTO t1 VALUES(30,9);
INSERT INTO t1 VALUES(29,8);
INSERT INTO t1 VALUES(28,8);
INSERT INTO t1 VALUES(27,7);
INSERT INTO t1 VALUES(26,7);
INSERT INTO t1 VALUES(25,7);
INSERT INTO t1 VALUES(24,7);
INSERT INTO t1 VALUES(23,6);
INSERT INTO t1 VALUES(22,6);
INSERT INTO t1 VALUES(21,6);
INSERT INTO t1 VALUES(20,6);
INSERT INTO t1 VALUES(19,6);
INSERT INTO t1 VALUES(18,6);
INSERT INTO t1 VALUES(17,6);
INSERT INTO t1 VALUES(16,6);
INSERT INTO t1 VALUES(15,5);
INSERT INTO t1 VALUES(14,5);
INSERT INTO t1 VALUES(13,5);
INSERT INTO t1 VALUES(12,5);
INSERT INTO t1 VALUES(11,5);
INSERT INTO t1 VALUES(10,5);
INSERT INTO t1 VALUES(9,5);
INSERT INTO t1 VALUES(8,5);
INSERT INTO t1 VALUES(7,5);
INSERT INTO t1 VALUES(6,5);
INSERT INTO t1 VALUES(5,5);
INSERT INTO t1 VALUES(4,5);
INSERT INTO t1 VALUES(3,5);
INSERT INTO t1 VALUES(2,5);
INSERT INTO t1 VALUES(1,5);
INSERT INTO t1 VALUES(0,5);
SELECT count(*) FROM t1;
SELECT x FROM t1 ORDER BY x LIMIT 5;
SELECT x FROM t1 ORDER BY x LIMIT 5 OFFSET 2;
SELECT x FROM t1 ORDER BY x+1 LIMIT 5 OFFSET -2;
SELECT x FROM t1 ORDER BY x+1 LIMIT 2, -5;
SELECT x FROM t1 ORDER BY x+1 LIMIT -2, 5;
SELECT x FROM t1 ORDER BY x+1 LIMIT -2, -5;
SELECT x FROM t1 ORDER BY x LIMIT 2, 5;
SELECT x FROM t1 ORDER BY x LIMIT 5 OFFSET 5;
SELECT x FROM t1 ORDER BY x LIMIT 50 OFFSET 30;
SELECT x FROM t1 ORDER BY x LIMIT 30, 50;
SELECT x FROM t1 ORDER BY x LIMIT 50 OFFSET 50;
SELECT * FROM t1 AS a, t1 AS b ORDER BY a.x, b.x LIMIT 5;
SELECT * FROM t1 AS a, t1 AS b ORDER BY a.x, b.x LIMIT 5 OFFSET 32;
CREATE VIEW v1 AS SELECT * FROM t1 LIMIT 2;
CREATE TABLE t2 AS SELECT * FROM t1 LIMIT 2;
SELECT z FROM (SELECT y*10+x AS z FROM t1 ORDER BY x LIMIT 10)
      ORDER BY z LIMIT 5;
BEGIN;
CREATE TABLE t3(x);
INSERT INTO t3 SELECT x FROM t1 ORDER BY x LIMIT 10 OFFSET 1;
INSERT INTO t3 SELECT x+(SELECT max(x) FROM t3) FROM t3;
INSERT INTO t3 SELECT x+(SELECT max(x) FROM t3) FROM t3;
INSERT INTO t3 SELECT x+(SELECT max(x) FROM t3) FROM t3;
INSERT INTO t3 SELECT x+(SELECT max(x) FROM t3) FROM t3;
INSERT INTO t3 SELECT x+(SELECT max(x) FROM t3) FROM t3;
INSERT INTO t3 SELECT x+(SELECT max(x) FROM t3) FROM t3;
INSERT INTO t3 SELECT x+(SELECT max(x) FROM t3) FROM t3;
INSERT INTO t3 SELECT x+(SELECT max(x) FROM t3) FROM t3;
INSERT INTO t3 SELECT x+(SELECT max(x) FROM t3) FROM t3;
INSERT INTO t3 SELECT x+(SELECT max(x) FROM t3) FROM t3;
SELECT x FROM t3 LIMIT 2 OFFSET 10000;
CREATE TABLE t4 AS SELECT x,
       'abcdefghijklmnopqrstuvwyxz ABCDEFGHIJKLMNOPQRSTUVWYXZ' || x ||
       'abcdefghijklmnopqrstuvwyxz ABCDEFGHIJKLMNOPQRSTUVWYXZ' || x ||
       'abcdefghijklmnopqrstuvwyxz ABCDEFGHIJKLMNOPQRSTUVWYXZ' || x ||
       'abcdefghijklmnopqrstuvwyxz ABCDEFGHIJKLMNOPQRSTUVWYXZ' || x ||
       'abcdefghijklmnopqrstuvwyxz ABCDEFGHIJKLMNOPQRSTUVWYXZ' || x AS y
    FROM t3 LIMIT 1000;
SELECT x FROM t4 ORDER BY y DESC LIMIT 1 OFFSET 999;
CREATE TABLE t5(x,y);
INSERT INTO t5 SELECT x-y, x+y FROM t1 WHERE x BETWEEN 10 AND 15
        ORDER BY x LIMIT 2;
SELECT * FROM t5 ORDER BY x;
DELETE FROM t5;
INSERT INTO t5 SELECT x-y, x+y FROM t1 WHERE x BETWEEN 10 AND 15
        ORDER BY x DESC LIMIT 2;
SELECT * FROM t5 ORDER BY x;
DELETE FROM t5;
INSERT INTO t5 SELECT x-y, x+y FROM t1 WHERE x ORDER BY x DESC LIMIT 31;
SELECT * FROM t5 ORDER BY x LIMIT 2;
SELECT * FROM t5 ORDER BY x DESC, y DESC LIMIT 2;
DELETE FROM t5;
INSERT INTO t5 SELECT a.x*100+b.x, a.y*100+b.y FROM t1 AS a, t1 AS b
                   ORDER BY 1, 2 LIMIT 1000;
SELECT count(*), sum(x), sum(y), min(x), max(x), min(y), max(y) FROM t5;
BEGIN;
CREATE TABLE t6(a);
INSERT INTO t6 VALUES(1);
INSERT INTO t6 VALUES(2);
INSERT INTO t6 SELECT a+2 FROM t6;
SELECT * FROM t6;
SELECT * FROM t6 LIMIT -1 OFFSET -1;
SELECT * FROM t6 LIMIT 2 OFFSET -123;
SELECT * FROM t6 LIMIT -432 OFFSET 2;
SELECT * FROM t6 LIMIT -1;
SELECT * FROM t6 LIMIT -1 OFFSET 1;
SELECT * FROM t6 LIMIT 0;
SELECT * FROM t6 LIMIT 0 OFFSET 1;
SELECT x FROM t2 UNION ALL SELECT a FROM t6 LIMIT 5;
SELECT x FROM t2 UNION ALL SELECT a FROM t6 LIMIT 3 OFFSET 1;
SELECT x FROM t2 UNION ALL SELECT a FROM t6 ORDER BY 1 LIMIT 3 OFFSET 1;
SELECT x FROM t2 UNION SELECT x+2 FROM t2 LIMIT 2 OFFSET 1;
SELECT x FROM t2 UNION SELECT x+2 FROM t2 ORDER BY 1 DESC LIMIT 2 OFFSET 1;
SELECT a+9 FROM t6 EXCEPT SELECT y FROM t2 LIMIT 2;
SELECT a+9 FROM t6 EXCEPT SELECT y FROM t2 ORDER BY 1 DESC LIMIT 2;
SELECT a+26 FROM t6 INTERSECT SELECT x FROM t2 LIMIT 1;
SELECT a+27 FROM t6 INTERSECT SELECT x FROM t2 LIMIT 1;
SELECT a+27 FROM t6 INTERSECT SELECT x FROM t2 LIMIT 1 OFFSET 1;
SELECT a+27 FROM t6 INTERSECT SELECT x FROM t2 
       ORDER BY 1 DESC LIMIT 1 OFFSET 1;
SELECT DISTINCT cast(round(x/100) as integer) FROM t3 LIMIT 5;
SELECT * FROM (SELECT * FROM t6 LIMIT 3);
CREATE TABLE t7 AS SELECT * FROM t6;
SELECT * FROM (SELECT * FROM t7 LIMIT 3);
SELECT * FROM (SELECT * FROM t6 LIMIT 3)
        UNION
        SELECT * FROM (SELECT * FROM t7 LIMIT 3)
        ORDER BY 1;
SELECT * FROM (SELECT * FROM t6 LIMIT 3)
        UNION
        SELECT * FROM (SELECT * FROM t7 LIMIT 3)
        ORDER BY 1
        LIMIT 2;
SELECT 123 LIMIT 1 OFFSET 0;
SELECT 123 LIMIT 1 OFFSET 1;
SELECT 123 LIMIT 0 OFFSET 0;
SELECT 123 LIMIT 0 OFFSET 1;
SELECT 123 LIMIT -1 OFFSET 0;
SELECT 123 LIMIT -1 OFFSET 1;
CREATE TABLE t3_a(k, v);
CREATE TABLE t3_b(k, v);
INSERT INTO t3_a VALUES(300000,'yellow'),(500,'pink'),(8000,'red');
INSERT INTO t6 default values;
