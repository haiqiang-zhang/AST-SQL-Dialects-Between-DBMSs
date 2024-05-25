SELECT count(distinct a),
           count(distinct b),
           count(distinct c),
           count(all a) FROM t1;
SELECT b, count(distinct c) FROM t1 GROUP BY b;
INSERT INTO t1 SELECT a+1, b+3, c+5 FROM t1;
INSERT INTO t1 SELECT a+2, b+6, c+10 FROM t1;
INSERT INTO t1 SELECT a+4, b+12, c+20 FROM t1;
SELECT count(*), count(distinct a), count(distinct b) FROM t1;
SELECT a, count(distinct c) FROM t1 GROUP BY a ORDER BY a;
CREATE TABLE t2(d, e, f);
INSERT INTO t1 VALUES (1, 1, 1);
INSERT INTO t1 VALUES (2, 2, 2);
INSERT INTO t1 VALUES (3, 3, 3);
INSERT INTO t1 VALUES (4, 1, 4);
INSERT INTO t1 VALUES (5, 2, 1);
INSERT INTO t1 VALUES (5, 3, 2);
INSERT INTO t1 VALUES (4, 1, 3);
INSERT INTO t1 VALUES (3, 2, 4);
INSERT INTO t1 VALUES (2, 3, 1);
INSERT INTO t1 VALUES (1, 1, 2);
INSERT INTO t2 VALUES('a', 'a', 'a');
INSERT INTO t2 VALUES('b', 'b', 'b');
INSERT INTO t2 VALUES('c', 'c', 'c');
CREATE INDEX t1a ON t1(a);
CREATE INDEX t1bc ON t1(b, c);
SELECT count(DISTINCT a) FROM t1;
SELECT count(DISTINCT b) FROM t1;
SELECT count(DISTINCT c) FROM t1;
SELECT count(DISTINCT c) FROM t1 WHERE b=3;
SELECT count(DISTINCT rowid) FROM t1;
SELECT count(DISTINCT a) FROM t1, t2;
SELECT count(DISTINCT a) FROM t2, t1;
SELECT count(DISTINCT a+b) FROM t1, t2, t2, t2;
SELECT count(DISTINCT c) FROM t1 WHERE c=2;
SELECT count(DISTINCT t1.rowid) FROM t1, t2;
SELECT a, count(DISTINCT b) FROM t1 GROUP BY a;
INSERT INTO t1 VALUES(1, 'A', 1);
INSERT INTO t1 VALUES(1, 'A', 1);
INSERT INTO t1 VALUES(2, 'A', 2);
INSERT INTO t1 VALUES(2, 'A', 2);
INSERT INTO t1 VALUES(1, 'B', 1);
INSERT INTO t1 VALUES(2, 'B', 2);
INSERT INTO t1 VALUES(3, 'B', 3);
INSERT INTO t1 VALUES(NULL, 'B', NULL);
INSERT INTO t1 VALUES(NULL, 'C', NULL);
INSERT INTO t1 VALUES('d', 'D', 'd');
CREATE INDEX t2def ON t2(d, e, f);
INSERT INTO t2 VALUES(1, 1, 'a');
INSERT INTO t2 VALUES(1, 1, 'a');
INSERT INTO t2 VALUES(1, 2, 'a');
INSERT INTO t2 VALUES(1, 2, 'a');
INSERT INTO t2 VALUES(1, 2, 'b');
INSERT INTO t2 VALUES(1, 3, 'b');
INSERT INTO t2 VALUES(1, 3, 'a');
INSERT INTO t2 VALUES(1, 3, 'b');
INSERT INTO t2 VALUES(2, 3, 'x');
INSERT INTO t2 VALUES(2, 3, 'y');
INSERT INTO t2 VALUES(2, 3, 'z');
CREATE TABLE t3(x, y, z);
INSERT INTO t3 VALUES(1,1,1);
INSERT INTO t3 VALUES(2,2,2);
CREATE TABLE t4(a);
CREATE INDEX t4a ON t4(a);
INSERT INTO t4 VALUES(1), (2), (2), (3), (1);
SELECT count(DISTINCT c) FROM t1 GROUP BY b;
SELECT count(DISTINCT a) FROM t1 GROUP BY b;
SELECT count(DISTINCT a) FROM t1 GROUP BY b+c;
SELECT count(DISTINCT f) FROM t2 GROUP BY d, e;
SELECT count(DISTINCT f) FROM t2 GROUP BY d;
SELECT count(DISTINCT f) FROM t2 WHERE d IS 1 GROUP BY e;
SELECT count(DISTINCT a) FROM t1;
SELECT count(DISTINCT a) FROM t4;
SELECT count(*) FROM t3;
SELECT count(*) FROM t1;
SELECT count(DISTINCT a) FROM t1, t3;
SELECT count(DISTINCT a) FROM t1 LEFT JOIN t3;
SELECT count(DISTINCT a) FROM t1 LEFT JOIN t3 WHERE t3.x=1;
SELECT count(DISTINCT a) FROM t1 LEFT JOIN t3 WHERE t3.x=0;
SELECT count(DISTINCT a) FROM t1 LEFT JOIN t3 ON (t3.x=0);
SELECT count(DISTINCT x) FROM t1 LEFT JOIN t3;
SELECT count(DISTINCT x) FROM t1 LEFT JOIN t3 WHERE t3.x=1;
SELECT count(DISTINCT x) FROM t1 LEFT JOIN t3 WHERE t3.x=0;
SELECT count(DISTINCT x) FROM t1 LEFT JOIN t3 ON (t3.x=0);
SELECT count(DISTINCT c) FROM t1 LEFT JOIN t2;
CREATE TABLE v1 ( v2 UNIQUE, v3 AS( TYPEOF ( NULL ) ) UNIQUE );
SELECT COUNT ( DISTINCT TRUE ) FROM v1 GROUP BY likelihood ( v3 , 0.100000 );
