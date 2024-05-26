CREATE TABLE J1_TBL (
  i integer,
  j integer,
  t text
);
CREATE TABLE J2_TBL (
  i integer,
  k integer
);
INSERT INTO J1_TBL VALUES (1, 4, 'one');
INSERT INTO J1_TBL VALUES (2, 3, 'two');
INSERT INTO J1_TBL VALUES (3, 2, 'three');
INSERT INTO J1_TBL VALUES (4, 1, 'four');
INSERT INTO J1_TBL VALUES (5, 0, 'five');
INSERT INTO J1_TBL VALUES (6, 6, 'six');
INSERT INTO J1_TBL VALUES (7, 7, 'seven');
INSERT INTO J1_TBL VALUES (8, 8, 'eight');
INSERT INTO J1_TBL VALUES (0, NULL, 'zero');
INSERT INTO J1_TBL VALUES (NULL, NULL, 'null');
INSERT INTO J1_TBL VALUES (NULL, 0, 'zero');
INSERT INTO J2_TBL VALUES (1, -1);
INSERT INTO J2_TBL VALUES (2, 2);
INSERT INTO J2_TBL VALUES (3, -3);
INSERT INTO J2_TBL VALUES (2, 4);
INSERT INTO J2_TBL VALUES (5, -5);
INSERT INTO J2_TBL VALUES (5, -5);
INSERT INTO J2_TBL VALUES (0, NULL);
INSERT INTO J2_TBL VALUES (NULL, NULL);
INSERT INTO J2_TBL VALUES (NULL, 0);
create temp table onerow();
insert into onerow default values;
analyze onerow;
SELECT *
  FROM J1_TBL AS tx;
SELECT *
  FROM J1_TBL tx;
SELECT *
  FROM J1_TBL AS t1 (a, b, c);
SELECT *
  FROM J1_TBL t1 (a, b, c);
SELECT *
  FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e);
SELECT *
  FROM J1_TBL CROSS JOIN J2_TBL;
SELECT t1.i, k, t
  FROM J1_TBL t1 CROSS JOIN J2_TBL t2;
SELECT ii, tt, kk
  FROM (J1_TBL CROSS JOIN J2_TBL)
    AS tx (ii, jj, tt, ii2, kk);
SELECT tx.ii, tx.jj, tx.kk
  FROM (J1_TBL t1 (a, b, c) CROSS JOIN J2_TBL t2 (d, e))
    AS tx (ii, jj, tt, ii2, kk);
SELECT *
  FROM J1_TBL CROSS JOIN J2_TBL a CROSS JOIN J2_TBL b;
SELECT *
  FROM J1_TBL INNER JOIN J2_TBL USING (i);
SELECT *
  FROM J1_TBL JOIN J2_TBL USING (i);
SELECT * FROM J1_TBL JOIN J2_TBL USING (i) WHERE J1_TBL.t = 'one';
SELECT * FROM J1_TBL JOIN J2_TBL USING (i) AS x WHERE J1_TBL.t = 'one';
SELECT * FROM J1_TBL JOIN J2_TBL USING (i) AS x WHERE x.i = 1;
SELECT x.* FROM J1_TBL JOIN J2_TBL USING (i) AS x WHERE J1_TBL.t = 'one';
SELECT ROW(x.*) FROM J1_TBL JOIN J2_TBL USING (i) AS x WHERE J1_TBL.t = 'one';
SELECT row_to_json(x.*) FROM J1_TBL JOIN J2_TBL USING (i) AS x WHERE J1_TBL.t = 'one';
SELECT *
  FROM J1_TBL NATURAL JOIN J2_TBL;
SELECT *
  FROM J1_TBL JOIN J2_TBL ON (J1_TBL.i = J2_TBL.i);
SELECT *
  FROM J1_TBL JOIN J2_TBL ON (J1_TBL.i = J2_TBL.k);
SELECT *
  FROM J1_TBL JOIN J2_TBL ON (J1_TBL.i <= J2_TBL.k);
SELECT *
  FROM J1_TBL LEFT OUTER JOIN J2_TBL USING (i)
  ORDER BY i, k, t;
SELECT *
  FROM J1_TBL LEFT JOIN J2_TBL USING (i)
  ORDER BY i, k, t;
SELECT *
  FROM J1_TBL RIGHT OUTER JOIN J2_TBL USING (i);
SELECT *
  FROM J1_TBL RIGHT JOIN J2_TBL USING (i);
SELECT *
  FROM J1_TBL FULL OUTER JOIN J2_TBL USING (i)
  ORDER BY i, k, t;
SELECT *
  FROM J1_TBL FULL JOIN J2_TBL USING (i)
  ORDER BY i, k, t;
SELECT *
  FROM J1_TBL LEFT JOIN J2_TBL USING (i) WHERE (k = 1);
SELECT *
  FROM J1_TBL LEFT JOIN J2_TBL USING (i) WHERE (i = 1);
