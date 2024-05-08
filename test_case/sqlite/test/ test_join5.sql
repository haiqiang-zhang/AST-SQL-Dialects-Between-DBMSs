BEGIN;
CREATE TABLE t1(a integer primary key, b integer, c integer);
CREATE TABLE t2(x integer primary key, y);
CREATE TABLE t3(p integer primary key, q);
INSERT INTO t3 VALUES(11,'t3-11');
INSERT INTO t3 VALUES(12,'t3-12');
INSERT INTO t2 VALUES(11,'t2-11');
INSERT INTO t2 VALUES(12,'t2-12');
INSERT INTO t1 VALUES(1, 5, 0);
INSERT INTO t1 VALUES(2, 11, 2);
INSERT INTO t1 VALUES(3, 12, 1);
select * from t1 left join t2 on t1.b=t2.x and t1.c=1;
select * from t1 left join t2 on t1.b=t2.x where t1.c=1;
select * from t1 left join t2 on t1.b=t2.x and t1.c=1
                     left join t3 on t1.b=t3.p and t1.c=2;
select * from t1 left join t2 on t1.b=t2.x and t1.c=1
                     left join t3 on t1.b=t3.p where t1.c=2;
CREATE TABLE ab(a,b);
INSERT INTO "ab" VALUES(1,2);
INSERT INTO "ab" VALUES(3,NULL);
CREATE TABLE xy(x,y);
INSERT INTO "xy" VALUES(2,3);
INSERT INTO "xy" VALUES(NULL,1);
SELECT * FROM xy LEFT JOIN ab ON 0;
SELECT * FROM xy LEFT JOIN ab ON 1;
SELECT * FROM xy LEFT JOIN ab ON NULL;
SELECT * FROM xy LEFT JOIN ab ON 0 WHERE 0;
SELECT * FROM xy LEFT JOIN ab ON 1 WHERE 0;
SELECT * FROM xy LEFT JOIN ab ON NULL WHERE 0;
SELECT * FROM xy LEFT JOIN ab ON 0 WHERE 1;
SELECT * FROM xy LEFT JOIN ab ON 1 WHERE 1;
SELECT * FROM xy LEFT JOIN ab ON NULL WHERE 1;
SELECT * FROM xy LEFT JOIN ab ON 0 WHERE NULL;
SELECT * FROM xy LEFT JOIN ab ON 1 WHERE NULL;
SELECT * FROM xy LEFT JOIN ab ON NULL WHERE NULL;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;
CREATE TABLE x1(a);
INSERT INTO x1 VALUES(1);
CREATE TABLE x2(b NOT NULL);
CREATE TABLE x3(c, d);
INSERT INTO x3 VALUES('a', NULL);
INSERT INTO x3 VALUES('b', NULL);
INSERT INTO x3 VALUES('c', NULL);
SELECT * FROM x1 LEFT JOIN x2 LEFT JOIN x3 ON x3.d = x2.b;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;
DROP TABLE IF EXISTS t4;
DROP TABLE IF EXISTS t5;
CREATE TABLE t1(x text NOT NULL, y text);
CREATE TABLE t2(u text NOT NULL, x text NOT NULL);
CREATE TABLE t3(w text NOT NULL, v text);
CREATE TABLE t4(w text NOT NULL, z text NOT NULL);
CREATE TABLE t5(z text NOT NULL, m text);
INSERT INTO t1 VALUES('f6d7661f-4efe-4c90-87b5-858e61cd178b',NULL);
INSERT INTO t1 VALUES('f6ea82c3-2cad-45ce-ae8f-3ddca4fb2f48',NULL);
INSERT INTO t1 VALUES('f6f47499-ecb4-474b-9a02-35be73c235e5',NULL);
INSERT INTO t1 VALUES('56f47499-ecb4-474b-9a02-35be73c235e5',NULL);
INSERT INTO t3 VALUES('007f2033-cb20-494c-b135-a1e4eb66130c',
                        'f6d7661f-4efe-4c90-87b5-858e61cd178b');
