CREATE TABLE t2(c, d);
CREATE TABLE t1(a, b);
INSERT INTO t1 VALUES(1, 1);
INSERT INTO t1 VALUES(2, 2);
INSERT INTO t1 VALUES(1, 3);
INSERT INTO t1 VALUES(2, 4);
INSERT INTO t1 VALUES(1, 5);
INSERT INTO t1 VALUES(2, 6);
SELECT a, sum(b) FROM t1 GROUP BY a HAVING a=2;
SELECT x,y FROM (
    SELECT a AS x, sum(b) AS y FROM t1 
    GROUP BY a
  ) WHERE x BETWEEN 2 AND 9999;
SELECT x,y FROM (
    SELECT a AS x, sum(b) AS y FROM t1 
    WHERE x BETWEEN 2 AND 9999 
    GROUP BY a
  );
CREATE TABLE t3(a, b);
INSERT INTO t3 VALUES(1, 1);
INSERT INTO t3 VALUES(1, 2);
INSERT INTO t3 VALUES(1, 3);
INSERT INTO t3 VALUES(2, 1);
INSERT INTO t3 VALUES(2, 2);
INSERT INTO t3 VALUES(2, 3);
INSERT INTO t1 VALUES('a', 'b');
SELECT EXISTS (
    SELECT * FROM (
      SELECT * FROM (
        SELECT 1
      ) WHERE Col0 = 1   GROUP BY 1
    )   WHERE 0
  )
  FROM (SELECT 1 Col0)   GROUP BY 1;
