CREATE TABLE t (x INTEGER);
INSERT INTO t VALUES (1), (2), (3);
SELECT DISTINCT MIN(t2.x), t1.x
 FROM t t1 JOIN t t2 USING (x)
 GROUP BY t2.x;
DROP TABLE t;
CREATE TABLE t1(
  a INT,
  b INT,
  c INT,
  d INT,
  e INT,
    PRIMARY KEY(a,b),
  KEY ix1 (c,d)
);
INSERT INTO t1 VALUES (0,0,0,0,1), (1,0,1,0,1), (0,1,2,0,1), (2,0,2,0,1), (4,0,0,0,1);
SELECT c,sum(e) FROM t1 GROUP BY c WITH ROLLUP;
SELECT c,d,sum(e) FROM t1 GROUP BY c,d WITH ROLLUP;
SELECT c,d,a,sum(e) FROM t1 GROUP BY c,d,a WITH ROLLUP;
SELECT c,d,a,b,sum(e) FROM t1 GROUP BY c,d,a,b WITH ROLLUP;
SELECT a,sum(e) FROM t1 GROUP BY a WITH ROLLUP;
SELECT a,b,sum(e) FROM t1 GROUP BY a,b WITH ROLLUP;
SELECT d,a,c,sum(e) FROM t1 GROUP BY d,a,c;
SELECT a,d,c,sum(e) FROM t1 GROUP BY a,d,c;
SELECT b,a,sum(e) FROM t1 GROUP BY b,a;
DROP TABLE t1;
CREATE TABLE num10 (n INT);
INSERT INTO num10 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE VIEW num1000 AS
SELECT d1.n+d2.n*10+d3.n*100 n FROM num10 d1, num10 d2, num10 d3;
CREATE TABLE t1(
  a INT,
  b INT,
  c INT,
  d INT,
  e INT,
  f INT,
  g INT,
  h INT,
  i INT,
  j INT,
  k INT,
  l INT,
  PRIMARY KEY(a,b),
  KEY ix1 (c,d),
  KEY ix2 (d,a,c),
  KEY ix3 (g,h,i,j),
  KEY ix4 (k,j,l),
  KEY ix5 (k,l)
);
INSERT INTO t1
  SELECT n/100,n%100,n%5,n%7,n%11,n%13,n%10,n%10,n%10,n%10,n%10,n%10
  FROM num1000;
CREATE TABLE t2 (
  c1 INT,
  c2 INT,
  c3 INT,
  PRIMARY KEY(c1,c2)
);
INSERT INTO t2 SELECT n%5,n/5,n%3 FROM num10;
DROP VIEW num1000;
DROP TABLE num10, t1, t2;
CREATE TABLE t (
col1 INT, col2 INT, col3 INT, col4 INT, col5 INT, col6 INT,
col7 INT, col8 INT, col9 INT, col10 INT, col11 INT, col12 INT,
col13 INT, col14 INT, col15 INT, col16 INT, col17 INT, col18 INT,
col19 INT, col20 INT, col21 INT, col22 INT, col23 INT, col24 INT,
col25 INT, col26 INT, col27 INT, col28 INT, col29 INT, col30 INT,
col31 INT, col32 INT, col33 INT, col34 INT, col35 INT, col36 INT,
col37 INT, col38 INT, col39 INT, col40 INT, col41 INT, col42 INT,
col43 INT, col44 INT, col45 INT, col46 INT, col47 INT, col48 INT,
col49 INT, col50 INT, col51 INT, col52 INT, col53 INT, col54 INT,
col55 INT, col56 INT, col57 INT, col58 INT, col59 INT, col60 INT,
col61 INT, col62 INT, col63 INT, col64 INT,
KEY (col1, col2), KEY (col2, col3), KEY (col3), KEY (col4), KEY (col5),
KEY (col6), KEY (col7), KEY (col8), KEY (col9), KEY (col10),
KEY (col11), KEY (col12), KEY (col13), KEY (col14), KEY (col15),
KEY (col16), KEY (col17), KEY (col18), KEY (col19), KEY (col20),
KEY (col21), KEY (col22), KEY (col23), KEY (col24), KEY (col25),
KEY (col26), KEY (col27), KEY (col28), KEY (col29), KEY (col30),
KEY (col31), KEY (col32), KEY (col33), KEY (col34), KEY (col35),
KEY (col36), KEY (col37), KEY (col38), KEY (col39), KEY (col40),
KEY (col41), KEY (col42), KEY (col43), KEY (col44), KEY (col45),
KEY (col46), KEY (col47), KEY (col48), KEY (col49), KEY (col50),
KEY (col51), KEY (col52), KEY (col53), KEY (col54), KEY (col55),
KEY (col56), KEY (col57), KEY (col58), KEY (col59), KEY (col60),
KEY (col61), KEY (col62), KEY (col63), KEY (col64));
DROP TABLE t;