SELECT *
    FROM t3
         INNER JOIN t1 ON t1.x= t3.v AND t1.y IS NULL
         LEFT JOIN t4  ON t4.w = t3.w
         LEFT JOIN t5  ON t5.z = t4.z
         LEFT JOIN t2  ON t2.u = t5.m
         LEFT JOIN t1 xyz ON xyz.y = t2.x;
DROP TABLE IF EXISTS x1;
DROP TABLE IF EXISTS x2;
DROP TABLE IF EXISTS x3;
CREATE TABLE x1(a);
INSERT INTO x1 VALUES(1);
CREATE TABLE x2(b NOT NULL);
CREATE TABLE x3(c, d);
INSERT INTO x3 VALUES('a', NULL);
INSERT INTO x3 VALUES('b', NULL);
INSERT INTO x3 VALUES('c', NULL);
SELECT * FROM x1 LEFT JOIN x2 JOIN x3 WHERE x3.d = x2.b;
SELECT *
  FROM (
      SELECT 'apple' fruit
      UNION ALL SELECT 'banana'
  ) a
  JOIN (
      SELECT 'apple' fruit
      UNION ALL SELECT 'banana'
  ) b ON a.fruit=b.fruit
  LEFT JOIN (
      SELECT 1 isyellow
  ) c ON b.fruit='banana';
SELECT *
    FROM (SELECT 'apple' fruit UNION ALL SELECT 'banana')
         LEFT JOIN (SELECT 1) ON fruit='banana';
CREATE TABLE y1(x, y, z);
INSERT INTO y1 VALUES(0, 0, 1);
CREATE TABLE y2(a);
SELECT count(z) FROM y1 LEFT JOIN y2 ON x GROUP BY y;
SELECT count(z) FROM ( SELECT * FROM y1 ) LEFT JOIN y2 ON x GROUP BY y;
CREATE VIEW v1 AS SELECT x, y, z FROM y1;
SELECT count(z) FROM v1 LEFT JOIN y2 ON x GROUP BY y;
SELECT count(z) FROM ( SELECT * FROM y1 ) LEFT JOIN y2 ON x;
SELECT * FROM ( SELECT * FROM y1 ) LEFT JOIN y2 ON x;
INSERT INTO t1 VALUES(-2,-3),(+2,-3),(-2,+3),(+2,+3);
ANALYZE;
ANALYZE;
UPDATE sqlite_stat1 SET stat='1000000 10 1' WHERE idx='t3x';
ANALYZE sqlite_schema;
CREATE TABLE t0 (c0, c1, PRIMARY KEY (c0, c1));
INSERT INTO t0 VALUES(0, 10);
INSERT INTO t0 VALUES(1, 10);
INSERT INTO t0 VALUES(2, 10);
INSERT INTO t0 VALUES(3, 10);
INSERT INTO t1 VALUES(1,1);
ANALYZE sqlite_schema;
INSERT INTO sqlite_stat1 VALUES('t1','t1x1','648 324 81 81 81 81 81 81 81081 81 81 81');
ANALYZE sqlite_schema;
WITH RECURSIVE c(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM c WHERE x<20)
    INSERT INTO t1(x) SELECT 0 FROM c;
CREATE INDEX t1x1 ON t1(x BETWEEN 0 AND 10, x);
ANALYZE;
DELETE FROM t1;
CREATE VIEW v2 AS SELECT * FROM v1 NATURAL JOIN v1;
CREATE VIEW v3 AS SELECT * FROM v2, v1 USING (x) GROUP BY x;
SELECT x FROM v3;
ANALYZE;
DELETE FROM sqlite_stat1;
INSERT INTO sqlite_stat1(tbl,idx,stat) VALUES
    ('t1',NULL,150105),('t2',NULL,98747);
ANALYZE sqlite_schema;
ANALYZE;
