CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT);
INSERT INTO t1 VALUES(1), (2), (3), (4);
INSERT INTO t2 VALUES(1), (2);
CREATE TABLE t0 AS SELECT *FROM t1;
CREATE TABLE t3(a INT, b INT);
INSERT INTO t3 VALUES(1, 3), (2, 3);
SELECT * FROM t1 WHERE(SELECT a FROM t2 WHERE t2.a = t1.a) > 0;
SELECT * FROM t1 WHERE(SELECT b FROM t3 WHERE t3.a = t1.a) > 0;
SELECT * FROM t1 WHERE(SELECT ABS(a) FROM t2 WHERE t2.a = t1.a) > 0;
SELECT * FROM t2
WHERE(SELECT a FROM t3
      WHERE t3.a = t2.a AND
            t3.b = t2.a) > 0;
SELECT * FROM t3
WHERE(SELECT a FROM t2
      WHERE t2.a > t3.a) > 0;
SELECT * FROM t3
WHERE(SELECT a FROM t2
      WHERE t2.a != t3.a) > 0;
INSERT INTO t2 VALUES(NULL),(NULL);
INSERT INTO t3 VALUES(NULL, 3);
DELETE FROM t2 WHERE a IS NULL;
DELETE FROM t3 WHERE a IS NULL;
SELECT a,
       (SELECT SUM(a) + t3.b FROM t2) FROM t3;
SELECT a,
       (SELECT SUM(a) OVER w FROM t2 WINDOW w AS(ORDER BY t3.a) LIMIT 1)
FROM t3;
SELECT a FROM t2
 WHERE(SELECT SUM(b) FROM t3 GROUP BY a, t2.a LIMIT 1) > 0;
SELECT a FROM t2
WHERE (SELECT SUM(b) FROM t3 GROUP BY a HAVING SUM(b) > t2.a LIMIT 1) > 0;
SELECT a,
       (SELECT t2.a FROM t2 ORDER BY t1.a LIMIT 1)
FROM t1;
SELECT SUM(a),
       a, (SELECT MIN(a) FROM t2 WHERE a = COUNT(*))
FROM t1 GROUP BY a;
SELECT SUM(a),
       a, (SELECT MIN(a) FROM t2 WHERE a = AVG(t1.a))
FROM t1 GROUP BY a;
INSERT INTO t2 VALUES (2);
SELECT * FROM t1 WHERE (SELECT COUNT(a) FROM t2 WHERE t2.a = t1.a) > 0;
SELECT * FROM t1 WHERE (SELECT COUNT(a) FROM t3 WHERE t3.a = t1.a GROUP BY b) > 0;
create table p(p_pkey int primary key);
create table l(l_pkey int,
               l_quantity int);
insert into p values (10), (20), (30), (40);
insert into l values (10, 100),
                     (10, 10),
                     (20, 200),
                     (10, 1);
select * from l, p
where p_pkey = l_pkey and
      l_quantity < (select 0.9 * avg(l_quantity)
                    from l where l_pkey = p_pkey);
DROP TABLE p, l;
DROP TABLE t0, t1, t2, t3;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT, b INT);
INSERT INTO t1 VALUES (1), (2), (3), (4);
INSERT INTO t2 VALUES (1, 3), (2, 3);
SELECT * FROM t1 WHERE (SELECT a FROM t2
                        WHERE t2.a = t1.a
                        GROUP BY a, b HAVING t2.a > 10) > 0;