CREATE TABLE t1 (name TEXT, n INTEGER);
CREATE TABLE t2 (name TEXT, n INTEGER);
CREATE TABLE t3 (name TEXT, n INTEGER);
INSERT INTO t1 VALUES ( 'bb', 11 );
INSERT INTO t2 VALUES ( 'bb', 12 );
INSERT INTO t2 VALUES ( 'cc', 22 );
INSERT INTO t2 VALUES ( 'ee', 42 );
INSERT INTO t3 VALUES ( 'bb', 13 );
INSERT INTO t3 VALUES ( 'cc', 23 );
INSERT INTO t3 VALUES ( 'dd', 33 );
SELECT * FROM t1 FULL JOIN t2 USING (name) FULL JOIN t3 USING (name);
SELECT * FROM
(SELECT * FROM t2) as s2
INNER JOIN
(SELECT * FROM t3) s3
USING (name);
SELECT * FROM
(SELECT * FROM t2) as s2
LEFT JOIN
(SELECT * FROM t3) s3
USING (name);
SELECT * FROM
(SELECT * FROM t2) as s2
FULL JOIN
(SELECT * FROM t3) s3
USING (name);
SELECT * FROM
(SELECT name, n as s2_n, 2 as s2_2 FROM t2) as s2
NATURAL INNER JOIN
(SELECT name, n as s3_n, 3 as s3_2 FROM t3) s3;
SELECT * FROM
(SELECT name, n as s2_n, 2 as s2_2 FROM t2) as s2
NATURAL LEFT JOIN
(SELECT name, n as s3_n, 3 as s3_2 FROM t3) s3;
SELECT * FROM
(SELECT name, n as s2_n, 2 as s2_2 FROM t2) as s2
NATURAL FULL JOIN
(SELECT name, n as s3_n, 3 as s3_2 FROM t3) s3;
SELECT * FROM
(SELECT name, n as s1_n, 1 as s1_1 FROM t1) as s1
NATURAL INNER JOIN
(SELECT name, n as s2_n, 2 as s2_2 FROM t2) as s2
NATURAL INNER JOIN
(SELECT name, n as s3_n, 3 as s3_2 FROM t3) s3;
SELECT * FROM
(SELECT name, n as s1_n, 1 as s1_1 FROM t1) as s1
NATURAL FULL JOIN
(SELECT name, n as s2_n, 2 as s2_2 FROM t2) as s2
NATURAL FULL JOIN
(SELECT name, n as s3_n, 3 as s3_2 FROM t3) s3;
SELECT * FROM
(SELECT name, n as s1_n FROM t1) as s1
NATURAL FULL JOIN
  (SELECT * FROM
    (SELECT name, n as s2_n FROM t2) as s2
    NATURAL FULL JOIN
    (SELECT name, n as s3_n FROM t3) as s3
  ) ss2;
SELECT * FROM
(SELECT name, n as s1_n FROM t1) as s1
NATURAL FULL JOIN
  (SELECT * FROM
    (SELECT name, n as s2_n, 2 as s2_2 FROM t2) as s2
    NATURAL FULL JOIN
    (SELECT name, n as s3_n FROM t3) as s3
  ) ss2;
SELECT * FROM
  (SELECT name, n as s1_n FROM t1) as s1
FULL JOIN
  (SELECT name, 2 as s2_n FROM t2) as s2
ON (s1_n = s2_n);
create temp table x (x1 int, x2 int);
insert into x values (1,11);
insert into x values (2,22);
insert into x values (3,null);
insert into x values (4,44);
insert into x values (5,null);
create temp table y (y1 int, y2 int);
insert into y values (1,111);
insert into y values (2,222);
insert into y values (3,333);
insert into y values (4,null);
select * from x;
select * from y;
select * from x left join y on (x1 = y1 and x2 is not null);
select * from x left join y on (x1 = y1 and y2 is not null);
select * from (x left join y on (x1 = y1)) left join x xx(xx1,xx2)
on (x1 = xx1);
begin;
set geqo = on;
set geqo_threshold = 2;
rollback;
explain (costs off)
select * from
  j1_tbl full join
  (select * from j2_tbl order by j2_tbl.i desc, j2_tbl.k asc) j2_tbl
  on j1_tbl.i = j2_tbl.i and j1_tbl.i = j2_tbl.k;
select * from
  j1_tbl full join
  (select * from j2_tbl order by j2_tbl.i desc, j2_tbl.k asc) j2_tbl
  on j1_tbl.i = j2_tbl.i and j1_tbl.i = j2_tbl.k;
set enable_hashjoin = 0;
set enable_nestloop = 0;
set enable_hashagg = 0;
reset enable_hashagg;
reset enable_nestloop;
reset enable_hashjoin;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE J1_TBL;
DROP TABLE J2_TBL;
CREATE TEMP TABLE t1 (a int, b int);
CREATE TEMP TABLE t2 (a int, b int);
CREATE TEMP TABLE t3 (x int, y int);
INSERT INTO t1 VALUES (5, 10);
INSERT INTO t1 VALUES (15, 20);
INSERT INTO t1 VALUES (100, 100);
INSERT INTO t1 VALUES (200, 1000);
INSERT INTO t2 VALUES (200, 2000);
INSERT INTO t3 VALUES (5, 20);
INSERT INTO t3 VALUES (6, 7);
INSERT INTO t3 VALUES (7, 8);
INSERT INTO t3 VALUES (500, 100);
DELETE FROM t3 USING t1 table1 WHERE t3.x = table1.a;
SELECT * FROM t3;
DELETE FROM t3 USING t1 JOIN t2 USING (a) WHERE t3.x > t1.a;
SELECT * FROM t3;
DELETE FROM t3 USING t3 t3_other WHERE t3.x = t3_other.x AND t3.y = t3_other.y;
SELECT * FROM t3;
create temp table t2a () inherits (t2);
insert into t2a values (200, 2001);
select * from t1 left join t2 on (t1.a = t2.a);
select t1.*, t2.*, unnamed_join.* from
  t1 join t2 on (t1.a = t2.a), t3 as unnamed_join
  for update of unnamed_join;
select foo.*, unnamed_join.* from
  t1 join t2 using (a) as foo, t3 as unnamed_join
  for update of unnamed_join;
