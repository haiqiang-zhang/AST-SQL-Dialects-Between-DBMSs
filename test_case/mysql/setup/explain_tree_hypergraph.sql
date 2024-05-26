CREATE TABLE num (n INT);
INSERT INTO num VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t1 (a INT PRIMARY KEY, b INT);
INSERT INTO t1 SELECT n,n FROM num;
DROP TABLE num,t1;
CREATE TABLE num10 (n INT);
INSERT INTO num10 VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE t1(
  a INT,
  b INT,
  c INT,
  d INT,
  e INT,
  f INT,
  g INT,
  h INT,
  KEY(d)
);
INSERT INTO t1
  SELECT n%17, n% 19, n, n, n, n, n, n
  FROM (SELECT d1.n+d2.n*10+d3.n*100 n FROM num10 d1, num10 d2, num10 d3) num1000;
