
CREATE TABLE t1 (a INTEGER NOT NULL, b INT, PRIMARY KEY (a));
CREATE TABLE t2 (a INTEGER NOT NULL, KEY (a));
CREATE TABLE t3 (a INTEGER NOT NULL, b INT, KEY (a));
INSERT INTO t1 VALUES (1,10), (2,20), (3,30),  (4,40);
INSERT INTO t2 VALUES (2), (3), (4), (5);
INSERT INTO t3 VALUES (10,3), (20,4), (30,5);
SELECT * FROM t2 WHERE t2.a IN (SELECT a FROM t1);
SELECT * FROM t2 WHERE t2.a IN (SELECT /*+ NO_SEMIJOIN() */ a FROM t1);
SELECT /*+ NO_SEMIJOIN(@subq) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) */ a FROM t1);
SELECT * FROM t3
WHERE t3.a IN (SELECT a FROM t1 tx)
  AND t3.b IN (SELECT a FROM t1 ty);
SELECT * FROM t3
WHERE t3.a IN (SELECT /*+ NO_SEMIJOIN() */ a FROM t1 tx)
  AND t3.b IN (SELECT a FROM t1 ty);
SELECT /*+ NO_SEMIJOIN(@subq1) */ * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(`subq1`) */ a FROM t1 tx)
  AND t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty);
SELECT * FROM t3
WHERE t3.a IN (SELECT a FROM t1 tx)
  AND t3.b IN (SELECT /*+ NO_SEMIJOIN() */ a FROM t1 ty);
SELECT /*+ NO_SEMIJOIN(@`subq2`) */ * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx)
  AND t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty);
SELECT * FROM t3
WHERE t3.a IN (SELECT /*+ NO_SEMIJOIN() */ a FROM t1 tx)
  AND t3.b IN (SELECT /*+ NO_SEMIJOIN() */ a FROM t1 ty);
SELECT /*+ NO_SEMIJOIN(@subq1) NO_SEMIJOIN(@subq2) */ * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx)
  AND t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty);
SELECT * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx
               WHERE tx.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty));
SELECT /*+ NO_SEMIJOIN(@subq1) */ * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx
               WHERE tx.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty));
SELECT /*+ NO_SEMIJOIN(@subq2) */ * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx
               WHERE tx.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty));
SELECT /*+  NO_SEMIJOIN(@subq1) NO_SEMIJOIN(@subq2) */ * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx
               WHERE tx.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty));
SELECT /*+ SEMIJOIN(@subq) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) */ min(a) FROM t1 group by a);
SELECT * FROM t2 WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ NO_SEMIJOIN(@subq1 LOOSESCAN) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, LOOSESCAN) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, LOOSESCAN, MATERIALIZATION) */ *
FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, LOOSESCAN, MATERIALIZATION,
           DUPSWEEDOUT) */ *
FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, MATERIALIZATION, DUPSWEEDOUT) */ *
FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 MATERIALIZATION) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 DUPSWEEDOUT) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, DUPSWEEDOUT) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, MATERIALIZATION, DUPSWEEDOUT) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, FIRSTMATCH, MATERIALIZATION,
           DUPSWEEDOUT) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH, MATERIALIZATION, DUPSWEEDOUT) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 MATERIALIZATION, DUPSWEEDOUT) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT * FROM t1
WHERE t1.b IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3 WHERE t3.b = t1.a);
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, DUPSWEEDOUT) */ * FROM t1
WHERE t1.b IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3 WHERE t3.b = t1.a);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, MATERIALIZATION) */ * FROM t1
WHERE t1.b IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3 WHERE t3.b = t1.a);
SELECT * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN) SEMIJOIN(@subq2 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH) SEMIJOIN(@subq2 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN) SEMIJOIN(@subq2 LOOSESCAN) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH) SEMIJOIN(@subq2 LOOSESCAN) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH, LOOSESCAN)
           SEMIJOIN(@subq2 MATERIALIZATION, DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 MATERIALIZATION, DUPSWEEDOUT)
           SEMIJOIN(@subq2 FIRSTMATCH, LOOSESCAN) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 MATERIALIZATION, FIRSTMATCH)
           SEMIJOIN(@subq2 LOOSESCAN, DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ NO_SEMIJOIN(@subq1 LOOSESCAN)
           NO_SEMIJOIN(@subq2 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ NO_SEMIJOIN(@subq1 LOOSESCAN, FIRSTMATCH)
           NO_SEMIJOIN(@subq2 FIRSTMATCH, LOOSESCAN) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ NO_SEMIJOIN(@subq1 LOOSESCAN, FIRSTMATCH, DUPSWEEDOUT)
           NO_SEMIJOIN(@subq2 FIRSTMATCH, LOOSESCAN, DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 MATERIALIZATION)
           SEMIJOIN(@subq2 MATERIALIZATION) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 MATERIALIZATION)
           SEMIJOIN(@subq2 DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 MATERIALIZATION)
           SEMIJOIN(@subq2 LOOSESCAN, FIRSTMATCH, DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, MATERIALIZATION) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, MATERIALIZATION, DUPSWEEDOUT) */ *
FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, LOOSESCAN, MATERIALIZATION,
           DUPSWEEDOUT) */ *
FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ SEMIJOIN(@subq1 MATERIALIZATION) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ SEMIJOIN(@subq1 DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH, DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH, LOOSESCAN, DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH, MATERIALIZATION, LOOSESCAN,
           DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ SEMIJOIN(@subq1 MATERIALIZATION, LOOSESCAN, DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq2 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ SEMIJOIN(@subq2 MATERIALIZATION) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1) NO_SEMIJOIN(@subq2 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1)
           NO_SEMIJOIN(@subq2 FIRSTMATCH, MATERIALIZATION) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1)
           NO_SEMIJOIN(@subq2 FIRSTMATCH, MATERIALIZATION, DUPSWEEDOUT) */ *
FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1)
           SEMIJOIN(@subq2 MATERIALIZATION, DUPSWEEDOUT, LOOSESCAN) */ *
FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1) SEMIJOIN(@subq2 LOOSESCAN) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq2) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH) NO_SEMIJOIN(@subq2) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, MATERIALIZATION)
       	   NO_SEMIJOIN(@subq2) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, MATERIALIZATION, DUPSWEEDOUT)
       	   NO_SEMIJOIN(@subq2) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ SEMIJOIN(@subq1 MATERIALIZATION, DUPSWEEDOUT, LOOSESCAN)
       	   NO_SEMIJOIN(@subq2) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ SEMIJOIN(@subq1 DUPSWEEDOUT) NO_SEMIJOIN(@subq2) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1) NO_SEMIJOIN(@subq2) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2));
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, LOOSESCAN)
           NO_SEMIJOIN(@subq2 FIRSTMATCH, LOOSESCAN) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2)";
SELECT /*+ NO_SEMIJOIN(@subq1) SEMIJOIN(@subq2 LOOSESCAN) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3
               WHERE t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2))";

SET optimizer_switch = default;

SET optimizer_switch = 'semijoin=off';
SELECT * FROM t2 WHERE t2.a IN (SELECT a FROM t1);
SELECT /*+ NO_SEMIJOIN(@subq) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) */ a FROM t1);
SELECT /*+ SEMIJOIN(@subq) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) */ a FROM t1);
SELECT /*+ SEMIJOIN(@subq FIRSTMATCH) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) */ a FROM t1);
SELECT * FROM t3
WHERE t3.a IN (SELECT a FROM t1 tx)
  AND t3.b IN (SELECT a FROM t1 ty);
SELECT /*+ SEMIJOIN(@subq1) */ * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx)
  AND t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty);
SELECT /*+ SEMIJOIN(@subq2) */ * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx)
  AND t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty);
SELECT /*+ SEMIJOIN(@subq1) SEMIJOIN(@subq2) */ * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx)
  AND t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty);
SELECT * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx
               WHERE tx.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty));
SELECT /*+ SEMIJOIN(@subq1) */ * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx
               WHERE tx.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty));
SELECT /*+ SEMIJOIN(@subq2) */ * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx
               WHERE tx.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty));
SELECT /*+ SEMIJOIN(@subq1) SEMIJOIN(@subq2) */ * FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx
               WHERE tx.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty));
SET optimizer_switch='semijoin=on';