CREATE TEMP TABLE tt1 ( tt1_id int4, joincol int4 );
INSERT INTO tt1 VALUES (1, 11);
INSERT INTO tt1 VALUES (2, NULL);
CREATE TEMP TABLE tt2 ( tt2_id int4, joincol int4 );
INSERT INTO tt2 VALUES (21, 11);
INSERT INTO tt2 VALUES (22, 11);
set enable_hashjoin to off;
set enable_nestloop to off;
select tt1.*, tt2.* from tt1 left join tt2 on tt1.joincol = tt2.joincol;
select tt1.*, tt2.* from tt2 right join tt1 on tt1.joincol = tt2.joincol;
reset enable_hashjoin;
reset enable_nestloop;
set work_mem to '64kB';
set enable_mergejoin to off;
set enable_memoize to off;
reset work_mem;
reset enable_mergejoin;
reset enable_memoize;
create temp table tt3(f1 int, f2 text);
insert into tt3 select x, repeat('xyzzy', 100) from generate_series(1,10000) x;
analyze tt3;
create temp table tt4(f1 int);
insert into tt4 values (0),(1),(9999);
analyze tt4;
set enable_nestloop to off;
EXPLAIN (COSTS OFF)
SELECT a.f1
FROM tt4 a
LEFT JOIN (
        SELECT b.f1
        FROM tt3 b LEFT JOIN tt3 c ON (b.f1 = c.f1)
        WHERE COALESCE(c.f1, 0) = 0
) AS d ON (a.f1 = d.f1)
WHERE COALESCE(d.f1, 0) = 0
ORDER BY 1;
SELECT a.f1
FROM tt4 a
LEFT JOIN (
        SELECT b.f1
        FROM tt3 b LEFT JOIN tt3 c ON (b.f1 = c.f1)
        WHERE COALESCE(c.f1, 0) = 0
) AS d ON (a.f1 = d.f1)
WHERE COALESCE(d.f1, 0) = 0
ORDER BY 1;
reset enable_nestloop;
create temp table tt4x(c1 int, c2 int, c3 int);
explain (costs off)
select * from tt4x t1
where not exists (
  select 1 from tt4x t2
    left join tt4x t3 on t2.c3 = t3.c1
    left join ( select t5.c1 as c1
                from tt4x t4 left join tt4x t5 on t4.c2 = t5.c1
              ) a1 on t3.c2 = a1.c1
  where t1.c1 = t2.c2
);
create temp table tt5(f1 int, f2 int);
create temp table tt6(f1 int, f2 int);
insert into tt5 values(1, 10);
insert into tt5 values(1, 11);
insert into tt6 values(1, 9);
insert into tt6 values(1, 2);
insert into tt6 values(2, 9);
select * from tt5,tt6 where tt5.f1 = tt6.f1 and tt5.f1 = tt5.f2 - tt6.f2;
create temp table xx (pkxx int);
create temp table yy (pkyy int, pkxx int);
insert into xx values (1);
insert into xx values (2);
insert into xx values (3);
insert into yy values (101, 1);
insert into yy values (201, 2);
insert into yy values (301, NULL);
select yy.pkyy as yy_pkyy, yy.pkxx as yy_pkxx, yya.pkyy as yya_pkyy,
       xxa.pkxx as xxa_pkxx, xxb.pkxx as xxb_pkxx
from yy
     left join (SELECT * FROM yy where pkyy = 101) as yya ON yy.pkyy = yya.pkyy
     left join xx xxa on yya.pkxx = xxa.pkxx
     left join xx xxb on coalesce (xxa.pkxx, 1) = xxb.pkxx;
create temp table zt1 (f1 int primary key);
create temp table zt2 (f2 int primary key);
create temp table zt3 (f3 int primary key);
insert into zt1 values(53);
insert into zt2 values(53);
select * from
  zt2 left join zt3 on (f2 = f3)
      left join zt1 on (f3 = f1)
where f2 = 53;
create temp view zv1 as select *,'dummy'::text AS junk from zt1;
select * from
  zt2 left join zt3 on (f2 = f3)
      left join zv1 on (f3 = f1)
where f2 = 53;
begin;
set enable_mergejoin = 1;
set enable_hashjoin = 0;
set enable_nestloop = 0;
create temp table a (i integer);
create temp table b (x integer, y integer);
select * from a left join b on i = x and i = y and x = i;
rollback;
begin;
create type mycomptype as (id int, v bigint);
create temp table tidv (idv mycomptype);
create index on tidv (idv);
explain (costs off)
select a.idv, b.idv from tidv a, tidv b where a.idv = b.idv;
set enable_mergejoin = 0;
set enable_hashjoin = 0;
explain (costs off)
select a.idv, b.idv from tidv a, tidv b where a.idv = b.idv;
rollback;
begin;
create temp table a (
     code char not null,
     constraint a_pk primary key (code)
);
create temp table b (
     a char not null,
     num integer not null,
     constraint b_pk primary key (a, num)
);
create temp table c (
     name char not null,
     a char,
     constraint c_pk primary key (name)
);
insert into a (code) values ('p');
insert into a (code) values ('q');
insert into b (a, num) values ('p', 1);
insert into b (a, num) values ('p', 2);
insert into c (name, a) values ('A', 'p');
insert into c (name, a) values ('B', 'q');
insert into c (name, a) values ('C', null);
select c.name, ss.code, ss.b_cnt, ss.const
from c left join
  (select a.code, coalesce(b_grp.cnt, 0) as b_cnt, -1 as const
   from a left join
     (select count(1) as cnt, b.a from b group by b.a) as b_grp
     on a.code = b_grp.a
  ) as ss
  on (c.a = ss.code)
order by c.name;
rollback;
SELECT * FROM
( SELECT 1 as key1 ) sub1
LEFT JOIN
( SELECT sub3.key3, sub4.value2, COALESCE(sub4.value2, 66) as value3 FROM
    ( SELECT 1 as key3 ) sub3
    LEFT JOIN
    ( SELECT sub5.key5, COALESCE(sub6.value1, 1) as value2 FROM
        ( SELECT 1 as key5 ) sub5
        LEFT JOIN
        ( SELECT 2 as key6, 42 as value1 ) sub6
        ON sub5.key5 = sub6.key6
    ) sub4
    ON sub4.key5 = sub3.key3
) sub2
ON sub1.key1 = sub2.key3;
SELECT * FROM
( SELECT 1 as key1 ) sub1
LEFT JOIN
( SELECT sub3.key3, value2, COALESCE(value2, 66) as value3 FROM
    ( SELECT 1 as key3 ) sub3
    LEFT JOIN
    ( SELECT sub5.key5, COALESCE(sub6.value1, 1) as value2 FROM
        ( SELECT 1 as key5 ) sub5
        LEFT JOIN
        ( SELECT 2 as key6, 42 as value1 ) sub6
        ON sub5.key5 = sub6.key6
    ) sub4
    ON sub4.key5 = sub3.key3
) sub2
ON sub1.key1 = sub2.key3;
create temp table nt1 (
  id int primary key,
  a1 boolean,
  a2 boolean
);
create temp table nt2 (
  id int primary key,
  nt1_id int,
  b1 boolean,
  b2 boolean,
  foreign key (nt1_id) references nt1(id)
);
create temp table nt3 (
  id int primary key,
  nt2_id int,
  c1 boolean,
  foreign key (nt2_id) references nt2(id)
);
insert into nt1 values (1,true,true);
insert into nt1 values (2,true,false);
insert into nt1 values (3,false,false);
insert into nt2 values (1,1,true,true);
insert into nt2 values (2,2,true,false);
insert into nt2 values (3,3,false,false);
insert into nt3 values (1,1,true);
insert into nt3 values (2,2,false);
insert into nt3 values (3,3,true);
explain (costs off)
select nt3.id
from nt3 as nt3
  left join
    (select nt2.*, (nt2.b1 and ss1.a3) AS b3
     from nt2 as nt2
       left join
         (select nt1.*, (nt1.id is not null) as a3 from nt1) as ss1
         on ss1.id = nt2.nt1_id
    ) as ss2
    on ss2.id = nt3.nt2_id
