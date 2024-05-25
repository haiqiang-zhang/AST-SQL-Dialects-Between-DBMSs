select json_extract(trace,"$.steps[*].join_optimization.steps[*].refine_plan") from information_schema.optimizer_trace;
create table t1(a int, b int);
insert into t1 (a) values(1),(2);
create table t2 select * from t1;
select * from t1 where
 (select count(*) from (select * from (select * from t1 t2
    where 2=(select 2 from (select t1.a) dt1))dt3)dt4);
select * from t1 where
 (select count(*) from (select * from (select * from t1 t2
    where 2=(select 2 from (select 42) dt1))dt3)dt4);
select
(select dt.a from
  (select t1.a as a, t2.a as b from t2) dt where dt.b=t1.a)
as subq
from t1;
select
(select dt.b from
  (select t2.a as b from t2 where t1.a=t2.a) dt)
as subq
from t1;
select
(select dt.b from
  (select sum(t2.a) as b from t2 group by t1.a) dt)
as subq
from t1;
select
(select dt.b from
  (select sum(t2.a) as b from t2 having t1.a=sum(t2.a)-1) dt)
as subq
from t1;
select
(select dt.b from
  (select sum(t2.a) as b from t2 having t1.a=sum(t2.a)-2) dt)
as subq
from t1;
select
(select dt.b from
  (select t2.a as b from t2 order by if(t1.a=1,t2.a,-t2.a) limit 1) dt)
as subq
from t1;
select
(select dt.b from
  (select t2.a, sum(t1.a*10+t2.a) over (order by if(t1.a=1,t2.a,-t2.a)) as b
   from t2) dt where dt.a=1)
as subq
from t1;
select
(with dt as (select t1.a as a, t2.a as b from t2)
 select dt2.a from dt dt1, dt dt2 where dt1.b=t1.a and dt2.b=dt1.b)
as subq
from t1;
select
  (with recursive dt as
    (select t1.a as a union select a+1 from dt where a<10)
   select dt1.a from dt dt1 where dt1.a=t1.a
  ) as subq
from t1;
select
  (with recursive dt as
    (select t1.a as a union select a+1 from dt where a<10)
   select concat(count(*), ' - ', avg(dt.a)) from dt
  ) as subq
from t1;
select
  (with recursive dt as
    (select t1.a as a union all select a+1 from dt where a<10)
   select concat(count(*), ' - ', avg(dt.a)) from dt
  ) as subq
from t1;
select
(with dt as (select t1.a as a, t2.a as b from t2)
 select dt2.a from dt dt1, dt dt2 where dt1.b=t1.a and dt2.b=dt1.b)
as subq
from t1;
select (with dt as (select t1.a as a from t2 limit 1) select * from dt dt1 where dt1.a=(select * from dt as dt2)) as subq from t1;
select (with dt as (select t2.a as a from t2 having t1.a=t2.a limit 1) select * from dt dt1 where dt1.a=(select * from dt as dt2)) as subq from t1;
select (select * from (select t1.a) cte) from t1;
select (with cte as (select t1.a) select * from cte) from t1;
select * from t1
where a not in (select dt.f+1 from (select t2.a as f from t2) dt);
select * from t1
where a not in (select dt.f+1 from (select 0*t1.a+t2.a as f from t2) dt);
create table t11 (a int);
insert into t11
 with recursive cte as (select 1 as a union all select a+1 from cte where a<124)
 select * from cte;
alter table t11 add index(a);
create table t12 like t11;
DROP TABLE t11,t12;
select t1.a, dt.a from t1, lateral (select t1.a+t2.a as a from t2) dt;
select t1.a, dt.a from t1, lateral (select t2.a as a from t2 having t1.a) dt;
create view v1 as
 select t1.a as f1, dt.a as f2
 from t1, lateral (select t1.a+t2.a as a from t2) dt;
select * from v1;
drop view v1;
SELECT COUNT(*) FROM t1 GROUP BY t1.a  HAVING t1.a IN (SELECT t3.a
FROM t1 AS t3 WHERE t3.b IN (SELECT b FROM t2, lateral (select t1.a) dt));
create view v1 as select a, b from t1;
select vq1.b,dt.b from v1 vq1, lateral (select vq1.b) dt;
select b from v1 vq1, lateral (select count(*) from v1 vq2 having vq1.b = 3) dt;
drop view v1;
SELECT

