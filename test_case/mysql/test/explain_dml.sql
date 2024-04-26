--

--source include/have_debug.inc
--source include/have_debug_sync.inc

CREATE TABLE t1 (c1 INT NOT NULL, c2 varchar (64), PRIMARY KEY (c1))
PARTITION BY RANGE (c1)
SUBPARTITION BY HASH (c1) SUBPARTITIONS 2
(PARTITION p0 VALUES LESS THAN (0)
 (SUBPARTITION subp0,
  SUBPARTITION subp1),
 PARTITION p1 VALUES LESS THAN (100000)
 (SUBPARTITION subp6,
  SUBPARTITION subp7));

CREATE TABLE t2 (c1 int);
CREATE TABLE t3 LIKE t2;
INSERT INTO t1 VALUES (1, 'a'), (2, 'b'), (3, 'c');
INSERT INTO t2 SELECT c1 FROM t1;
INSERT INTO t3 SELECT c1 FROM t2;

CREATE VIEW v1 AS SELECT * FROM t1 WHERE c1 > 20;
CREATE VIEW v2 AS SELECT t1.* FROM t1 JOIN t2 ON t1.c2=t2.c1;
DELETE LOW_PRIORITY QUICK IGNORE
FROM t1 PARTITION (p1)
WHERE c1 > 0
ORDER BY c2
LIMIT 10;
DELETE LOW_PRIORITY QUICK IGNORE t1 , t2
FROM t1, t2, t3
WHERE t1.c1 > 0;
UPDATE LOW_PRIORITY IGNORE t1
SET c1 = 20
WHERE c1 > 100;
UPDATE LOW_PRIORITY IGNORE t1 LEFT JOIN t2 ON t1.c1 = t2.c1
SET t1.c1 = 20
WHERE t1.c1 > 0;

-- Uses explain_single_table_modification(). (See next for distinction).
EXPLAIN UPDATE v1 SET c2=c1;

-- Update a view with a JOIN (or multiple tables). Unlike UPDATE of a single
-- table this doesn't go through explain_single_table_modification(). It goes
-- through explain_query()
EXPLAIN UPDATE v2 SET c2=c1;
INSERT LOW_PRIORITY IGNORE INTO t1 PARTITION(p0, p1) (c1, c2)
  VALUES (1, 'a'), (2, 'b')
  ON DUPLICATE KEY UPDATE c2 = 'c';
INSERT HIGH_PRIORITY IGNORE INTO t1 PARTITION(p0, p1) (c1, c2)
  VALUES (1, 'a'), (2, 'b')
  ON DUPLICATE KEY UPDATE c2 = 'c';
INSERT DELAYED IGNORE INTO t1 PARTITION(p0, p1) (c1, c2)
  SELECT c1, 'a' FROM t2
  ON DUPLICATE KEY UPDATE c2 = 'c' ;
INSERT INTO t1 PARTITION(p0, p1)
  SET c1 = (SELECT c1 from t2);
  SELECT c1, 'a' FROM t2;
  SET c1 = (SELECT c1 from t2);
let $QID= `SELECT CONNECTION_ID()`;
let $point=   planned_single_delete;
let $err=0;

let $query=DELETE FROM t3 WHERE c1 > 0;
let $format=traditional;
let $query=
UPDATE LOW_PRIORITY IGNORE t1 LEFT JOIN t2 ON t1.c1 = t2.c1
SET t1.c1 = 20
WHERE t1.c1 > 0;

let $point= before_reset_query_plan;
let $format=traditional;
INSERT /*+ NO_BNL(t2@QB1) */ INTO t3
  (SELECT /*+ QB_NAME(qb1) */ t2.c1
   FROM t1,t2
   WHERE t1.c2 = t2.c1);
INSERT INTO t3
  (SELECT /*+ NO_ICP(t2) */ t2.c1
   FROM t1,t2
   WHERE t1.c2 = t2.c1);
INSERT INTO t3
  (SELECT /*+ NO_ICP(t2) */ t2.c1
   FROM t2
   WHERE t2.c1 IN (SELECT /*+ NO_ICP(t1) */ t1.c1
                   FROM t1
                   WHERE t1.c2 BETWEEN 'a' AND 'z'));

DROP VIEW v1, v2;
DROP TABLE t1, t2, t3;
