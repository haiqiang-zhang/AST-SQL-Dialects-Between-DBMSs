CREATE TABLE t1 (a INT, b INT, c INT, d INT,
                 KEY i_a(a), KEY i_b(b),
                 KEY i_ab(a,b), KEY i_c(c), KEY i_d(d));
INSERT INTO t1 VALUES
(1,1,1,1),(2,2,2,1),(3,3,3,1),(4,4,4,1),
(5,5,5,1),(6,6,6,1),(7,7,7,1),(8,8,8,1);
INSERT INTO t1 SELECT a,b, c + 10, d FROM t1;
INSERT INTO t1 SELECT a,b, c + 20, d FROM t1;
INSERT INTO t1 SELECT a,b, c + 40, d FROM t1;
INSERT INTO t1 SELECT a,b, c + 80, d FROM t1;
INSERT INTO t1 SELECT a,b, c + 160, d FROM t1;
CREATE VIEW v1 AS SELECT /*+ NO_INDEX(t1 i_a,i_b) */ a FROM t1 WHERE
 b IN (SELECT /*+ NO_INDEX(t1 i_ab,i_b) */ a FROM t1 WHERE a > 3)
ORDER BY a;
CREATE VIEW v2 AS SELECT /*+ INDEX(ta i_a) */ ta.a FROM v1, t1 ta WHERE ta.a > 3;
CREATE VIEW v3 AS SELECT /*+ INDEX_MERGE(t1) */a FROM t1
WHERE a = 1 AND b = 2 AND c = 3;
DROP VIEW v1, v2, v3;
DROP TABLE t1;