* FROM t1 AS ta, lateral (select 1 WHERE ta.a IN (SELECT b FROM t2 AS tb                WHERE tb.b >= SOME(SELECT SUM(tc.a) as sg FROM t1 as tc                                   GROUP BY tc.b                                   HAVING ta.a=tc.b))) dt;
select (select dt.a from   (select 1 as a, t2.a as b from t2 having
t1.a) dt where dt.b=t1.a) as subq from t1;
select (select dt.a from   (select 1 as a, 3 as b from t2 having t1.a)
dt where dt.b=t1.a) as subq from t1;
select (select f from (select max(t1.a) as f) as dt) as g from t1;
select (select f from lateral (select max(t1.a) as f) as dt) as g from t1;
select t1.a, f from t1, lateral (select max(t1.a) as f) as dt;
select * from t1,
lateral (with qn as (select t1.a) select (select max(a) from qn)) as dt;
select (select * from (select * from (select t1.a from t2) as dt limit 1) dt2) from t1;
select a from t1 where a in (select a from (select t1.a) dt);
create table t3 as with recursive cte as (select 1 as a union select a+1 from cte where a<20) select * from cte;
select min(a),max(a) from t3 where a in (select /*+ no_merge() */ a from (select t3.a from t1) dt);
drop table t3;
select * from t1, lateral (select * from (select * from (select t1.a from t2) as dt limit 1) dt2) dt3;
select * from t1 as t0,
lateral
(select dt3.* from t1, lateral (select * from (select * from (select t0.a
from t2) as dt limit 1) dt2) dt3) dt4;
select /*+ no_merge() */ * from t1 as t0,
lateral
(select dt3.* from t1, lateral (select * from (select * from (select t0.a
from t2) as dt limit 1) dt2) dt3) dt4;
select * from t1, lateral (select * from (select 42) t1, (select t1.a) dt2) dt3;
select a from t1 where a in (select /*+ no_semijoin() */ a from (select t1.a) dt);
select a from t1 where a in (with cte as (select t1.a)
                             select /*+ no_semijoin() */ a from cte);
select straight_join * from t1, t2, lateral (select t1.a) as dt;
select straight_join * from t1, lateral (select t1.a) as dt, t2;
select straight_join * from t2, t1, lateral (select t1.a) as dt;
select * from t1, t2, lateral (select t1.a) as dt;
select * from t1, lateral (select t1.a) as dt, t2;
select * from t2, t1, lateral (select t1.a) as dt;
select * from t1, lateral (select t1.a from t2 as t3, t2 as t4) as dt, t2;
select trace from information_schema.optimizer_trace;
create table t3(a int) engine=innodb;
insert into t3 values(3);
select * from t3, lateral (select t3.a+1) as dt;
drop table t3;
select * from t2, t1, lateral (select t1.a) as dt,
                      lateral (select t2.a) as dt2;
select * from t2, t1, lateral (select t1.a) as dt,
                      lateral (select t1.a+1) as dt2;
select * from t2, t1, lateral (select t1.a+t2.a) as dt;
CREATE TABLE t11 (t11a int, t11b int);
INSERT INTO t11 VALUES (99, NULL),(99, 3),(99,0);
CREATE TABLE t12 (t12a int, t12b int, KEY idx (t12b));
INSERT INTO t12 VALUES (100,0),(150,200),(999, 0),(999, NULL);
SELECT * FROM t11 LEFT JOIN t12 force index (idx) ON t12.t12b = t11.t11b
JOIN LATERAL (SELECT t12a) dt;
DROP TABLE t11,t12;
create table t3 (a int, b int);
insert into t3 values(1, 10), (1, 11), (2, 10), (2, 11);
select * from t1, lateral (select t3.b from t3 where t3.a=t1.a) dt
 where dt.b=t1.a+9;