SET optimizer_switch='loosescan=off';
SELECT * FROM t2 WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ NO_SEMIJOIN(@subq1 LOOSESCAN) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, MATERIALIZATION) */ *
FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 MATERIALIZATION) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, DUPSWEEDOUT) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, MATERIALIZATION, DUPSWEEDOUT) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, FIRSTMATCH, MATERIALIZATION,
           DUPSWEEDOUT) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SET optimizer_switch='firstmatch=off';
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH, MATERIALIZATION, DUPSWEEDOUT) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ NO_SEMIJOIN(@subq1 MATERIALIZATION, DUPSWEEDOUT) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT * FROM t1
WHERE t1.b IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3 WHERE t3.b = t1.a);
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, DUPSWEEDOUT) */ * FROM t1
WHERE t1.b IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3 WHERE t3.b = t1.a);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, FIRSTMATCH) */ * FROM t1
WHERE t1.b IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3 WHERE t3.b = t1.a);
SELECT * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, FIRSTMATCH)
       	   SEMIJOIN(@subq2 LOOSESCAN, FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH) SEMIJOIN(@subq2 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH) SEMIJOIN(@subq2 LOOSESCAN) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH, LOOSESCAN)
           SEMIJOIN(@subq2 MATERIALIZATION, DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ NO_SEMIJOIN(@subq1 DUPSWEEDOUT)
           NO_SEMIJOIN(@subq2 DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 MATERIALIZATION)
           SEMIJOIN(@subq2 MATERIALIZATION) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ NO_SEMIJOIN(@subq1 DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ NO_SEMIJOIN(@subq2 DUPSWEEDOUT) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SET optimizer_switch='firstmatch=on,loosescan=on,materialization=on,duplicateweedout=off';
SELECT /*+ NO_SEMIJOIN(@subq1 LOOSESCAN, FIRSTMATCH, MATERIALIZATION) */ *
FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT * FROM t1
WHERE t1.b IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3 WHERE t3.b = t1.a);
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH) */ * FROM t1
WHERE t1.b IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3 WHERE t3.b = t1.a);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, MATERIALIZATION) */ * FROM t1
WHERE t1.b IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3 WHERE t3.b = t1.a);
SET optimizer_switch='firstmatch=off,loosescan=off,materialization=off,duplicateweedout=off';
SELECT * FROM t2 WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ NO_SEMIJOIN(@subq1 LOOSESCAN, DUPSWEEDOUT) */ *
FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 FIRSTMATCH, MATERIALIZATION) */ *
FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, MATERIALIZATION) */ * FROM t1
WHERE t1.b IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3 WHERE t3.b = t1.a);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN, FIRSTMATCH) */ * FROM t1
WHERE t1.b IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3 WHERE t3.b = t1.a);

SET optimizer_switch = default;
SELECT /*+ NO_SEMIJOIN(@subq1 FIRSTMATCH, LOOSESCAN)
           NO_SEMIJOIN(@subq2 FIRSTMATCH, LOOSESCAN) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2)";
SET optimizer_switch = 'duplicateweedout=off';
SET optimizer_switch = 'duplicateweedout=on';

SET optimizer_switch = default;
SELECT * FROM t2
WHERE t2.a IN (SELECT /*+ NO_SEMIJOIN() SEMIJOIN() */ a FROM t1);
SELECT * FROM t2
WHERE t2.a IN (SELECT /*+ SEMIJOIN() NO_SEMIJOIN() */ a FROM t1);
SELECT /*+ NO_SEMIJOIN(@subq) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) SEMIJOIN() */ a FROM t1);
SELECT /*+ SEMIJOIN(@subq) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) NO_SEMIJOIN() */ a FROM t1);
SELECT /*+ SEMIJOIN(@subq) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) SEMIJOIN() */ a FROM t1);
SELECT /*+ NO_SEMIJOIN(@subq) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) NO_SEMIJOIN() */ a FROM t1);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN) SEMIJOIN(@subq2 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) NO_SEMIJOIN() */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) SEMIJOIN(LOOSESCAN) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN) SEMIJOIN(@subq2 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) NO_SEMIJOIN(LOOSESCAN) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) SEMIJOIN(LOOSESCAN) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN) SEMIJOIN(@subq1 FIRSTMATCH) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 LOOSESCAN) NO_SEMIJOIN(@subq1 LOOSESCAN) */ *
FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ NO_SEMIJOIN(@subq1 LOOSESCAN) NO_SEMIJOIN(@subq1 FIRSTMATCH) */ *
FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT /*+ SEMIJOIN(@subq1 INTOEXISTS) NO_SEMIJOIN(@subq2 INTOEXISTS) */ *
FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2);
SELECT * FROM t2 WHERE t2.a IN (SELECT /*+ SUBQUERY(INTOEXISTS) */ a FROM t1);
SELECT /*+ SUBQUERY(@subq MATERIALIZATION) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) */ a FROM t1);
SELECT /*+ SUBQUERY(@subq1 INTOEXISTS) SUBQUERY(@subq2 MATERIALIZATION) */ *
FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx)
  AND t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty);
