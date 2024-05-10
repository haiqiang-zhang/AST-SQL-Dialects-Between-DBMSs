CREATE TABLE t1(a,b);
WITH RECURSIVE c(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM c WHERE x<1000)
    INSERT INTO t1(a,b) SELECT 1, (x*17)%1000 + 1000 FROM c;
INSERT INTO t1(a,b) VALUES(2,2),(3,1006),(4,4),(5,9999);
CREATE INDEX t1ab ON t1(a,b);
SELECT a, b, '|' FROM t1 WHERE a IN (2,4,5,3,1) ORDER BY b LIMIT 5;
SELECT a, b, '|' FROM t1 WHERE a IN (2,4,5,3,1) ORDER BY +b LIMIT 5;
CREATE TABLE t2(x,y);
INSERT INTO t2(x,y) VALUES('a',1),('a',2),('a',3),('a',4);
INSERT INTO t2(x,y) VALUES('b',1),('c',2),('d',3),('e',4);
CREATE INDEX t2xy ON t2(x,y);
SELECT a, b, '|' FROM t2, t1 WHERE t2.x='a' AND t1.a=t2.y ORDER BY t1.b LIMIT 5;
SELECT a, b, '|' FROM t2, t1 WHERE t2.x='a' AND t1.a=t2.y ORDER BY +t1.b LIMIT 5;
DROP INDEX t1ab;
CREATE INDEX t1ab ON t1(a,b DESC);
SELECT a, b, '|' FROM t1 WHERE a IN (2,4,5,3,1) ORDER BY b DESC LIMIT 5;
SELECT a, b, '|' FROM t1 WHERE a IN (2,4,5,3,1) ORDER BY +b DESC LIMIT 5;
CREATE TABLE t200(a, b);
WITH RECURSIVE c(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM c WHERE x<1000)
    INSERT INTO t200(a,b) SELECT x, x FROM c;
CREATE TABLE t201(x INTEGER PRIMARY KEY, y);
INSERT INTO t201(x,y) VALUES(2,12345);
SELECT *, '|' FROM t200, t201 WHERE x=b ORDER BY y LIMIT 3;
SELECT *, '|' FROM t200 LEFT JOIN t201 ON x=b ORDER BY y LIMIT 3;
CREATE TABLE t300(a,b,c);
CREATE INDEX t300x ON t300(a,b,c);
INSERT INTO t300 VALUES(0,1,99),(0,1,0),(0,0,0);
SELECT *,'.' FROM t300 WHERE a=0 AND (c=0 OR c=99) ORDER BY c DESC;
SELECT *,'.' FROM t300 WHERE a=0 AND (c=0 OR c=99) ORDER BY c DESC LIMIT 1;
CREATE TABLE t400(a,b);
CREATE INDEX t400_ab ON t400(a,b);
INSERT INTO t400(a,b) VALUES(1,90),(1,40),(2,80),(2,30),(3,70),(3,20);
SELECT *,'x' FROM t400 WHERE a IN (1,2,3) ORDER BY b DESC LIMIT 3;
SELECT *,'y' FROM t400 WHERE a IN (1,2,3) ORDER BY +b DESC LIMIT 3;
CREATE TABLE t500(i INTEGER PRIMARY KEY, j);
INSERT INTO t500 VALUES(1, 1);
INSERT INTO t500 VALUES(2, 2);
INSERT INTO t500 VALUES(3, 3);
INSERT INTO t500 VALUES(4, 0);
INSERT INTO t500 VALUES(5, 5);
SELECT j FROM t500 WHERE i IN (1,2,3,4,5) ORDER BY j DESC LIMIT 3;
CREATE TABLE t501(i INTEGER PRIMARY KEY, j);
INSERT INTO t501 VALUES(1, 5);
INSERT INTO t501 VALUES(2, 4);
INSERT INTO t501 VALUES(3, 3);
INSERT INTO t501 VALUES(4, 6);
INSERT INTO t501 VALUES(5, 1);
SELECT j FROM t501 WHERE i IN (1,2,3,4,5) ORDER BY j LIMIT 3;
CREATE TABLE t502(i INT PRIMARY KEY, j);
INSERT INTO t502 VALUES(1, 5);
INSERT INTO t502 VALUES(2, 4);
INSERT INTO t502 VALUES(3, 3);
INSERT INTO t502 VALUES(4, 6);
INSERT INTO t502 VALUES(5, 1);
SELECT j FROM t502 WHERE i IN (1,2,3,4,5) ORDER BY j LIMIT 3;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a, b);
INSERT INTO t1 VALUES(1,2);
DROP TABLE IF EXISTS t2;
CREATE TABLE t2(x, y);
INSERT INTO t2 VALUES(1,3);
CREATE INDEX t1ab ON t1(a,b);
SELECT y FROM t1, t2 WHERE a=x AND b<=y ORDER BY b DESC;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1(aa VARCHAR PRIMARY KEY NOT NULL,bb,cc,x VARCHAR(400));
INSERT INTO t1(aa,bb,cc) VALUES('maroon','meal','lecture');
INSERT INTO t1(aa,bb,cc) VALUES('reality','meal','catsear');
CREATE TABLE t2(aa VARCHAR PRIMARY KEY, dd INT DEFAULT 1, ee, x VARCHAR(100));
INSERT INTO t2(aa,dd,ee) VALUES('maroon',0,'travel'),('reality',0,'hour');
CREATE INDEX t2x1 ON t2(dd,ee);
ANALYZE;
DROP TABLE IF EXISTS sqlite_stat4;
DELETE FROM sqlite_stat1;
INSERT INTO sqlite_stat1 VALUES
    ('t2','t2x1','3 3 3'),
    ('t2','sqlite_autoindex_t2_1','3 1'),
    ('t1','sqlite_autoindex_t1_1','2 1');
ANALYZE sqlite_master;
SELECT *
    FROM t1 LEFT JOIN t2 ON t1.aa=t2.aa
   WHERE t1.bb='meal'
   ORDER BY t2.dd DESC
   LIMIT 1;
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1(aa, bb);
INSERT INTO t1 VALUES('maroon','meal');
CREATE TABLE t2(cc, dd, ee, x VARCHAR(100));
INSERT INTO t2(cc,dd,ee) VALUES('maroon',1,'one');
INSERT INTO t2(cc,dd,ee) VALUES('maroon',2,'two');
INSERT INTO t2(cc,dd,ee) VALUES('maroon',0,'zero');
CREATE INDEX t2ddee ON t2(dd,ee);
CREATE INDEX t2cc ON t2(cc);
ANALYZE;
SELECT t2.cc, t2.dd, t2.ee FROM t1 CROSS JOIN t2 ON t1.aa=t2.cc
  ORDER BY t2.dd LIMIT 1;
SELECT t2.cc, t2.dd, t2.ee FROM t1 CROSS JOIN t2 ON t1.aa=t2.cc
  WHERE t1.bb='meal'
  ORDER BY t2.dd LIMIT 1;