where nt3.id = 1 and ss2.b3;
select nt3.id
from nt3 as nt3
  left join
    (select nt2.*, (nt2.b1 and ss1.a3) AS b3
     from nt2 as nt2
       left join
         (select nt1.*, (nt1.id is not null) as a3 from nt1) as ss1
         on ss1.id = nt2.nt1_id
    ) as ss2
    on ss2.id = nt3.nt2_id
where nt3.id = 1 and ss2.b3;
create temp table q1 as select 1 as q1;
create temp table q2 as select 0 as q2;
analyze q1;
analyze q2;
explain (verbose, costs off)
select * from
  (select 1 as x) ss1 left join (select 2 as y) ss2 on (true),
  lateral (select ss2.y as z limit 1) ss3;
select * from
  (select 1 as x) ss1 left join (select 2 as y) ss2 on (true),
  lateral (select ss2.y as z limit 1) ss3;
explain (costs off)
select * from
  (select 0 as z) as t1
  left join
  (select true as a) as t2
  on true,
  lateral (select true as b
           union all
           select a as b) as t3
where b;
select * from
  (select 0 as z) as t1
  left join
  (select true as a) as t2
  on true,
  lateral (select true as b
           union all
           select a as b) as t3
where b;
explain (verbose, costs off)
with ctetable as not materialized ( select 1 as f1 )
select * from ctetable c1
where f1 in ( select c3.f1 from ctetable c2 full join ctetable c3 on true );
with ctetable as not materialized ( select 1 as f1 )
select * from ctetable c1
where f1 in ( select c3.f1 from ctetable c2 full join ctetable c3 on true );
create function f_immutable_int4(i integer) returns integer as
$$ begin return i; end; $$ language plpgsql immutable;
explain (costs off)
select nt3.id
from nt3 as nt3
  left join
    (select nt2.*, (nt2.b1 or i4 = 42) AS b3
     from nt2 as nt2
       left join
         f_immutable_int4(0) i4
         on i4 = nt2.nt1_id
    ) as ss2
    on ss2.id = nt3.nt2_id
where nt3.id = 1 and ss2.b3;
drop function f_immutable_int4(int);
explain (costs off)
select * from
(values (1, array[10,20]), (2, array[20,30])) as v1(v1x,v1ys)
left join (values (1, 10), (2, 20)) as v2(v2x,v2y) on v2x = v1x
left join unnest(v1ys) as u1(u1y) on u1y = v2y;
select * from
(values (1, array[10,20]), (2, array[20,30])) as v1(v1x,v1ys)
left join (values (1, 10), (2, 20)) as v2(v2x,v2y) on v2x = v1x
left join unnest(v1ys) as u1(u1y) on u1y = v2y;
explain (costs off)
select nspname
from (select 1 as x) ss1
left join
( select n.nspname, c.relname
  from pg_class c left join pg_namespace n on n.oid = c.relnamespace
  where c.relkind = 'r'
) ss2 on false;
begin;
create temp table t (a int unique);
explain (costs off)
select 1 from t t1
  join lateral (select t1.a from (select 1) foo offset 0) as s1 on true
  join
    (select 1 from t t2
       inner join (t t3
                   left join (t t4 left join t t5 on t4.a = 1)
                   on t3.a = t4.a)
       on false
     where t3.a = coalesce(t5.a,1)) as s2
  on true;
rollback;
set enable_hashjoin to off;
set enable_nestloop to off;
reset enable_hashjoin;
reset enable_nestloop;
begin;
CREATE TEMP TABLE a (id int PRIMARY KEY, b_id int);
CREATE TEMP TABLE b (id int PRIMARY KEY, c_id int);
CREATE TEMP TABLE c (id int PRIMARY KEY);
CREATE TEMP TABLE d (a int, b int);
INSERT INTO a VALUES (0, 0), (1, NULL);
INSERT INTO b VALUES (0, 0), (1, NULL);
INSERT INTO c VALUES (0), (1);
INSERT INTO d VALUES (1,3), (2,2), (3,1);
explain (costs off) SELECT a.* FROM a LEFT JOIN b ON a.b_id = b.id;
explain (costs off) SELECT b.* FROM b LEFT JOIN c ON b.c_id = c.id;
explain (costs off)
  SELECT a.* FROM a LEFT JOIN (b left join c on b.c_id = c.id)
  ON (a.b_id = b.id);
explain (costs off)
select id from a where id in (
	select b.id from b left join c on b.id = c.id
);
explain (costs off)
select a1.id from
  (a a1 left join a a2 on true)
  left join
  (a a3 left join a a4 on a3.id = a4.id)
  on a2.id = a3.id;
explain (costs off)
select a1.id from
  (a a1 left join a a2 on a1.id = a2.id)
  left join
  (a a3 left join a a4 on a3.id = a4.id)
  on a2.id = a3.id;
explain (costs off)
select 1 from a t1
    left join a t2 on true
   inner join a t3 on true
    left join a t4 on t2.id = t4.id and t2.id = t3.id;