DROP TABLE t1, t2;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT, b INT, c INT);
INSERT INTO t1 VALUES (1), (2), (3), (4);
INSERT INTO t2 VALUES (1, 3, 3), (2, 3, 3);
DELETE FROM t2 WHERE a = 2;
SELECT * FROM t1 WHERE (SELECT b FROM t2 WHERE t2.b = t1.a and t2.c = t1.a GROUP BY b) > 0;
DROP TABLE t1, t2;
CREATE TABLE t1(a INT);
CREATE TABLE t3(a INT, b INT);
INSERT INTO t1 VALUES (1), (2), (3), (4);
INSERT INTO t3 VALUES (1, 3), (2, 3), (1, 4);
SELECT * FROM t1 WHERE (SELECT a FROM t3 WHERE t3.a = t1.a GROUP BY a) > 0;
DROP TABLE t1, t3;
CREATE TABLE t2 (a INT, b INT);
CREATE TABLE t4 (a INT NOT NULL, b INT NOT NULL);
INSERT INTO t2 VALUES (1, 7), (2, 7), (2,10);
INSERT INTO t4 VALUES (4, 8), (3, 8), (5, 9), (12, 7), (1, 7),
                      (10, 9), (9, 6), (7, 6), (3, 9), (1, 10);
SELECT b, MAX(a) AS ma FROM t4
GROUP BY b HAVING ma < (SELECT MAX(t2.a) FROM t2 WHERE t2.b=t4.b);
DROP TABLE t2, t4;
CREATE TABLE t1 (a INT PRIMARY KEY);
CREATE TABLE t2 (a INT PRIMARY KEY, b INT);
CREATE TABLE t3 (c INT);
INSERT INTO t1 (a) VALUES (1), (2);
INSERT INTO t2 (a,b) VALUES (1,2), (2,3);
INSERT INTO t3 (c) VALUES (1), (2);
SELECT (SELECT t1.a FROM t1, t2 WHERE t1.a = t2.b AND t2.a = t3.c ORDER BY t1.a) FROM t3;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (a INT, b INT, c INT DEFAULT 0);
INSERT INTO t1 (a, b) VALUES (3,3), (2,2), (3,3), (2,2), (3,3), (4,4);
CREATE TABLE t2 SELECT DISTINCT * FROM t1;
SELECT t1.a, SUM(t1.b)
FROM t1
WHERE t1.a = (SELECT t2.a
              FROM t2
              WHERE t2.a > (SELECT t1.b FROM DUAL) AND t1.a=t2.a)
GROUP BY t1.a ORDER BY t1.a LIMIT 30;
SELECT t1.a, SUM(t1.b)
FROM t1
WHERE t1.a = (SELECT t2.a
              FROM t2
              WHERE t2.a > (SELECT SUM(t1.b) FROM DUAL) AND t1.a=t2.a)
GROUP BY t1.a ORDER BY t1.a LIMIT 30;
SELECT t1.a, SUM(t1.b)
FROM t1
WHERE t1.a = (SELECT SUM(t2.b)
              FROM t2
              WHERE t2.a > 4 ORDER BY t1.b)
GROUP BY t1.a ORDER BY t1.a LIMIT 30;
DROP TABLES t1, t2;
CREATE TABLE t1 (
  id INTEGER NOT NULL ,
  contract_id INTEGER DEFAULT NULL,
  datestamp DATETIME DEFAULT NULL,
  PRIMARY KEY (id),
  KEY contract_id (contract_id),
  KEY idx_datestamp (datestamp)
);
INSERT INTO t1 VALUES
       (1,2,'2006-09-18 09:07:53'), (2,3,'2006-09-18 09:07:53'),
       (3,4,'2006-09-18 09:07:53'), (4,10,'2006-09-18 09:07:53'),
       (5,7,'2006-09-18 09:07:53'), (6,5,'2006-09-18 09:07:53'),
       (7,9,'2006-09-18 09:07:53'), (8,10,'2006-09-18 09:07:53'),
       (9,10,'2006-09-18 09:07:53'), (10,6,'2014-09-18 09:07:53');
CREATE TABLE t2 (id INTEGER NOT NULL, PRIMARY KEY (id));
INSERT INTO t2 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
SELECT (SELECT datestamp
        FROM t1
        WHERE contract_id = t2.id
        ORDER BY datestamp ASC
        LIMIT 1)
FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t1(a INT, b INT DEFAULT 0);
INSERT INTO t1(a) VALUES (1), (2);
CREATE TABLE t2 SELECT * FROM t1;
SELECT (SELECT dt.a
        FROM   (SELECT 1 AS a, t2.a AS b
                FROM t2
                HAVING t1.a) dt     # <----- outer reference inside derived table.
        WHERE dt.b=t1.a) AS subq    # <----- normal outer reference
FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t_a (a INT, b INT);
INSERT INTO t_a VALUES (4, 40), (1, 10), (2, 20), (2, 20), (3, 30);
CREATE TABLE t_b SELECT DISTINCT a FROM t_a;
SELECT (SELECT SUM(t_b.a) OVER ()
        FROM t_b
        WHERE t_b.a = t_a.a) aa,
       b
FROM t_a
GROUP BY aa, b;
DROP TABLE t_a, t_b;
CREATE TABLE t1 (id INT);
CREATE TABLE t2 (id INT);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1);
SELECT t1.id, ( SELECT COUNT(t.id)
                FROM t2 AS t
                WHERE t.id = t1.id ) AS c FROM t1;
SELECT t1.id, ( SELECT COUNT(t.id)+2
                FROM t2 AS t
                WHERE t.id = t1.id ) AS c FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t1 (a INT, b INT);
SELECT COUNT(*)
FROM t1 a JOIN
     t1 outr
     ON a.a = (SELECT COUNT(*) FROM t1 inr WHERE inr.a = outr.a);
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER, f2 INTEGER);
INSERT INTO t1 VALUES (1,2);
CREATE TABLE t2 LIKE t1;
INSERT INTO t2 SELECT * FROM t1;
SELECT (SELECT COUNT(t2.f1) FROM (t2) WHERE t2.f2 <> table1.f1
 AND t2.f2 != table1.f1) AS dt FROM (SELECT * FROM t1 ) AS table1;
DROP TABLE t1,t2;
CREATE TABLE t1 (f1 INTEGER, f2 INTEGER);
INSERT INTO t1 VALUES (1,2);
CREATE ALGORITHM=MERGE VIEW view_merge AS
SELECT (SELECT MAX(t1.f1) AS dt_f1 FROM (t1)
        WHERE t1.f2 > table1.f2 OR t1.f2 != 2)
  FROM (SELECT * FROM t1)  AS table1;
SELECT * FROM view_merge;
DROP TABLE t1;
DROP VIEW view_merge;
CREATE TABLE t1 (f1 INTEGER, f2 INTEGER, f3 INTEGER,
                 PRIMARY KEY(f1), KEY(f2));
SELECT f1, (SELECT SUM(t2.f2) FROM (t1 as t2)
            WHERE t2.f3 = t1.f3 AND t2.f1 < t1.f1) AS dt
  FROM t1 WHERE f2 =3 GROUP BY f1;
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER, f2 VARCHAR(1), f3 VARCHAR(1), PRIMARY KEY(f1));
SELECT (SELECT MIN(t1.f1) FROM t1
        WHERE t1.f3 > t2.f3 OR t1.f3 = t2.f3)
FROM (( SELECT * FROM t1) AS t2 RIGHT JOIN t1 ON 1);
DROP TABLE t1;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT, b INT);
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM t2;
INSERT INTO t1 VALUES(1), (2), (3), (4);
INSERT INTO t2 VALUES(1, 3), (2, 3);
SELECT * FROM v1 WHERE(SELECT b FROM v2 WHERE v2.a = v1.a) > 0;
DROP TABLE t1,t2;
DROP VIEW v1,v2;
CREATE TABLE t1 (f1 INTEGER, f2 INTEGER, f3 INTEGER,
                 f4 VARCHAR(1), PRIMARY KEY(f1));
