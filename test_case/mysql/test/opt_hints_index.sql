CREATE VIEW v1 AS SELECT /*+ NO_INDEX(t1 i_a,i_b) */ a FROM t1 WHERE
 b IN (SELECT /*+ NO_INDEX(t1 i_ab,i_b) */ a FROM t1 WHERE a > 3)
ORDER BY a;
CREATE VIEW v2 AS SELECT /*+ INDEX(ta i_a) */ ta.a FROM v1, t1 ta WHERE ta.a > 3;
CREATE VIEW v3 AS SELECT /*+ INDEX_MERGE(t1) */a FROM t1
WHERE a = 1 AND b = 2 AND c = 3;
DROP VIEW v1, v2, v3;
DROP TABLE t1;