SELECT /*+ SUBQUERY(@subq1 INTOEXISTS) SUBQUERY(@subq2 MATERIALIZATION) */ *
FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx
               WHERE tx.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty));
SELECT /*+ SUBQUERY(@subq1 MATERIALIZATION) SUBQUERY(@subq2 INTOEXISTS) */ *
FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx
               WHERE tx.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty));
SELECT * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) */ min(a) FROM t1 group by a);
SELECT /*+ SUBQUERY(@subq INTOEXISTS) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) */ min(a) FROM t1 group by a);
SELECT a, a IN (SELECT a FROM t1) FROM t2;
SELECT a, a IN (SELECT /*+ SUBQUERY(MATERIALIZATION) */ a FROM t1) FROM t2;
SELECT /*+ SUBQUERY(@subq MATERIALIZATION) */ a,
       a IN (SELECT /*+ QB_NAME(subq) */ a FROM t1) FROM t2;
SELECT * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) */ concat(sum(b),"") FROM t1 group by a);
SELECT /*+ SUBQUERY(@subq MATERIALIZATION) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) */ concat(sum(b),"") FROM t1 group by a);
SELECT /*+ SUBQUERY(@subq1 MATERIALIZATION)
           SUBQUERY(@subq2 INTOEXISTS) */ * FROM t1
WHERE t1.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t3)
  AND t1.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t2)";
SET optimizer_switch='materialization=off';
SELECT * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) */ min(a) FROM t1 group by a);
SELECT /*+ SUBQUERY(@subq MATERIALIZATION) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) */ min(a) FROM t1 group by a);

SET optimizer_switch='materialization=on,subquery_materialization_cost_based=off';
SELECT a, a IN (SELECT a FROM t1) FROM t2;
SELECT /*+ SUBQUERY(@subq INTOEXISTS) */ a,
       a IN (SELECT /*+ QB_NAME(subq) */ a FROM t1) FROM t2;
SELECT /*+ SUBQUERY(@subq1 MATERIALIZATION, INTOEXISTS)
       SUBQUERY(@subq2 MATERIALIZATION, INTOEXISTS) */ *
FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx)
  AND t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty);
SELECT /*+ SUBQUERY(@subq1 FIRSTMATCH) SUBQUERY(@subq2 LOOSESCAN) */ *
FROM t3
WHERE t3.a IN (SELECT /*+ QB_NAME(subq1) */ a FROM t1 tx)
  AND t3.b IN (SELECT /*+ QB_NAME(subq2) */ a FROM t1 ty);

SET optimizer_switch= default;
SELECT * FROM t2
WHERE t2.a IN (SELECT /*+ SUBQUERY(MATERIALIZATION) SUBQUERY(INTOEXISTS) */ a
FROM t1);
SELECT * FROM t2
WHERE t2.a IN (SELECT /*+ SUBQUERY(INTOEXISTS) SUBQUERY(MATERIALIZATION) */ a
FROM t1);
SELECT /*+ SUBQUERY(@subq MATERIALIZATION) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) SUBQUERY(INTOEXISTS) */ a FROM t1);
SELECT /*+ SUBQUERY(@subq INTOEXISTS) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) SUBQUERY(MATERIALIZATION) */ a FROM t1);
SELECT * FROM t2
WHERE t2.a IN (SELECT /*+ SUBQUERY(INTOEXISTS) SEMIJOIN() */ a FROM t1);
SELECT * FROM t2
WHERE t2.a IN (SELECT /*+ NO_SEMIJOIN() SUBQUERY(MATERIALIZATION) */ a FROM t1);
SELECT /*+ SUBQUERY(@subq MATERIALIZATION) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) SEMIJOIN() */ a FROM t1);
SELECT /*+ SUBQUERY(@subq INTOEXISTS) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) NO_SEMIJOIN() */ a FROM t1);
SELECT /*+ SEMIJOIN(@subq FIRSTMATCH) */ * FROM t2
WHERE t2.a IN (SELECT /*+ QB_NAME(subq) SUBQUERY(@subq INTOEXISTS) */ a FROM t1);




drop table t1, t2, t3;