CREATE VIEW v1 AS SELECT * FROM t1;
DROP TABLE t1;
DROP VIEW v1;
CREATE TABLE t1 (f1 INTEGER , f2 INTEGER);
INSERT INTO t1 VALUES (1,1), (2,2), (3,3);
SELECT /*+ SET_VAR(optimizer_switch='subquery_to_derived=OFF') */ *
FROM t1 WHERE ( SELECT COUNT(dt.f1) FROM t1 AS dt WHERE dt.f2 > t1.f2);
SELECT * FROM t1 WHERE ( SELECT COUNT(dt.f1) FROM t1 AS dt WHERE dt.f2 > t1.f2);
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER, f2 VARCHAR(1) , f3 VARCHAR(1), PRIMARY KEY(f1));
SELECT /*+ SET_VAR(optimizer_switch='subquery_to_derived=OFF') */
  (SELECT MAX(dt.f1) AS max FROM t1 AS dt
   WHERE dt.f2 = dt1.f2 AND dt.f3 > 'h' ) AS field1
 FROM (t1 AS dt1, t1 AS dt2) GROUP BY field1;
SELECT
  (SELECT MAX(dt.f1) AS max FROM t1 AS dt
   WHERE dt.f2 = dt1.f2 AND dt.f3 > 'h' ) AS field1
 FROM (t1 AS dt1, t1 AS dt2) GROUP BY field1;
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER, f2 INTEGER, f3 VARCHAR(1), PRIMARY KEY(f1));
CREATE VIEW view_t1 AS SELECT * FROM t1;
DROP TABLE t1;
DROP view view_t1;
CREATE TABLE t1 ( f1 INTEGER, f2 INTEGER, f3 INTEGER, f4 INTEGER);
SELECT f1 FROM t1 AS table1
 WHERE f2 <> (SELECT f1 FROM t1 WHERE table1.f3 = (SELECT f4 FROM t1));
INSERT INTO t1 VALUES (-1, 0, -1, -1);
INSERT INTO t1 VALUES (1, 0, 1, 1);
DROP TABLE t1;
CREATE TABLE t1(a INTEGER, b INTEGER);
CREATE TABLE t2(a INTEGER, b INTEGER);
INSERT INTO t1 VALUES(5, 5);
INSERT INTO t2 VALUES(1,4),(2,3);
DROP TABLE t1,t2;
CREATE TABLE t1 (f1 INTEGER NOT NULL, f2 INTEGER);
DROP TABLE t1;
CREATE TABLE t1 (a INTEGER);
CREATE TABLE t2 (b INTEGER);
SELECT 1 FROM t1 WHERE ( SELECT DISTINCT b FROM t2 WHERE t1.a = t1.a );
DROP TABLE t1,t2;
CREATE TABLE t1 (a INTEGER, b INTEGER);
CREATE TABLE t2 (a INTEGER);
INSERT INTO t1 VALUES (1,1), (1,2), (1,3), (1,3);
INSERT INTO t2 VALUES (1), (2);
SELECT a
FROM t2 WHERE 1 = (SELECT t1.a FROM t1 WHERE t1.b = t2.a);
SELECT /*+ JOIN_SUFFIX (t2) */ a
FROM t2 WHERE 1 = (SELECT t1.a FROM t1 WHERE t1.b = t2.a);
DROP TABLE t1,t2;
CREATE TABLE t1(b BOOL);
SELECT *
  FROM t1 AS alias1
  WHERE ( SELECT COUNT(t1.b)
          FROM t1
          WHERE EXISTS ( SELECT SUM( t1.b )
                         FROM t1
                         WHERE alias1.b
                       )
                AND alias1.b
         );
DROP TABLE t1;
CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT);
INSERT INTO t1 VALUES(1), (2), (3), (4);
INSERT INTO t2 VALUES(1), (2);
SELECT * FROM t1 WHERE (SELECT t2.a FROM t2 WHERE t2.a = t1.a AND t2.a = t1.a);
DROP TABLE t1, t2;
create table t2(a int, b int);
create table t1(a int, b int);
insert into t1 values (1, 1);
insert into t2 values (2,1),(2,-1);
SELECT * FROM t1 WHERE ( SELECT a FROM t2 WHERE t2.a = t1.a + t2.b ) > 0;
SELECT * FROM t1 WHERE ( SELECT a FROM t2 WHERE t2.a = t1.a + 3 ) > 0;
DROP TABLE t1, t2;
