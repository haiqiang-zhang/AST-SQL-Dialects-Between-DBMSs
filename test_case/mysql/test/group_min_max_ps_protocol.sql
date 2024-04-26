--

--source include/have_ps_protocol.inc

--
-- Bug#24156: Loose index scan not used with CREATE TABLE ...SELECT and similar statements
--

CREATE TABLE t1 (a INT, b INT, INDEX (a,b));
INSERT INTO t1 (a, b) VALUES (1,1), (1,2), (1,3), (1,4), (1,5),
       (2,2), (2,3), (2,1), (3,1), (4,1), (4,2), (4,3), (4,4), (4,5), (4,6),
       (5,1), (5,2), (5,3), (5,4), (5,5);
SELECT max(b), a FROM t1 GROUP BY a;
CREATE TABLE t2 SELECT max(b), a FROM t1 GROUP BY a;
SELECT * FROM (SELECT max(b), a FROM t1 GROUP BY a) b;
  a IN (SELECT max(b) FROM t1 GROUP BY a HAVING a < 2);
  a > (SELECT max(b) FROM t1 GROUP BY a HAVING a < 2);
   ON t1_outer1.a = (SELECT max(b) FROM t1 GROUP BY a HAVING a < 2)
   AND t1_outer1.b = t1_outer2.b;

CREATE TABLE t3 LIKE t1;
INSERT INTO t3 SELECT a,MAX(b) FROM t1 GROUP BY a;
DELETE FROM t3;
INSERT INTO t3 SELECT 1, (SELECT MAX(b) FROM t1 GROUP BY a HAVING a < 2) 
  FROM t1 LIMIT 1;
DELETE FROM t3 WHERE (SELECT MAX(b) FROM t1 GROUP BY a HAVING a < 2) > 10000;
DELETE FROM t3 WHERE (SELECT (SELECT MAX(b) FROM t1 GROUP BY a HAVING a < 2) x 
                      FROM t1) > 10000;

DROP TABLE t1,t2,t3;
