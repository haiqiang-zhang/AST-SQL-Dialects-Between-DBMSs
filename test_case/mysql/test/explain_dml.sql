SELECT c1, 'a' FROM t2;
UPDATE LOW_PRIORITY IGNORE t1 LEFT JOIN t2 ON t1.c1 = t2.c1
SET t1.c1 = 20
WHERE t1.c1 > 0;
INSERT INTO t3
  (SELECT /*+ NO_ICP(t2) */ t2.c1
   FROM t2
   WHERE t2.c1 IN (SELECT /*+ NO_ICP(t1) */ t1.c1
                   FROM t1
                   WHERE t1.c2 BETWEEN 'a' AND 'z'));
DROP VIEW v1, v2;
DROP TABLE t1, t2, t3;
