CREATE INDEX i1 ON t1(a);
INSERT INTO t1 VALUES(1), (2), (3), (4), (5), (6), (7), (8), (9);
SELECT sum(a) FROM t1;
SELECT sum(a) FILTER( WHERE a<5 ) FROM t1;
SELECT sum(a) FILTER( WHERE a>9 ),
         sum(a) FILTER( WHERE a>8 ),
         sum(a) FILTER( WHERE a>7 ),
         sum(a) FILTER( WHERE a>6 ),
         sum(a) FILTER( WHERE a>5 ),
         sum(a) FILTER( WHERE a>4 ),
         sum(a) FILTER( WHERE a>3 ),
         sum(a) FILTER( WHERE a>2 ),
         sum(a) FILTER( WHERE a>1 ),
         sum(a) FILTER( WHERE a>0 )
  FROM t1;
SELECT max(a) FILTER (WHERE (a % 2)==0) FROM t1;
SELECT min(a) FILTER (WHERE a>4) FROM t1;
SELECT count(*) FILTER (WHERE a!=5) FROM t1;
SELECT min(a) FILTER (WHERE a>3) FROM t1 GROUP BY (a%2) ORDER BY 1;
CREATE VIEW vv AS 
  SELECT sum(a) FILTER( WHERE a>9 ),
         sum(a) FILTER( WHERE a>8 ),
         sum(a) FILTER( WHERE a>7 ),
         sum(a) FILTER( WHERE a>6 ),
         sum(a) FILTER( WHERE a>5 ),
         sum(a) FILTER( WHERE a>4 ),
         sum(a) FILTER( WHERE a>3 ),
         sum(a) FILTER( WHERE a>2 ),
         sum(a) FILTER( WHERE a>1 ),
         sum(a) FILTER( WHERE a>0 )
  FROM t1;
SELECT * FROM vv;
INSERT INTO t1 VALUES(1), (2), (3), (4), (5), (6), (7), (8), (9);
CREATE TABLE t2(a, b, c);
INSERT INTO t2 VALUES(1, 2, 3);
INSERT INTO t2 VALUES(1, 3, 4);
INSERT INTO t2 VALUES(2, 5, 6);
INSERT INTO t2 VALUES(2, 7, 8);
SELECT a, c, max(b) FILTER (WHERE c='x') FROM t2 GROUP BY a;
DELETE FROM t2;
INSERT INTO t2 VALUES(1, 5, 'x');
INSERT INTO t2 VALUES(1, 2, 3);
INSERT INTO t2 VALUES(1, 4, 'x');
INSERT INTO t2 VALUES(2, 5, 6);
INSERT INTO t2 VALUES(2, 7, 8);
SELECT a, c, max(b) FILTER (WHERE c='x') FROM t2 GROUP BY a;
SELECT (SELECT COUNT(a) FROM t2) FROM t1;
CREATE TABLE t0(c0 INT);
CREATE TABLE t1a(a INTEGER PRIMARY KEY, b TEXT);
INSERT INTO t1a VALUES(1,'one'),(2,NULL),(3,'three');
CREATE TABLE t1b(c INTEGER PRIMARY KEY, d TEXT);
INSERT INTO t1b VALUES(4,'four'),(5,NULL),(6,'six');
