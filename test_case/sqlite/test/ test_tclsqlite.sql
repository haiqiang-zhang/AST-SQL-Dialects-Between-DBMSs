CREATE TABLE t1(a int, b int);
INSERT INTO t1 VALUES(10,20);
CREATE TABLE tÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£x(a int, bÃÂÃÂÃÂÃÂ¡ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂµ float);
PRAGMA table_info(tÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£x);
INSERT INTO tÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£x VALUES(1,2.3);
INSERT INTO t1 SELECT a*2, b*2 FROM t1;
INSERT INTO t1 SELECT a*2+1, b*2+1 FROM t1;
INSERT INTO t1 SELECT a*2+3, b*2+3 FROM t1;
CREATE TABLE t3(a,b,c);
SELECT * FROM t3;
SELECT typeof(a), typeof(b), typeof(c) FROM t3;
SELECT typeof(a), typeof(b), typeof(c) FROM t3;
INSERT INTO t1 VALUES(30,NULL);
CREATE TABLE t6(x);
INSERT INTO t6 VALUES(1);
INSERT INTO t1 VALUES(1,2),(2,NULL),(3,'xyz');