drop table t3;
drop table t1,t2;
CREATE TABLE t(x INT);
DROP TABLE t;
CREATE TABLE bb (
pk INTEGER AUTO_INCREMENT,
col_int INTEGER ,
col_int_key INTEGER ,
col_time_key TIME ,
col_time TIME ,
col_datetime_key DATETIME ,
col_datetime DATETIME ,
col_varchar_key VARCHAR(20) ,
col_varchar VARCHAR(20) ,
PRIMARY KEY (pk DESC),
KEY (col_time_key),
KEY (col_time_key DESC)
);
DROP TABLE bb;
CREATE TABLE t1 (
  f1 integer
);
INSERT INTO t1 VALUES (0),(1);
CREATE TABLE t2 (
  f2 integer
);
SELECT * FROM t1, LATERAL ( SELECT MAX(1) FROM t2 GROUP BY t1.f1 ) AS l1;
DROP TABLE t1, t2;
CREATE TABLE t1 ( f1 INTEGER );
CREATE TABLE t2 ( f2 LONGBLOB );
INSERT INTO t1 VALUES (1);
INSERT INTO t2 VALUES ('abc'),('def');
SELECT STD(0) FROM t2, LATERAL ( SELECT f1 FROM t1 GROUP BY f2,f1 ) AS d1;
DROP TABLE t1, t2;
CREATE TABLE t1 (
 pk INTEGER,
 col_int INT not null,
 col_int_key INT not null,
 col_time_gckey TIME,
 col_varchar VARCHAR(20) not null,
 col_varchar_key VARCHAR(15)  not null
);
CREATE TABLE t2 (
 pk INTEGER,
 col_int INT not null,
 col_varchar VARCHAR(20) not null,
 col_varchar_key VARCHAR(15) not null
);
SELECT table1.col_varchar_key AS field1,
       table2.col_time_gckey AS field2
FROM t2 AS table1 STRAIGHT_JOIN t1 AS table2
     ON table2.col_varchar_key = table1.col_varchar_key
WHERE table2.col_int_key IN
   (WITH qn AS
    (SELECT sq1_t1.col_int AS sq1_field1
     FROM t2 AS sq1_t1
     WHERE sq1_t1.col_varchar_key = table2.col_varchar OR
           EXISTS (WITH qn1 AS
                   (SELECT c_sq1_t1.col_int_key AS c_sq1_field1
                    FROM t1 AS c_sq1_t1
                    WHERE c_sq1_t1.col_varchar_key > sq1_t1.col_varchar OR
                          c_sq1_t1.col_int <> c_sq1_t1.pk
                   )
                   SELECT * FROM qn1
                  )
    )
    SELECT * FROM qn
   ) AND
   EXISTS (WITH qn AS
           (SELECT sq2_t1.col_varchar AS sq2_field1
            FROM t1 AS sq2_t1 STRAIGHT_JOIN
                   t2 AS sq2_t2 INNER JOIN t1 AS sq2_t3
                   ON sq2_t3.col_varchar = sq2_t2.col_varchar_key
                 ON sq2_t3.col_int = sq2_t2.pk
           )
           SELECT * FROM qn
          ) AND
      table2.col_varchar_key <> 'j';
DROP TABLE t1,t2;
CREATE TABLE t1 (
pk INTEGER, col_int_key INTEGER NOT NULL,
col_date_key DATE NOT NULL, col_datetime DATETIME NOT NULL
);
INSERT INTO t1 VALUES (0, 0, '2006-07-18', '2001-09-06 02:13:59.021506');
SELECT /*+ no_merge() */  outr.pk AS x
FROM ( SELECT * FROM  t1  ) AS  outr
WHERE outr.col_int_key  IN
( SELECT /*+ no_merge() no_semijoin() */ 2
  FROM (SELECT 1 AS x FROM t1 AS  innr WHERE outr.col_date_key ) AS
  qn )
ORDER BY outr.col_datetime;
SELECT /*+ no_merge() */  outr.pk AS x
FROM ( SELECT * FROM  t1  ) AS  outr
WHERE outr.col_int_key  IN
( SELECT /*+ no_merge() no_semijoin() */ id
  FROM JSON_TABLE( IF(outr.col_date_key<>NOW(),
                      '[{"a":"3"},{"a":2},{"b":1},{"a":0}]',
                      '') ,
                   '$[*]' columns (id for ordinality,
                                   jpath varchar(100) path '$.a',
                                   jexst int exists path '$.b')   ) AS
                                   qn )
ORDER BY outr.col_datetime;
DROP TABLE t1;
CREATE TABLE t1(pk INT PRIMARY KEY, a INT);
DROP TABLE t1;
CREATE TABLE t0007 (
  c0008 date NOT NULL,
  c0009 char(234) NOT NULL
);
CREATE TABLE t0008 (
  c0005 tinytext NOT NULL
);
CREATE TABLE t0009 (
  c0000 time NOT NULL
);
SELECT (SELECT c0009
        FROM (SELECT 1 AS c0003
              FROM t0009 INNER JOIN t0008
                   ON t0008.c0005
              WHERE t0007.c0008
             ) AS t0005
        GROUP BY c0008
       ),
       COUNT(c0009)