rollback;
create temp table parent (k int primary key, pd int);
create temp table child (k int unique, cd int);
insert into parent values (1, 10), (2, 20), (3, 30);
insert into child values (1, 100), (4, 400);
select p.* from parent p left join child c on (p.k = c.k);
explain (costs off)
  select p.* from parent p left join child c on (p.k = c.k);
select p.*, linked from parent p
  left join (select c.*, true as linked from child c) as ss
  on (p.k = ss.k);
explain (costs off)
  select p.*, linked from parent p
    left join (select c.*, true as linked from child c) as ss
    on (p.k = ss.k);
select p.* from
  parent p left join child c on (p.k = c.k)
  where p.k = 1 and p.k = 2;
explain (costs off)
select p.* from
  parent p left join child c on (p.k = c.k)
  where p.k = 1 and p.k = 2;
select p.* from
  (parent p left join child c on (p.k = c.k)) join parent x on p.k = x.k
  where p.k = 1 and p.k = 2;
explain (costs off)
select p.* from
  (parent p left join child c on (p.k = c.k)) join parent x on p.k = x.k
  where p.k = 1 and p.k = 2;
begin;
CREATE TEMP TABLE a (id int PRIMARY KEY);
CREATE TEMP TABLE b (id int PRIMARY KEY, a_id int);
INSERT INTO a VALUES (0), (1);
INSERT INTO b VALUES (0, 0), (1, NULL);
SELECT * FROM b LEFT JOIN a ON (b.a_id = a.id) WHERE (a.id IS NULL OR a.id > 0);
SELECT b.* FROM b LEFT JOIN a ON (b.a_id = a.id) WHERE (a.id IS NULL OR a.id > 0);
rollback;
begin;
create temp table innertab (id int8 primary key, dat1 int8);
insert into innertab values(123, 42);
rollback;
begin;
create temp table uniquetbl (f1 text unique);
explain (costs off)
select t1.* from
  uniquetbl as t1
  left join (select *, '***'::text as d1 from uniquetbl) t2
  on t1.f1 = t2.f1
  left join uniquetbl t3
  on t2.d1 = t3.f1;
rollback;
begin;
create temp table t (a int unique);
insert into t values (1);
explain (costs off)
select 1
from t t1
  left join (select 2 as c
             from t t2 left join t t3 on t2.a = t3.a) s
    on true
where t1.a = s.c;
select 1
from t t1
  left join (select 2 as c
             from t t2 left join t t3 on t2.a = t3.a) s
    on true
where t1.a = s.c;
rollback;
begin;
create temp table t (a int unique, b int);
insert into t values (1,1), (2,2);
explain (costs off)
select 1
from t t1
  left join (select t2.a, 1 as c
             from t t2 left join t t3 on t2.a = t3.a) s
  on true
  left join t t4 on true
where s.a < s.c;
explain (costs off)
select t1.a, s.*
from t t1
  left join lateral (select t2.a, coalesce(t1.a, 1) as c
                     from t t2 left join t t3 on t2.a = t3.a) s
  on true
  left join t t4 on true
where s.a < s.c;
select t1.a, s.*
from t t1
  left join lateral (select t2.a, coalesce(t1.a, 1) as c
                     from t t2 left join t t3 on t2.a = t3.a) s
  on true
  left join t t4 on true
where s.a < s.c;
rollback;
create temp table parttbl (a integer primary key) partition by range (a);
create temp table parttbl1 partition of parttbl for values from (1) to (100);
insert into parttbl values (11), (12);
set enable_hashjoin to off;
set enable_mergejoin to off;
create table sj (a int unique, b int, c int unique);
insert into sj values (1, null, 2), (null, 2, null), (2, 1, 1);
analyze sj;
explain (costs off)
select p.* from sj p, sj q where q.a = p.a and q.b = q.a - 1;
select p.* from sj p, sj q where q.a = p.a and q.b = q.a - 1;
explain (costs off)
select * from sj p
where exists (select * from sj q
              where q.a = p.a and q.b < 10);
select * from sj p
where exists (select * from sj q
              where q.a = p.a and q.b < 10);
explain (costs off)
select * from sj t1, sj t2 where t1.a = t2.c and t1.b is not null;
explain (costs off)
select * from
  (select a as x from sj where false) as q1,
  (select a as y from sj where false) as q2
where q1.x = q2.y;
explain (costs off)
select * from sj t1, sj t2 where t1.a = t1.b and t1.b = t2.b and t2.b = t2.a;
explain (costs off)
select * from sj t1, sj t2, sj t3
where t1.a = t1.b and t1.b = t2.b and t2.b = t2.a and
      t1.b = t3.b and t3.b = t3.a;
explain (costs off)
select *
from  sj t1
      join sj t2 on t1.a = t2.a and t1.b = t2.b
	  join sj t3 on t2.a = t3.a and t2.b + 1 = t3.b + 1;
explain (costs off)
select t1.a, (select a from sj where a = t2.a and a = t1.a)
from sj t1, sj t2
where t1.a = t2.a;
explain (costs off)
select * from (
  select t1.*, t2.a as ax from sj t1 join sj t2
  on (t1.a = t2.a and t1.c * t1.c = t2.c + 2 and t2.b is null)
) as q1
left join
  (select t3.* from sj t3, sj t4 where t3.c = t4.c) as q2
on q1.ax = q2.a;
explain (verbose, costs off)
select t3.a from sj t1
	join sj t2 on t1.a = t2.a
	join lateral (select t1.a offset 0) t3 on true;
explain (verbose, costs off)
select t3.a from sj t1
	join sj t2 on t1.a = t2.a
	join lateral (select * from (select t1.a offset 0) offset 0) t3 on true;
explain (verbose, costs off)
select t4.a from sj t1
	join sj t2 on t1.a = t2.a
	join lateral (select t3.a from sj t3, (select t1.a) offset 0) t4 on true;
