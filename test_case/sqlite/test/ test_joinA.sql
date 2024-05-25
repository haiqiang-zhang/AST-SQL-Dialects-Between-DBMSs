SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           INNER JOIN t2 USING(c,d)
           INNER JOIN t3 USING(a,b,f)
           INNER JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           LEFT JOIN t2 USING(c,d)
           LEFT JOIN t3 USING(a,b,f)
           LEFT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           LEFT JOIN t2 USING(c,d)
           RIGHT JOIN t3 USING(a,b,f)
           LEFT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           RIGHT JOIN t2 USING(c,d)
           LEFT JOIN t3 USING(a,b,f)
           RIGHT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           FULL JOIN t2 USING(c,d)
           LEFT JOIN t3 USING(a,b,f)
           RIGHT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           RIGHT JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           RIGHT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           RIGHT JOIN t2 USING(c,d)
           LEFT JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           LEFT JOIN t2 USING(c,d)
           RIGHT JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e,t1.a
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
     WHERE t1.a!=0
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e,t3.a
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
     WHERE t3.a!=0
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e,t4.a
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
     WHERE t4.a!=0
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
     WHERE t2.e!=0
    ORDER BY 1 nulls first, 3 nulls first;
INSERT INTO t1 VALUES(11,21,31,41),(12,22,32,42),(15,25,35,45),(18,28,38,48);
INSERT INTO t2 VALUES(12,22,32,42),(13,23,33,43),(15,25,35,45),(17,27,37,47);
INSERT INTO t3 VALUES(14,24,34,44),(15,25,35,45),(16,26,36,46);
INSERT INTO t4 VALUES(11,21,31,41),(13,23,33,43),(16,26,36,46),(19,29,39,49);
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           INNER JOIN t2 USING(c,d)
           INNER JOIN t3 USING(a,b,f)
           INNER JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           LEFT JOIN t2 USING(c,d)
           LEFT JOIN t3 USING(a,b,f)
           LEFT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           LEFT JOIN t2 USING(c,d)
           RIGHT JOIN t3 USING(a,b,f)
           LEFT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           RIGHT JOIN t2 USING(c,d)
           LEFT JOIN t3 USING(a,b,f)
           RIGHT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           FULL JOIN t2 USING(c,d)
           LEFT JOIN t3 USING(a,b,f)
           RIGHT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           RIGHT JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           RIGHT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           RIGHT JOIN t2 USING(c,d)
           LEFT JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           LEFT JOIN t2 USING(c,d)
           RIGHT JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e,t1.a
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
     WHERE t1.a!=0
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e,t3.a
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
     WHERE t3.a!=0
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e,t4.a
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
     WHERE t4.a!=0
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
     WHERE t2.e!=0
    ORDER BY 1 nulls first, 3 nulls first;
CREATE TABLE t1a(a INT, b INT, c INT, d INT);
CREATE TABLE t2a(c INT, d INT, e INT, f INT);
CREATE TABLE t3a(a INT, b INT, e INT, f INT);
CREATE TABLE t4a(a INT, c INT, d INT, f INT);
INSERT INTO t1a VALUES(11,21,31,41),(12,22,32,42);
INSERT INTO t2a VALUES(12,22,32,42),(13,23,33,43);
INSERT INTO t3a VALUES(14,24,34,44),(15,25,35,45);
INSERT INTO t4a VALUES(11,21,31,41),(13,23,33,43);
CREATE TABLE t1b(a INT, b INT, c INT, d INT);
CREATE TABLE t2b(c INT, d INT, e INT, f INT);
CREATE TABLE t3b(a INT, b INT, e INT, f INT);
CREATE TABLE t4b(a INT, c INT, d INT, f INT);
INSERT INTO t1b VALUES(15,25,35,45),(18,28,38,48);
INSERT INTO t2b VALUES(15,25,35,45),(17,27,37,47);
INSERT INTO t3b VALUES(15,25,35,45),(16,26,36,46);
INSERT INTO t4b VALUES(16,26,36,46),(19,29,39,49);
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           INNER JOIN t2 USING(c,d)
           INNER JOIN t3 USING(a,b,f)
           INNER JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           LEFT JOIN t2 USING(c,d)
           LEFT JOIN t3 USING(a,b,f)
           LEFT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           LEFT JOIN t2 USING(c,d)
           RIGHT JOIN t3 USING(a,b,f)
           LEFT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           RIGHT JOIN t2 USING(c,d)
           LEFT JOIN t3 USING(a,b,f)
           RIGHT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           FULL JOIN t2 USING(c,d)
           LEFT JOIN t3 USING(a,b,f)
           RIGHT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           RIGHT JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           RIGHT JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           RIGHT JOIN t2 USING(c,d)
           LEFT JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           LEFT JOIN t2 USING(c,d)
           RIGHT JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e,t1.a
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
     WHERE t1.a!=0
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e,t3.a
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
     WHERE t3.a!=0
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e,t4.a
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
     WHERE t4.a!=0
    ORDER BY 1 nulls first, 3 nulls first;
SELECT a,b,c,d,t2.e,f,t3.e
      FROM t1
           FULL JOIN t2 USING(c,d)
           FULL JOIN t3 USING(a,b,f)
           FULL JOIN t4 USING(a,c,d,f)
     WHERE t2.e!=0
    ORDER BY 1 nulls first, 3 nulls first;