FROM t0007
GROUP BY 1, 1;
DROP TABLE t0007, t0008, t0009;
CREATE TABLE t1 (id INTEGER);
CREATE TABLE t2 (id INTEGER);
INSERT INTO t1 VALUES (10), (20), (30);
INSERT INTO t2 VALUES (20), (20);
SELECT * FROM t1 JOIN LATERAL (
  SELECT GROUP_CONCAT(t.id) AS c FROM t2 t WHERE (t.id = t1.id)
) d0 ON (1);
DROP TABLE t1, t2;
CREATE TABLE t1 ( f1 INTEGER NOT NULL, f2 INTEGER NOT NULL );
CREATE TABLE t2 ( f1 INTEGER NOT NULL, f2 INTEGER NOT NULL );
CREATE ALGORITHM=TEMPTABLE VIEW v1 AS SELECT * FROM t1;
CREATE ALGORITHM=TEMPTABLE VIEW v2 AS SELECT ( SELECT f2 FROM v1 WHERE v1.f1 = t2.f1 ) AS f3 FROM t2;
DROP TABLE t1, t2;
DROP VIEW v1, v2;
CREATE TABLE t1(
a INT,
b INT NOT NULL,
c INT NOT NULL,
d INT,
UNIQUE KEY (c,b)
);
INSERT INTO t1 VALUES (1,1,1,50), (1,2,3,40), (2,1,3,4);
CREATE TABLE t2(
a INT,
b INT,
UNIQUE KEY(a,b)
);
INSERT INTO t2 VALUES (NULL, NULL), (NULL, NULL), (NULL, 1), (1, NULL), (1, 1), (1,2);
SELECT * FROM t1 JOIN LATERAL (SELECT a+t1.a from t2 GROUP BY a) AS dt;
DROP TABLE t1, t2;
CREATE TABLE t1 (c1 VARCHAR(1));
CREATE VIEW v1 AS SELECT * FROM t1;
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t1 ( id INTEGER );
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 ( table_id integer );
INSERT INTO t2 VALUES (363);
CREATE TABLE t3 ( id integer );
INSERT INTO t3 VALUES (362);
INSERT INTO t3 VALUES (363);
SELECT *
  FROM t1
  LEFT JOIN (
    t3, LATERAL (
      SELECT * FROM t2 WHERE table_id = t3.id
    ) l1
  ) ON TRUE;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 ( a INTEGER );
SELECT *
  FROM
    t1
    LEFT JOIN (
      t1 AS t2
      LEFT JOIN t1 AS t3 ON TRUE
    ) ON TRUE,
    LATERAL (
      SELECT SUM(t1.a), t2.a FROM t1
    ) AS d1;
DROP TABLE t1;
CREATE TABLE t1(id int NOT NULL);
INSERT into t1 VALUES (364), (365);
CREATE TABLE t2 (id int NOT NULL);
INSERT into t2 VALUES (365);
SELECT * FROM t1 AS tbl1
       LEFT JOIN t1 AS tbl3 ON FALSE WHERE tbl1.id NOT IN
            (SELECT id FROM t1 AS tbl2 JOIN LATERAL
                    (SELECT 1 FROM t2 WHERE id = tbl2.id LIMIT 10) AS d1);
SELECT /*+ JOIN_PREFIX(tbl1, tbl2) */ * FROM t1 AS tbl1
       LEFT JOIN t1 AS tbl3 ON FALSE WHERE tbl1.id NOT IN
            (SELECT id FROM t1 AS tbl2 JOIN LATERAL
                    (SELECT 1 FROM t2 WHERE id = tbl2.id LIMIT 10) AS d1);
DROP TABLE t1, t2;
CREATE TABLE t(x INT, b BLOB);
INSERT INTO t VALUES (0, 'zero'), (1, 'one'), (2, 'two');
SELECT t3.b
FROM
  t AS t1,
  t AS t2,
  LATERAL (SELECT DISTINCT * FROM t WHERE t2.x <> 0) AS t3
WHERE t1.x = t2.x AND t2.x = t3.x ORDER BY t3.x;
DROP TABLE t;