explain (COSTS OFF)
SELECT * FROM pg_am am WHERE am.amname IN (
  SELECT c1.relname AS relname
  FROM pg_class c1
    JOIN pg_class c2
    ON c1.oid=c2.oid AND c1.oid < 10
);
INSERT INTO sj VALUES (3, 1, 3);
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND j1.a = 2 AND j2.a = 3;
SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND j1.a = 2 AND j2.a = 3;
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND j1.a = 2 AND j2.a = 2;
SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND j1.a = 2 AND j2.a = 2;
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND j1.a = (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int
  AND (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int = j2.a;
SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND j1.a = (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int
  AND (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int = j2.a;
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND j1.a = 1 AND j2.a = 1;
SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND j1.a = 1 AND j2.a = 1;
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND 1 = j1.a AND j2.a = 1;
SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND 1 = j1.a AND j2.a = 1;
EXPLAIN (COSTS OFF)
SELECT t4.*
FROM (SELECT t1.*, t2.a AS a1 FROM sj t1, sj t2 WHERE t1.b = t2.b) AS t3
JOIN sj t4 ON (t4.a = t3.a) WHERE t3.a1 = 42;
SELECT t4.*
FROM (SELECT t1.*, t2.a AS a1 FROM sj t1, sj t2 WHERE t1.b = t2.b) AS t3
JOIN sj t4 ON (t4.a = t3.a) WHERE t3.a1 = 42;
CREATE UNIQUE INDEX sj_fn_idx ON sj((a * a));
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2
	WHERE j1.b = j2.b AND j1.a*j1.a = 1 AND j2.a*j2.a = 1;
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2
	WHERE j1.b = j2.b AND j1.a*j1.a = 1 AND j2.a*j2.a = 2;
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND (j1.a*j1.a) = (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int
  AND (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int = (j2.a*j2.a);
SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND (j1.a*j1.a) = (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int
  AND (EXTRACT(DOW FROM current_timestamp(0))/15 + 3)::int = (j2.a*j2.a);
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND (j1.a*j1.c/3) = (random()/3 + 3)::int
  AND (random()/3 + 3)::int = (j2.a*j2.c/3);
SELECT * FROM sj j1, sj j2
WHERE j1.b = j2.b
  AND (j1.a*j1.c/3) = (random()/3 + 3)::int
  AND (random()/3 + 3)::int = (j2.a*j2.c/3);
CREATE UNIQUE INDEX sj_temp_idx1 ON sj(a,b,c);
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2
	WHERE j1.b = j2.b AND j1.a = 2 AND j1.c = 3 AND j2.a = 2 AND 3 = j2.c;
EXPLAIN (COSTS OFF)
	SELECT * FROM sj j1, sj j2
	WHERE j1.b = j2.b AND 2 = j1.a AND j1.c = 3 AND j2.a = 1 AND 3 = j2.c;
CREATE UNIQUE INDEX sj_temp_idx ON sj(a,b);
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND j1.a = 2;
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND 2 = j2.a;
EXPLAIN (COSTS OFF)
SELECT * FROM sj j1, sj j2 WHERE j1.b = j2.b AND (j1.a = 1 OR j2.a = 1);
DROP INDEX sj_fn_idx, sj_temp_idx1, sj_temp_idx;
CREATE TABLE tab_with_flag ( id INT PRIMARY KEY, is_flag SMALLINT);
CREATE INDEX idx_test_is_flag ON tab_with_flag (is_flag);
EXPLAIN (COSTS OFF)
SELECT COUNT(*) FROM tab_with_flag
WHERE
	(is_flag IS NULL OR is_flag = 0)
	AND id IN (SELECT id FROM tab_with_flag WHERE id IN (2, 3));
DROP TABLE tab_with_flag;
explain (costs off)
select p.b from sj p join sj q on p.a = q.a group by p.b having sum(p.a) = 1;
explain (verbose, costs off)
select 1 from (select x.* from sj x, sj y where x.a = y.a) q,
  lateral generate_series(1, q.a) gs(i);
explain (costs off) select * from sj p join sj q on p.a = q.a
  left join sj r on p.a + q.a = r.a;
explain (costs off)
select * from sj p, sj q where p.a = q.a and p.b = 1 and q.b = 2;
create table sk (a int, b int);
create index on sk(a);
set join_collapse_limit to 1;
set enable_seqscan to off;
explain (costs off) select 1 from
	(sk k1 join sk k2 on k1.a = k2.a)
	join (sj j1 join sj j2 on j1.a = j2.a) on j1.b = k1.b;
explain (costs off) select 1 from
	(sk k1 join sk k2 on k1.a = k2.a)
	join (sj j1 join sj j2 on j1.a = j2.a) on j2.b = k1.b;
reset join_collapse_limit;
reset enable_seqscan;
CREATE TABLE emp1 (id SERIAL PRIMARY KEY NOT NULL, code int);
EXPLAIN (VERBOSE, COSTS OFF)
SELECT * FROM emp1 e1, emp1 e2 WHERE e1.id = e2.id AND e2.code <> e1.code;
CREATE UNIQUE INDEX ON emp1((id*id));
EXPLAIN (COSTS OFF)
SELECT count(*) FROM emp1 c1, emp1 c2, emp1 c3
WHERE c1.id=c2.id AND c1.id*c2.id=c3.id*c3.id;
EXPLAIN (COSTS OFF)
SELECT c1.code FROM emp1 c1 LEFT JOIN emp1 c2 ON c1.id = c2.id
WHERE c2.id IS NOT NULL
EXCEPT ALL
SELECT c3.code FROM emp1 c3;
explain (costs off)
select * from emp1 t1 left join
    (select coalesce(t3.code, 1) from emp1 t2
        left join (emp1 t3 join emp1 t4 on t3.id = t4.id)
        on true)
on true;
explain (verbose, costs off)
select 1 from emp1 t1 left join
    ((select 1 as x, * from emp1 t2) s1 inner join
        (select * from emp1 t3) s2 on s1.id = s2.id)
    on true
where s1.x = 1;
explain (verbose, costs off)
select * from emp1 t1 join emp1 t2 on t1.id = t2.id left join
    lateral (select t1.id as t1id, * from generate_series(1,1) t3) s on true;
explain (verbose, costs off)
select * from generate_series(1,10) t1(id) left join
    lateral (select t1.id as t1id, t2.id from emp1 t2 join emp1 t3 on t2.id = t3.id)
on true;
explain (costs off)
select * from emp1 t1
   inner join emp1 t2 on t1.id = t2.id
    left join emp1 t3 on t1.id > 1 and t1.id < 2;
EXPLAIN (COSTS OFF)
WITH t1 AS (SELECT * FROM emp1)
UPDATE emp1 SET code = t1.code + 1 FROM t1
WHERE t1.id = emp1.id RETURNING emp1.id, emp1.code, t1.code;
INSERT INTO emp1 VALUES (1, 1), (2, 1);
WITH t1 AS (SELECT * FROM emp1)
UPDATE emp1 SET code = t1.code + 1 FROM t1
WHERE t1.id = emp1.id RETURNING emp1.id, emp1.code, t1.code;
TRUNCATE emp1;
EXPLAIN (COSTS OFF)
UPDATE sj sq SET b = 1 FROM sj as sz WHERE sq.a = sz.a;
CREATE RULE sj_del_rule AS ON DELETE TO sj
  DO INSTEAD
    UPDATE sj SET a = 1 WHERE a = old.a;
EXPLAIN (COSTS OFF) DELETE FROM sj;
DROP RULE sj_del_rule ON sj CASCADE;
insert into emp1 values (1, 1);
explain (costs off)
select 1 from emp1 full join
    (select * from emp1 t1 join
        emp1 t2 join emp1 t3 on t2.id = t3.id
        on true
    where false) s on true
where false;
select 1 from emp1 full join
    (select * from emp1 t1 join
        emp1 t2 join emp1 t3 on t2.id = t3.id
        on true
    where false) s on true
where false;
insert into emp1 values (2, 1);
explain (costs off)
select * from emp1 t1 where exists (select * from emp1 t2
                                    where t2.id = t1.code and t2.code > 0);
select * from emp1 t1 where exists (select * from emp1 t2
                                    where t2.id = t1.code and t2.code > 0);
create table sl(a int, b int, c int);
create unique index on sl(a, b);
vacuum analyze sl;
explain (costs off)
select * from sl t1, sl t2 where t1.a = t2.a and t1.b = 1 and t2.b = 2;
explain (costs off)
select * from sl t1, sl t2
where t1.a = t2.a and t1.b = 1 and t2.b = 2
  and t1.c IS NOT NULL and t2.c IS NOT NULL
  and t2.b IS NOT NULL and t1.b IS NOT NULL
  and t1.a IS NOT NULL and t2.a IS NOT NULL;
explain (verbose, costs off)
select * from sl t1, sl t2
where t1.b = t2.b and t2.a = 3 and t1.a = 3
  and t1.c IS NOT NULL and t2.c IS NOT NULL
  and t2.b IS NOT NULL and t1.b IS NOT NULL
  and t1.a IS NOT NULL and t2.a IS NOT NULL;
EXPLAIN (COSTS OFF)
SELECT n2.a FROM sj n1, sj n2 WHERE n1.a <> n2.a AND n2.a = 1;
EXPLAIN (COSTS OFF)
SELECT * FROM
(SELECT n2.a FROM sj n1, sj n2 WHERE n1.a <> n2.a) q0, sl
WHERE q0.a = 1;
CREATE TABLE sj_t1 (id serial, a int);
CREATE TABLE sj_t2 (id serial, a int);
CREATE TABLE sj_t3 (id serial, a int);
CREATE TABLE sj_t4 (id serial, a int);
CREATE UNIQUE INDEX ON sj_t3 USING btree (a,id);
CREATE UNIQUE INDEX ON sj_t2 USING btree (id);
EXPLAIN (COSTS OFF)
SELECT * FROM sj_t1
JOIN (
	SELECT sj_t2.id AS id FROM sj_t2
	WHERE EXISTS
		(
		SELECT TRUE FROM sj_t3,sj_t4 WHERE sj_t3.a = 1 AND sj_t3.id = sj_t2.id
		)
	) t2t3t4
ON sj_t1.id = t2t3t4.id
JOIN (
	SELECT sj_t2.id AS id FROM sj_t2
	WHERE EXISTS
		(
		SELECT TRUE FROM sj_t3,sj_t4 WHERE sj_t3.a = 1 AND sj_t3.id = sj_t2.id
		)
	) _t2t3t4
ON sj_t1.id = _t2t3t4.id;
EXPLAIN (COSTS OFF)
SELECT a1.a FROM sj a1,sj a2 WHERE (a1.a=a2.a) FOR UPDATE;
reset enable_hashjoin;
reset enable_mergejoin;
select * from (values(1)) x(lb),
  lateral generate_series(lb,4) x4;
select * from (values(1)) x(lb),
  lateral (values(lb)) y(lbcopy);
explain (verbose, costs off)
select * from
  (select 0 as val0) as ss0
  left join (select 1 as val) as ss1 on true
  left join lateral (select ss1.val as val_filtered where false) as ss2 on true;
select * from
  (select 0 as val0) as ss0
  left join (select 1 as val) as ss1 on true
  left join lateral (select ss1.val as val_filtered where false) as ss2 on true;
explain (verbose, costs off)
select * from
  (select 1 as x offset 0) x cross join (select 2 as y offset 0) y
  left join lateral (
    select * from (select 3 as z offset 0) z where z.z = x.x
  ) zz on zz.z = y.y;
select * from
  ((select 2 as v) union all (select 3 as v)) as q1
  cross join lateral
  ((select * from
      ((select 4 as v) union all (select 5 as v)) as q3)
   union all
   (select q1.v)
  ) as q2;
create table join_pt1 (a int, b int, c varchar) partition by range(a);
create table join_pt1p1 partition of join_pt1 for values from (0) to (100) partition by range(b);
create table join_pt1p2 partition of join_pt1 for values from (100) to (200);
create table join_pt1p1p1 partition of join_pt1p1 for values from (0) to (100);
insert into join_pt1 values (1, 1, 'x'), (101, 101, 'y');
create table join_ut1 (a int, b int, c varchar);
insert into join_ut1 values (101, 101, 'y'), (2, 2, 'z');
explain (verbose, costs off)
select t1.b, ss.phv from join_ut1 t1 left join lateral
              (select t2.a as t2a, t3.a t3a, least(t1.a, t2.a, t3.a) phv
					  from join_pt1 t2 join join_ut1 t3 on t2.a = t3.b) ss
              on t1.a = ss.t2a order by t1.a;
select t1.b, ss.phv from join_ut1 t1 left join lateral
              (select t2.a as t2a, t3.a t3a, least(t1.a, t2.a, t3.a) phv
					  from join_pt1 t2 join join_ut1 t3 on t2.a = t3.b) ss
              on t1.a = ss.t2a order by t1.a;
drop table join_pt1;
drop table join_ut1;
begin;
create table fkest (x integer, x10 integer, x10b integer, x100 integer);
insert into fkest select x, x/10, x/10, x/100 from generate_series(1,1000) x;
create unique index on fkest(x, x10, x100);
analyze fkest;
explain (costs off)
select * from fkest f1
  join fkest f2 on (f1.x = f2.x and f1.x10 = f2.x10b and f1.x100 = f2.x100)
  join fkest f3 on f1.x = f3.x
  where f1.x100 = 2;
alter table fkest add constraint fk
  foreign key (x, x10b, x100) references fkest (x, x10, x100);
explain (costs off)
select * from fkest f1
  join fkest f2 on (f1.x = f2.x and f1.x10 = f2.x10b and f1.x100 = f2.x100)
  join fkest f3 on f1.x = f3.x
  where f1.x100 = 2;
rollback;
begin;
create table fkest (a int, b int, c int unique, primary key(a,b));
create table fkest1 (a int, b int, primary key(a,b));
insert into fkest select x/10, x%10, x from generate_series(1,1000) x;
insert into fkest1 select x/10, x%10 from generate_series(1,1000) x;
alter table fkest1
  add constraint fkest1_a_b_fkey foreign key (a,b) references fkest;
analyze fkest;
analyze fkest1;
explain (costs off)
select *
from fkest f
  left join fkest1 f1 on f.a = f1.a and f.b = f1.b
  left join fkest1 f2 on f.a = f2.a and f.b = f2.b
  left join fkest1 f3 on f.a = f3.a and f.b = f3.b
where f.c = 1;
rollback;
create table j1 (id int primary key);
create table j2 (id int primary key);
create table j3 (id int);
insert into j1 values(1),(2),(3);
insert into j2 values(1),(2),(3);
insert into j3 values(1),(1);
analyze j1;
analyze j2;
analyze j3;
explain (verbose, costs off)
select * from j1 inner join j2 on j1.id = j2.id;
explain (verbose, costs off)
select * from j1 inner join j2 on j1.id > j2.id;
explain (verbose, costs off)
select * from j1 inner join j3 on j1.id = j3.id;
explain (verbose, costs off)
select * from j1 left join j2 on j1.id = j2.id;
explain (verbose, costs off)
select * from j1 right join j2 on j1.id = j2.id;
explain (verbose, costs off)
select * from j1 full join j2 on j1.id = j2.id;
explain (verbose, costs off)
select * from j1 cross join j2;
explain (verbose, costs off)
select * from j1 natural join j2;
explain (verbose, costs off)
select * from j1
inner join (select distinct id from j3) j3 on j1.id = j3.id;
explain (verbose, costs off)
select * from j1
inner join (select id from j3 group by id) j3 on j1.id = j3.id;
drop table j1;
drop table j2;
drop table j3;
create table j1 (id1 int, id2 int, primary key(id1,id2));
create table j2 (id1 int, id2 int, primary key(id1,id2));
create table j3 (id1 int, id2 int, primary key(id1,id2));
insert into j1 values(1,1),(1,2);
insert into j2 values(1,1);
insert into j3 values(1,1);
analyze j1;
analyze j2;
analyze j3;
explain (verbose, costs off)
select * from j1
inner join j2 on j1.id1 = j2.id1;
explain (verbose, costs off)
select * from j1
inner join j2 on j1.id1 = j2.id1 and j1.id2 = j2.id2;
explain (verbose, costs off)
select * from j1
inner join j2 on j1.id1 = j2.id1 where j1.id2 = 1;
explain (verbose, costs off)
select * from j1
left join j2 on j1.id1 = j2.id1 where j1.id2 = 1;
create unique index j1_id2_idx on j1(id2) where id2 is not null;
explain (verbose, costs off)
select * from j1
inner join j2 on j1.id2 = j2.id2;
drop index j1_id2_idx;
set enable_nestloop to 0;
set enable_hashjoin to 0;
set enable_sort to 0;
create index j1_id1_idx on j1 (id1) where id1 % 1000 = 1;
create index j2_id1_idx on j2 (id1) where id1 % 1000 = 1;
insert into j2 values(1,2);
analyze j2;
explain (costs off) select * from j1
inner join j2 on j1.id1 = j2.id1 and j1.id2 = j2.id2
where j1.id1 % 1000 = 1 and j2.id1 % 1000 = 1;
select * from j1
inner join j2 on j1.id1 = j2.id1 and j1.id2 = j2.id2
where j1.id1 % 1000 = 1 and j2.id1 % 1000 = 1;
explain (costs off) select * from j1
inner join j2 on j1.id1 = j2.id1 and j1.id2 = j2.id2
where j1.id1 % 1000 = 1 and j2.id1 % 1000 = 1 and j2.id1 = any (array[1]);
select * from j1
inner join j2 on j1.id1 = j2.id1 and j1.id2 = j2.id2
where j1.id1 % 1000 = 1 and j2.id1 % 1000 = 1 and j2.id1 = any (array[1]);
explain (costs off) select * from j1
inner join j2 on j1.id1 = j2.id1 and j1.id2 = j2.id2
where j1.id1 % 1000 = 1 and j2.id1 % 1000 = 1 and j2.id1 >= any (array[1,5]);
select * from j1
inner join j2 on j1.id1 = j2.id1 and j1.id2 = j2.id2
where j1.id1 % 1000 = 1 and j2.id1 % 1000 = 1 and j2.id1 >= any (array[1,5]);
reset enable_nestloop;
reset enable_hashjoin;
reset enable_sort;
drop table j1;
drop table j2;
drop table j3;
