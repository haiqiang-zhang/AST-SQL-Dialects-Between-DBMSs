
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

SELECT t1.a, t2.e
  FROM J1_TBL t1 (a, b, c), J2_TBL t2 (d, e)
  WHERE t1.a = t2.d;



SELECT *
  FROM J1_TBL CROSS JOIN J2_TBL;

SELECT i, k, t
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

SELECT *
  FROM J1_TBL t1 (a, b, c) JOIN J2_TBL t2 (a, d) USING (a)
  ORDER BY a, d;

SELECT *
  FROM J1_TBL t1 (a, b, c) JOIN J2_TBL t2 (a, b) USING (b)
  ORDER BY b, t1.a;

SELECT * FROM J1_TBL JOIN J2_TBL USING (i) WHERE J1_TBL.t = 'one';  
SELECT * FROM J1_TBL JOIN J2_TBL USING (i) AS x WHERE J1_TBL.t = 'one';  
SELECT * FROM (J1_TBL JOIN J2_TBL USING (i)) AS x WHERE J1_TBL.t = 'one';  
SELECT * FROM J1_TBL JOIN J2_TBL USING (i) AS x WHERE x.i = 1;  
SELECT * FROM J1_TBL JOIN J2_TBL USING (i) AS x WHERE x.t = 'one';  
SELECT * FROM (J1_TBL JOIN J2_TBL USING (i) AS x) AS xx WHERE x.i = 1;  
SELECT * FROM J1_TBL a1 JOIN J2_TBL a2 USING (i) AS a1;  
SELECT x.* FROM J1_TBL JOIN J2_TBL USING (i) AS x WHERE J1_TBL.t = 'one';
SELECT ROW(x.*) FROM J1_TBL JOIN J2_TBL USING (i) AS x WHERE J1_TBL.t = 'one';
SELECT row_to_json(x.*) FROM J1_TBL JOIN J2_TBL USING (i) AS x WHERE J1_TBL.t = 'one';


SELECT *
  FROM J1_TBL NATURAL JOIN J2_TBL;

SELECT *
  FROM J1_TBL t1 (a, b, c) NATURAL JOIN J2_TBL t2 (a, d);

SELECT *
  FROM J1_TBL t1 (a, b, c) NATURAL JOIN J2_TBL t2 (d, a);

SELECT *
  FROM J1_TBL t1 (a, b) NATURAL JOIN J2_TBL t2 (a);



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

explain (costs off)
select * from int4_tbl i4, tenk1 a
where exists(select * from tenk1 b
             where a.twothousand = b.twothousand and a.fivethous <> b.fivethous)
      and i4.f1 = a.tenthous;




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
select * from (x left join y on (x1 = y1)) left join x xx(xx1,xx2)
on (x1 = xx1 and x2 is not null);
select * from (x left join y on (x1 = y1)) left join x xx(xx1,xx2)
on (x1 = xx1 and y2 is not null);
select * from (x left join y on (x1 = y1)) left join x xx(xx1,xx2)
on (x1 = xx1 and xx2 is not null);
select * from (x left join y on (x1 = y1)) left join x xx(xx1,xx2)
on (x1 = xx1) where (x2 is not null);
select * from (x left join y on (x1 = y1)) left join x xx(xx1,xx2)
on (x1 = xx1) where (y2 is not null);
select * from (x left join y on (x1 = y1)) left join x xx(xx1,xx2)
on (x1 = xx1) where (xx2 is not null);

select count(*) from tenk1 a where unique1 in
  (select unique1 from tenk1 b join tenk1 c using (unique1)
   where b.unique2 = 42);

select count(*) from tenk1 x where
  x.unique1 in (select a.f1 from int4_tbl a,float8_tbl b where a.f1=b.f1) and
  x.unique1 = 0 and
  x.unique1 in (select aa.f1 from int4_tbl aa,float8_tbl bb where aa.f1=bb.f1);

begin;
set geqo = on;
set geqo_threshold = 2;
select count(*) from tenk1 x where
  x.unique1 in (select a.f1 from int4_tbl a,float8_tbl b where a.f1=b.f1) and
  x.unique1 = 0 and
  x.unique1 in (select aa.f1 from int4_tbl aa,float8_tbl bb where aa.f1=bb.f1);
rollback;

explain (costs off)
select aa, bb, unique1, unique1
  from tenk1 right join b_star on aa = unique1
  where bb < bb and bb is null;

select aa, bb, unique1, unique1
  from tenk1 right join b_star on aa = unique1
  where bb < bb and bb is null;

explain (costs off)
select * from int8_tbl i1 left join (int8_tbl i2 join
  (select 123 as x) ss on i2.q1 = x) on i1.q2 = i2.q2
order by 1, 2;

select * from int8_tbl i1 left join (int8_tbl i2 join
  (select 123 as x) ss on i2.q1 = x) on i1.q2 = i2.q2
order by 1, 2;

select count(*)
from
  (select t3.tenthous as x1, coalesce(t1.stringu1, t2.stringu1) as x2
   from tenk1 t1
   left join tenk1 t2 on t1.unique1 = t2.unique1
   join tenk1 t3 on t1.unique2 = t3.unique2) ss,
  tenk1 t4,
  tenk1 t5
where t4.thousand = t5.unique1 and ss.x1 = t4.tenthous and ss.x2 = t5.stringu1;

explain (costs off)
select a.f1, b.f1, t.thousand, t.tenthous from
  tenk1 t,
  (select sum(f1)+1 as f1 from int4_tbl i4a) a,
  (select sum(f1) as f1 from int4_tbl i4b) b
where b.f1 = t.thousand and a.f1 = b.f1 and (a.f1+b.f1+999) = t.tenthous;

select a.f1, b.f1, t.thousand, t.tenthous from
  tenk1 t,
  (select sum(f1)+1 as f1 from int4_tbl i4a) a,
  (select sum(f1) as f1 from int4_tbl i4b) b
where b.f1 = t.thousand and a.f1 = b.f1 and (a.f1+b.f1+999) = t.tenthous;

explain (costs off)
select t1.f1
from int4_tbl t1, int4_tbl t2
  left join int4_tbl t3 on t3.f1 > 0
  left join int4_tbl t4 on t3.f1 > 1
where t4.f1 is null;

select t1.f1
from int4_tbl t1, int4_tbl t2
  left join int4_tbl t3 on t3.f1 > 0
  left join int4_tbl t4 on t3.f1 > 1
where t4.f1 is null;

explain (costs off)
select *
from int4_tbl t1 left join int4_tbl t2 on true
  left join int4_tbl t3 on t2.f1 > 0
  left join int4_tbl t4 on t3.f1 > 0;

explain (costs off)
select * from onek t1
  left join onek t2 on t1.unique1 = t2.unique1
  left join onek t3 on t2.unique1 != t3.unique1
  left join onek t4 on t3.unique1 = t4.unique1;

explain (costs off)
select * from int4_tbl t1
  left join (select now() from int4_tbl t2
             left join int4_tbl t3 on t2.f1 = t3.f1
             left join int4_tbl t4 on t3.f1 = t4.f1) s on true
  inner join int4_tbl t5 on true;

explain (costs off)
select * from int4_tbl t1
  left join int4_tbl t2 on true
  left join int4_tbl t3 on true
  left join int4_tbl t4 on t2.f1 = t3.f1;

explain (costs off)
select * from int4_tbl t1
  left join int4_tbl t2 on true
  left join int4_tbl t3 on t2.f1 = t3.f1
  left join int4_tbl t4 on t3.f1 != t4.f1;

explain (costs off)
select * from int4_tbl t1
  left join (int4_tbl t2 left join int4_tbl t3 on t2.f1 > 0) on t2.f1 > 1
  left join int4_tbl t4 on t2.f1 > 2 and t3.f1 > 3
where t1.f1 = coalesce(t2.f1, 1);

explain (costs off)
select * from int4_tbl t1
  left join ((select t2.f1 from int4_tbl t2
                left join int4_tbl t3 on t2.f1 > 0
                where t3.f1 is null) s
             left join tenk1 t4 on s.f1 > 1)
    on s.f1 = t1.f1;

explain (costs off)
select * from int4_tbl t1
  left join ((select t2.f1 from int4_tbl t2
                left join int4_tbl t3 on t2.f1 > 0
                where t2.f1 <> coalesce(t3.f1, -1)) s
             left join tenk1 t4 on s.f1 > 1)
    on s.f1 = t1.f1;

explain (costs off)
select * from onek t1
    left join onek t2 on t1.unique1 = t2.unique1
    left join onek t3 on t2.unique1 = t3.unique1
    left join onek t4 on t3.unique1 = t4.unique1 and t2.unique2 = t4.unique2;

explain (costs off)
select * from int8_tbl t1 left join
    (int8_tbl t2 left join int8_tbl t3 full join int8_tbl t4 on false on false)
    left join int8_tbl t5 on t2.q1 = t5.q1
on t2.q2 = 123;

explain (costs off)
select * from int8_tbl t1
    left join int8_tbl t2 on true
    left join lateral
      (select * from int8_tbl t3 where t3.q1 = t2.q1 offset 0) s
      on t2.q1 = 1;

explain (costs off)
select * from int8_tbl t1
    left join int8_tbl t2 on true
    left join lateral
      (select * from generate_series(t2.q1, 100)) s
      on t2.q1 = 1;

explain (costs off)
select * from int8_tbl t1
    left join int8_tbl t2 on true
    left join lateral
      (select t2.q1 from int8_tbl t3) s
      on t2.q1 = 1;

explain (costs off)
select * from onek t1
    left join onek t2 on true
    left join lateral
      (select * from onek t3 where t3.two = t2.two offset 0) s
      on t2.unique1 = 1;

explain (costs off)
select * from
  j1_tbl full join
  (select * from j2_tbl order by j2_tbl.i desc, j2_tbl.k asc) j2_tbl
  on j1_tbl.i = j2_tbl.i and j1_tbl.i = j2_tbl.k;

select * from
  j1_tbl full join
  (select * from j2_tbl order by j2_tbl.i desc, j2_tbl.k asc) j2_tbl
  on j1_tbl.i = j2_tbl.i and j1_tbl.i = j2_tbl.k;

explain (costs off)
select count(*) from
  (select * from tenk1 x order by x.thousand, x.twothousand, x.fivethous) x
  left join
  (select * from tenk1 y order by y.unique2) y
  on x.thousand = y.unique2 and x.twothousand = y.hundred and x.fivethous = y.unique2;

select count(*) from
  (select * from tenk1 x order by x.thousand, x.twothousand, x.fivethous) x
  left join
  (select * from tenk1 y order by y.unique2) y
  on x.thousand = y.unique2 and x.twothousand = y.hundred and x.fivethous = y.unique2;

set enable_hashjoin = 0;
set enable_nestloop = 0;
set enable_hashagg = 0;

explain (costs off)
select x.thousand, x.twothousand, count(*)
from tenk1 x inner join tenk1 y on x.thousand = y.thousand
group by x.thousand, x.twothousand
order by x.thousand desc, x.twothousand;

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


select t1.x from t1 join t3 on (t1.a = t3.x);


select t1.*, t2.*, unnamed_join.* from
  t1 join t2 on (t1.a = t2.a), t3 as unnamed_join
  for update of unnamed_join;

select foo.*, unnamed_join.* from
  t1 join t2 using (a) as foo, t3 as unnamed_join
  for update of unnamed_join;

select foo.*, unnamed_join.* from
  t1 join t2 using (a) as foo, t3 as unnamed_join
  for update of foo;

select bar.*, unnamed_join.* from
  (t1 join t2 using (a) as foo) as bar, t3 as unnamed_join
  for update of foo;

select bar.*, unnamed_join.* from
  (t1 join t2 using (a) as foo) as bar, t3 as unnamed_join
  for update of bar;


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

explain (costs off)
select count(*) from tenk1 a, tenk1 b
  where a.hundred = b.thousand and (b.fivethous % 10) < 10;
select count(*) from tenk1 a, tenk1 b
  where a.hundred = b.thousand and (b.fivethous % 10) < 10;

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


explain (costs off)
select a.* from tenk1 a
where unique1 in (select unique2 from tenk1 b);

explain (costs off)
select a.* from tenk1 a
where unique1 not in (select unique2 from tenk1 b);

explain (costs off)
select a.* from tenk1 a
where exists (select 1 from tenk1 b where a.unique1 = b.unique2);

explain (costs off)
select a.* from tenk1 a
where not exists (select 1 from tenk1 b where a.unique1 = b.unique2);

explain (costs off)
select a.* from tenk1 a left join tenk1 b on a.unique1 = b.unique2
where b.unique2 is null;


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


select a.unique2, a.ten, b.tenthous, b.unique2, b.hundred
from tenk1 a left join tenk1 b on a.unique2 = b.tenthous
where a.unique1 = 42 and
      ((b.unique2 is null and a.ten = 2) or b.hundred = 3);

prepare foo(bool) as
  select count(*) from tenk1 a left join tenk1 b
    on (a.unique2 = b.unique1 and exists
        (select 1 from tenk1 c where c.thousand = b.unique2 and $1));
execute foo(true);
execute foo(false);


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

select t1.q2, count(t2.*)
from int8_tbl t1 left join int8_tbl t2 on (t1.q2 = t2.q1)
group by t1.q2 order by 1;

select t1.q2, count(t2.*)
from int8_tbl t1 left join (select * from int8_tbl) t2 on (t1.q2 = t2.q1)
group by t1.q2 order by 1;

select t1.q2, count(t2.*)
from int8_tbl t1 left join (select * from int8_tbl offset 0) t2 on (t1.q2 = t2.q1)
group by t1.q2 order by 1;

select t1.q2, count(t2.*)
from int8_tbl t1 left join
  (select q1, case when q2=1 then 1 else q2 end as q2 from int8_tbl) t2
  on (t1.q2 = t2.q1)
group by t1.q2 order by 1;

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


EXPLAIN (COSTS OFF)
SELECT qq, unique1
  FROM
  ( SELECT COALESCE(q1, 0) AS qq FROM int8_tbl a ) AS ss1
  FULL OUTER JOIN
  ( SELECT COALESCE(q2, -1) AS qq FROM int8_tbl b ) AS ss2
  USING (qq)
  INNER JOIN tenk1 c ON qq = unique2;

SELECT qq, unique1
  FROM
  ( SELECT COALESCE(q1, 0) AS qq FROM int8_tbl a ) AS ss1
  FULL OUTER JOIN
  ( SELECT COALESCE(q2, -1) AS qq FROM int8_tbl b ) AS ss2
  USING (qq)
  INNER JOIN tenk1 c ON qq = unique2;


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


explain (costs off)
select * from
  int8_tbl t1 left join
  (select q1 as x, 42 as y from int8_tbl t2) ss
  on t1.q2 = ss.x
where
  1 = (select 1 from int8_tbl t3 where ss.y is not null limit 1)
order by 1,2;

select * from
  int8_tbl t1 left join
  (select q1 as x, 42 as y from int8_tbl t2) ss
  on t1.q2 = ss.x
where
  1 = (select 1 from int8_tbl t3 where ss.y is not null limit 1)
order by 1,2;


explain (costs off)
select * from
  int4_tbl as i41,
  lateral
    (select 1 as x from
      (select i41.f1 as lat,
              i42.f1 as loc from
         int8_tbl as i81, int4_tbl as i42) as ss1
      right join int4_tbl as i43 on (i43.f1 > 1)
      where ss1.loc = ss1.lat) as ss2
where i41.f1 > 0;

select * from
  int4_tbl as i41,
  lateral
    (select 1 as x from
      (select i41.f1 as lat,
              i42.f1 as loc from
         int8_tbl as i81, int4_tbl as i42) as ss1
      right join int4_tbl as i43 on (i43.f1 > 1)
      where ss1.loc = ss1.lat) as ss2
where i41.f1 > 0;

select * from int4_tbl a full join int4_tbl b on true;
select * from int4_tbl a full join int4_tbl b on false;


create temp table q1 as select 1 as q1;
create temp table q2 as select 0 as q2;
analyze q1;
analyze q2;

explain (costs off)
select * from
  tenk1 join int4_tbl on f1 = twothousand,
  q1, q2
where q1 = thousand or q2 = thousand;

explain (costs off)
select * from
  tenk1 join int4_tbl on f1 = twothousand,
  q1, q2
where thousand = (q1 + q2);


explain (costs off)
select * from
  tenk1, int8_tbl a, int8_tbl b
where thousand = a.q1 and tenthous = b.q1 and a.q2 = 1 and b.q2 = 2;


explain (costs off)
select t1.unique2, t1.stringu1, t2.unique1, t2.stringu2 from
  tenk1 t1
  inner join int4_tbl i1
    left join (select v1.x2, v2.y1, 11 AS d1
               from (select 1,0 from onerow) v1(x1,x2)
               left join (select 3,1 from onerow) v2(y1,y2)
               on v1.x1 = v2.y2) subq1
    on (i1.f1 = subq1.x2)
  on (t1.unique2 = subq1.d1)
  left join tenk1 t2
  on (subq1.y1 = t2.unique1)
where t1.unique2 < 42 and t1.stringu1 > t2.stringu2;

select t1.unique2, t1.stringu1, t2.unique1, t2.stringu2 from
  tenk1 t1
  inner join int4_tbl i1
    left join (select v1.x2, v2.y1, 11 AS d1
               from (select 1,0 from onerow) v1(x1,x2)
               left join (select 3,1 from onerow) v2(y1,y2)
               on v1.x1 = v2.y2) subq1
    on (i1.f1 = subq1.x2)
  on (t1.unique2 = subq1.d1)
  left join tenk1 t2
  on (subq1.y1 = t2.unique1)
where t1.unique2 < 42 and t1.stringu1 > t2.stringu2;


select ss1.d1 from
  tenk1 as t1
  inner join tenk1 as t2
  on t1.tenthous = t2.ten
  inner join
    int8_tbl as i8
    left join int4_tbl as i4
      inner join (select 64::information_schema.cardinal_number as d1
                  from tenk1 t3,
                       lateral (select abs(t3.unique1) + random()) ss0(x)
                  where t3.fivethous < 0) as ss1
      on i4.f1 = ss1.d1
    on i8.q1 = i4.f1
  on t1.tenthous = ss1.d1
where t1.unique1 < i4.f1;


explain (costs off)
select t1.unique2, t1.stringu1, t2.unique1, t2.stringu2 from
  tenk1 t1
  inner join int4_tbl i1
    left join (select v1.x2, v2.y1, 11 AS d1
               from (values(1,0)) v1(x1,x2)
               left join (values(3,1)) v2(y1,y2)
               on v1.x1 = v2.y2) subq1
    on (i1.f1 = subq1.x2)
  on (t1.unique2 = subq1.d1)
  left join tenk1 t2
  on (subq1.y1 = t2.unique1)
where t1.unique2 < 42 and t1.stringu1 > t2.stringu2;

select t1.unique2, t1.stringu1, t2.unique1, t2.stringu2 from
  tenk1 t1
  inner join int4_tbl i1
    left join (select v1.x2, v2.y1, 11 AS d1
               from (values(1,0)) v1(x1,x2)
               left join (values(3,1)) v2(y1,y2)
               on v1.x1 = v2.y2) subq1
    on (i1.f1 = subq1.x2)
  on (t1.unique2 = subq1.d1)
  left join tenk1 t2
  on (subq1.y1 = t2.unique1)
where t1.unique2 < 42 and t1.stringu1 > t2.stringu2;

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

explain (verbose, costs off)
select table_catalog, table_name
from int4_tbl t1
  inner join (int8_tbl t2
              left join information_schema.column_udt_usage on null)
  on null;

explain (verbose, costs off)
select * from int4_tbl left join (
  select text 'foo' union all select text 'bar'
) ss(x) on true
where ss.x is null;

create function f_immutable_int4(i integer) returns integer as
$$ begin return i; end; $$ language plpgsql immutable;

explain (costs off)
select unique1 from tenk1, (select * from f_immutable_int4(1) x) x
where x = unique1;

explain (verbose, costs off)
select unique1, x.*
from tenk1, (select *, random() from f_immutable_int4(1) x) x
where x = unique1;

explain (costs off)
select unique1 from tenk1, f_immutable_int4(1) x where x = unique1;

explain (costs off)
select unique1 from tenk1, lateral f_immutable_int4(1) x where x = unique1;

explain (costs off)
select unique1 from tenk1, lateral f_immutable_int4(1) x where x in (select 17);

explain (costs off)
select unique1, x from tenk1 join f_immutable_int4(1) x on unique1 = x;

explain (costs off)
select unique1, x from tenk1 left join f_immutable_int4(1) x on unique1 = x;

explain (costs off)
select unique1, x from tenk1 right join f_immutable_int4(1) x on unique1 = x;

explain (costs off)
select unique1, x from tenk1 full join f_immutable_int4(1) x on unique1 = x;

explain (costs off)
select unique1 from tenk1, f_immutable_int4(1) x where x = 42;

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


create function mki8(bigint, bigint) returns int8_tbl as
$$select row($1,$2)::int8_tbl$$ language sql;

create function mki4(int) returns int4_tbl as
$$select row($1)::int4_tbl$$ language sql;

explain (verbose, costs off)
select * from mki8(1,2);
select * from mki8(1,2);

explain (verbose, costs off)
select * from mki4(42);
select * from mki4(42);

drop function mki8(bigint, bigint);
drop function mki4(int);

create function f_field_select(t onek) returns int4 as
$$ select t.unique2; $$ language sql immutable;

explain (verbose, costs off)
select (t2.*).unique1, f_field_select(t2) from tenk1 t1
    left join onek t2 on t1.unique1 = t2.unique1
    left join int8_tbl t3 on true;

drop function f_field_select(t onek);


explain (costs off)
select * from tenk1 a join tenk1 b on
  (a.unique1 = 1 and b.unique1 = 2) or (a.unique2 = 3 and b.hundred = 4);
explain (costs off)
select * from tenk1 a join tenk1 b on
  (a.unique1 = 1 and b.unique1 = 2) or (a.unique2 = 3 and b.ten = 4);
explain (costs off)
select * from tenk1 a join tenk1 b on
  (a.unique1 = 1 and b.unique1 = 2) or
  ((a.unique2 = 3 or a.unique2 = 7) and b.hundred = 4);


explain (costs off)
select * from tenk1 t1 left join
  (tenk1 t2 join tenk1 t3 on t2.thousand = t3.unique2)
  on t1.hundred = t2.hundred and t1.ten = t3.ten
where t1.unique1 = 1;

explain (costs off)
select * from tenk1 t1 left join
  (tenk1 t2 join tenk1 t3 on t2.thousand = t3.unique2)
  on t1.hundred = t2.hundred and t1.ten + t2.ten = t3.ten
where t1.unique1 = 1;

explain (costs off)
select count(*) from
  tenk1 a join tenk1 b on a.unique1 = b.unique2
  left join tenk1 c on a.unique2 = b.unique1 and c.thousand = a.thousand
  join int4_tbl on b.thousand = f1;

select count(*) from
  tenk1 a join tenk1 b on a.unique1 = b.unique2
  left join tenk1 c on a.unique2 = b.unique1 and c.thousand = a.thousand
  join int4_tbl on b.thousand = f1;

explain (costs off)
select b.unique1 from
  tenk1 a join tenk1 b on a.unique1 = b.unique2
  left join tenk1 c on b.unique1 = 42 and c.thousand = a.thousand
  join int4_tbl i1 on b.thousand = f1
  right join int4_tbl i2 on i2.f1 = b.tenthous
  order by 1;

select b.unique1 from
  tenk1 a join tenk1 b on a.unique1 = b.unique2
  left join tenk1 c on b.unique1 = 42 and c.thousand = a.thousand
  join int4_tbl i1 on b.thousand = f1
  right join int4_tbl i2 on i2.f1 = b.tenthous
  order by 1;

explain (costs off)
select * from
(
  select unique1, q1, coalesce(unique1, -1) + q1 as fault
  from int8_tbl left join tenk1 on (q2 = unique2)
) ss
where fault = 122
order by fault;

select * from
(
  select unique1, q1, coalesce(unique1, -1) + q1 as fault
  from int8_tbl left join tenk1 on (q2 = unique2)
) ss
where fault = 122
order by fault;

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
select q1, unique2, thousand, hundred
  from int8_tbl a left join tenk1 b on q1 = unique2
  where coalesce(thousand,123) = q1 and q1 = coalesce(hundred,123);

select q1, unique2, thousand, hundred
  from int8_tbl a left join tenk1 b on q1 = unique2
  where coalesce(thousand,123) = q1 and q1 = coalesce(hundred,123);

explain (costs off)
select f1, unique2, case when unique2 is null then f1 else 0 end
  from int4_tbl a left join tenk1 b on f1 = unique2
  where (case when unique2 is null then f1 else 0 end) = 0;

select f1, unique2, case when unique2 is null then f1 else 0 end
  from int4_tbl a left join tenk1 b on f1 = unique2
  where (case when unique2 is null then f1 else 0 end) = 0;


explain (costs off)
select a.unique1, b.unique1, c.unique1, coalesce(b.twothousand, a.twothousand)
  from tenk1 a left join tenk1 b on b.thousand = a.unique1                        left join tenk1 c on c.unique2 = coalesce(b.twothousand, a.twothousand)
  where a.unique2 < 10 and coalesce(b.twothousand, a.twothousand) = 44;

select a.unique1, b.unique1, c.unique1, coalesce(b.twothousand, a.twothousand)
  from tenk1 a left join tenk1 b on b.thousand = a.unique1                        left join tenk1 c on c.unique2 = coalesce(b.twothousand, a.twothousand)
  where a.unique2 < 10 and coalesce(b.twothousand, a.twothousand) = 44;


explain (costs off)
select * from int8_tbl t1 left join int8_tbl t2 on t1.q2 = t2.q1,
  lateral (select * from int8_tbl t3 where t2.q1 = t2.q2) ss;

select * from int8_tbl t1 left join int8_tbl t2 on t1.q2 = t2.q1,
  lateral (select * from int8_tbl t3 where t2.q1 = t2.q2) ss;


explain (verbose, costs off)
select foo1.join_key as foo1_id, foo3.join_key AS foo3_id, bug_field from
  (values (0),(1)) foo1(join_key)
left join
  (select join_key, bug_field from
    (select ss1.join_key, ss1.bug_field from
      (select f1 as join_key, 666 as bug_field from int4_tbl i1) ss1
    ) foo2
   left join
    (select unique2 as join_key from tenk1 i2) ss2
   using (join_key)
  ) foo3
using (join_key);

select foo1.join_key as foo1_id, foo3.join_key AS foo3_id, bug_field from
  (values (0),(1)) foo1(join_key)
left join
  (select join_key, bug_field from
    (select ss1.join_key, ss1.bug_field from
      (select f1 as join_key, 666 as bug_field from int4_tbl i1) ss1
    ) foo2
   left join
    (select unique2 as join_key from tenk1 i2) ss2
   using (join_key)
  ) foo3
using (join_key);

explain (verbose, costs off)
select * from
int4_tbl i0 left join
( (select *, 123 as x from int4_tbl i1) ss1
  left join
  (select *, q2 as x from int8_tbl i2) ss2
  using (x)
) ss0
on (i0.f1 = ss0.f1)
order by i0.f1, x;

select * from
int4_tbl i0 left join
( (select *, 123 as x from int4_tbl i1) ss1
  left join
  (select *, q2 as x from int8_tbl i2) ss2
  using (x)
) ss0
on (i0.f1 = ss0.f1)
order by i0.f1, x;


explain (verbose, costs off)
select t1.* from
  text_tbl t1
  left join (select *, '***'::text as d1 from int8_tbl i8b1) b1
    left join int8_tbl i8
      left join (select *, null::int as d2 from int8_tbl i8b2) b2
      on (i8.q1 = b2.q1)
    on (b2.d2 = b1.q2)
  on (t1.f1 = b1.d1)
  left join int4_tbl i4
  on (i8.q2 = i4.f1);

select t1.* from
  text_tbl t1
  left join (select *, '***'::text as d1 from int8_tbl i8b1) b1
    left join int8_tbl i8
      left join (select *, null::int as d2 from int8_tbl i8b2) b2
      on (i8.q1 = b2.q1)
    on (b2.d2 = b1.q2)
  on (t1.f1 = b1.d1)
  left join int4_tbl i4
  on (i8.q2 = i4.f1);

explain (verbose, costs off)
select t1.* from
  text_tbl t1
  left join (select *, '***'::text as d1 from int8_tbl i8b1) b1
    left join int8_tbl i8
      left join (select *, null::int as d2 from int8_tbl i8b2, int4_tbl i4b2) b2
      on (i8.q1 = b2.q1)
    on (b2.d2 = b1.q2)
  on (t1.f1 = b1.d1)
  left join int4_tbl i4
  on (i8.q2 = i4.f1);

select t1.* from
  text_tbl t1
  left join (select *, '***'::text as d1 from int8_tbl i8b1) b1
    left join int8_tbl i8
      left join (select *, null::int as d2 from int8_tbl i8b2, int4_tbl i4b2) b2
      on (i8.q1 = b2.q1)
    on (b2.d2 = b1.q2)
  on (t1.f1 = b1.d1)
  left join int4_tbl i4
  on (i8.q2 = i4.f1);

explain (verbose, costs off)
select t1.* from
  text_tbl t1
  left join (select *, '***'::text as d1 from int8_tbl i8b1) b1
    left join int8_tbl i8
      left join (select *, null::int as d2 from int8_tbl i8b2, int4_tbl i4b2
                 where q1 = f1) b2
      on (i8.q1 = b2.q1)
    on (b2.d2 = b1.q2)
  on (t1.f1 = b1.d1)
  left join int4_tbl i4
  on (i8.q2 = i4.f1);

select t1.* from
  text_tbl t1
  left join (select *, '***'::text as d1 from int8_tbl i8b1) b1
    left join int8_tbl i8
      left join (select *, null::int as d2 from int8_tbl i8b2, int4_tbl i4b2
                 where q1 = f1) b2
      on (i8.q1 = b2.q1)
    on (b2.d2 = b1.q2)
  on (t1.f1 = b1.d1)
  left join int4_tbl i4
  on (i8.q2 = i4.f1);

explain (verbose, costs off)
select * from
  text_tbl t1
  inner join int8_tbl i8
  on i8.q2 = 456
  right join text_tbl t2
  on t1.f1 = 'doh!'
  left join int4_tbl i4
  on i8.q1 = i4.f1;

select * from
  text_tbl t1
  inner join int8_tbl i8
  on i8.q2 = 456
  right join text_tbl t2
  on t1.f1 = 'doh!'
  left join int4_tbl i4
  on i8.q1 = i4.f1;

explain (costs off)
select nspname
from (select 1 as x) ss1
left join
( select n.nspname, c.relname
  from pg_class c left join pg_namespace n on n.oid = c.relnamespace
  where c.relkind = 'r'
) ss2 on false;

explain (costs off)
select 1 from
  int4_tbl i4
  left join int8_tbl i8 on i4.f1 is not null
  left join (select 1 as a) ss1 on null
  join int4_tbl i42 on ss1.a is null or i8.q1 <> i8.q2
  right join (select 2 as b) ss2
  on ss2.b < i4.f1;


explain (verbose, costs off)
select * from
  text_tbl t1
  left join int8_tbl i8
  on i8.q2 = 123,
  lateral (select i8.q1, t2.f1 from text_tbl t2 limit 1) as ss
where t1.f1 = ss.f1;

select * from
  text_tbl t1
  left join int8_tbl i8
  on i8.q2 = 123,
  lateral (select i8.q1, t2.f1 from text_tbl t2 limit 1) as ss
where t1.f1 = ss.f1;

explain (verbose, costs off)
select * from
  text_tbl t1
  left join int8_tbl i8
  on i8.q2 = 123,
  lateral (select i8.q1, t2.f1 from text_tbl t2 limit 1) as ss1,
  lateral (select ss1.* from text_tbl t3 limit 1) as ss2
where t1.f1 = ss2.f1;

select * from
  text_tbl t1
  left join int8_tbl i8
  on i8.q2 = 123,
  lateral (select i8.q1, t2.f1 from text_tbl t2 limit 1) as ss1,
  lateral (select ss1.* from text_tbl t3 limit 1) as ss2
where t1.f1 = ss2.f1;

explain (verbose, costs off)
select 1 from
  text_tbl as tt1
  inner join text_tbl as tt2 on (tt1.f1 = 'foo')
  left join text_tbl as tt3 on (tt3.f1 = 'foo')
  left join text_tbl as tt4 on (tt3.f1 = tt4.f1),
  lateral (select tt4.f1 as c0 from text_tbl as tt5 limit 1) as ss1
where tt1.f1 = ss1.c0;

select 1 from
  text_tbl as tt1
  inner join text_tbl as tt2 on (tt1.f1 = 'foo')
  left join text_tbl as tt3 on (tt3.f1 = 'foo')
  left join text_tbl as tt4 on (tt3.f1 = tt4.f1),
  lateral (select tt4.f1 as c0 from text_tbl as tt5 limit 1) as ss1
where tt1.f1 = ss1.c0;

explain (verbose, costs off)
select 1 from
  int4_tbl as i4
  inner join
    ((select 42 as n from int4_tbl x1 left join int8_tbl x2 on f1 = q1) as ss1
     right join (select 1 as z) as ss2 on true)
  on false,
  lateral (select i4.f1, ss1.n from int8_tbl as i8 limit 1) as ss3;

select 1 from
  int4_tbl as i4
  inner join
    ((select 42 as n from int4_tbl x1 left join int8_tbl x2 on f1 = q1) as ss1
     right join (select 1 as z) as ss2 on true)
  on false,
  lateral (select i4.f1, ss1.n from int8_tbl as i8 limit 1) as ss3;


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


explain (verbose, costs off)
select ss2.* from
  int4_tbl i41
  left join int8_tbl i8
    join (select i42.f1 as c1, i43.f1 as c2, 42 as c3
          from int4_tbl i42, int4_tbl i43) ss1
    on i8.q1 = ss1.c2
  on i41.f1 = ss1.c1,
  lateral (select i41.*, i8.*, ss1.* from text_tbl limit 1) ss2
where ss1.c2 = 0;

select ss2.* from
  int4_tbl i41
  left join int8_tbl i8
    join (select i42.f1 as c1, i43.f1 as c2, 42 as c3
          from int4_tbl i42, int4_tbl i43) ss1
    on i8.q1 = ss1.c2
  on i41.f1 = ss1.c1,
  lateral (select i41.*, i8.*, ss1.* from text_tbl limit 1) ss2
where ss1.c2 = 0;


explain (costs off)
select * from
  (select 1 as id) as xx
  left join
    (tenk1 as a1 full join (select 1 as id) as yy on (a1.unique1 = yy.id))
  on (xx.id = coalesce(yy.id));

select * from
  (select 1 as id) as xx
  left join
    (tenk1 as a1 full join (select 1 as id) as yy on (a1.unique1 = yy.id))
  on (xx.id = coalesce(yy.id));


explain (costs off)
  select * from int4_tbl a left join tenk1 b on f1 = unique2 where f1 = 0;

explain (costs off)
  select * from tenk1 a full join tenk1 b using(unique2) where unique2 = 42;


set enable_hashjoin to off;
set enable_nestloop to off;

explain (verbose, costs off)
  select a.q2, b.q1
    from int8_tbl a left join int8_tbl b on a.q2 = coalesce(b.q1, 1)
    where coalesce(b.q1, 1) > 0;
select a.q2, b.q1
  from int8_tbl a left join int8_tbl b on a.q2 = coalesce(b.q1, 1)
  where coalesce(b.q1, 1) > 0;

reset enable_hashjoin;
reset enable_nestloop;


explain (costs off)
select a.unique1, b.unique2
  from onek a left join onek b on a.unique1 = b.unique2
  where (b.unique2, random() > 0) = any (select q1, random() > 0 from int8_tbl c where c.q1 < b.unique1);

select a.unique1, b.unique2
  from onek a left join onek b on a.unique1 = b.unique2
  where (b.unique2, random() > 0) = any (select q1, random() > 0 from int8_tbl c where c.q1 < b.unique1);


explain (costs off)
select a.unique1, b.unique2
  from onek a full join onek b on a.unique1 = b.unique2
  where a.unique1 = 42;

select a.unique1, b.unique2
  from onek a full join onek b on a.unique1 = b.unique2
  where a.unique1 = 42;

explain (costs off)
select a.unique1, b.unique2
  from onek a full join onek b on a.unique1 = b.unique2
  where b.unique2 = 43;

select a.unique1, b.unique2
  from onek a full join onek b on a.unique1 = b.unique2
  where b.unique2 = 43;

explain (costs off)
select a.unique1, b.unique2
  from onek a full join onek b on a.unique1 = b.unique2
  where a.unique1 = 42 and b.unique2 = 42;

select a.unique1, b.unique2
  from onek a full join onek b on a.unique1 = b.unique2
  where a.unique1 = 42 and b.unique2 = 42;


explain (costs off)
select * from
  (select * from int8_tbl i81 join (values(123,2)) v(v1,v2) on q2=v1) ss1
full join
  (select * from (values(456,2)) w(v1,v2) join int8_tbl i82 on q2=v1) ss2
on true;

select * from
  (select * from int8_tbl i81 join (values(123,2)) v(v1,v2) on q2=v1) ss1
full join
  (select * from (values(456,2)) w(v1,v2) join int8_tbl i82 on q2=v1) ss2
on true;


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

explain (costs off)
select ss1.f1
from int4_tbl as t1
  left join (int4_tbl as t2
             right join int4_tbl as t3 on null
             left join (int4_tbl as t4
                        right join int8_tbl as t5 on null)
               on t2.f1 = t4.f1
             left join ((select null as f1 from int4_tbl as t6) as ss1
                        inner join int8_tbl as t7 on null)
               on t5.q1 = t7.q2)
    on false;

explain (costs off)
select ss1.f1
from int4_tbl as t1
  left join (int4_tbl as t2
             right join int4_tbl as t3 on null
             left join (int4_tbl as t4
                        right join int8_tbl as t5 on null)
               on t2.f1 = t4.f1
             left join ((select f1 from int4_tbl as t6) as ss1
                        inner join int8_tbl as t7 on null)
               on t5.q1 = t7.q2)
    on false;

explain (costs off)
select ss1.x
from (select f1/2 as x from int4_tbl i4 left join a on a.id = i4.f1) ss1
     right join int8_tbl i8 on true
where current_user is not null;  

explain (costs off)
select *
from int8_tbl t1
  left join (int8_tbl t2 left join onek t3 on t2.q1 > t3.unique1)
    on t1.q2 = t2.q2
  left join onek t4
    on t2.q2 < t3.unique2;


explain (costs off)
select * from int8_tbl t1 left join
  (int8_tbl t2 inner join int8_tbl t3 on false
   left join int8_tbl t4 on t2.q2 = t4.q2)
on t1.q1 = t2.q1;

explain (costs off)
select * from int8_tbl t1 left join
  (int8_tbl t2 inner join int8_tbl t3 on (t2.q1-t3.q2) = 0 and (t2.q1-t3.q2) = 1
   left join int8_tbl t4 on t2.q2 = t4.q2)
on t1.q1 = t2.q1;

explain (costs off)
select exists(
  select * from int8_tbl t1 left join
    (int8_tbl t2 inner join int8_tbl t3 on x0.f1 = 1
     left join int8_tbl t4 on t2.q2 = t4.q2)
  on t1.q1 = t2.q1
) from int4_tbl x0;

explain (costs off)
select d.* from d left join (select * from b group by b.id, b.c_id) s
  on d.a = s.id and d.b = s.c_id;

explain (costs off)
select d.* from d left join (select distinct * from b) s
  on d.a = s.id and d.b = s.c_id;

explain (costs off)
select d.* from d left join (select * from b group by b.id, b.c_id) s
  on d.a = s.id;

explain (costs off)
select d.* from d left join (select distinct * from b) s
  on d.a = s.id;

explain (costs off)
select 1 from a t1
  left join (a t2 left join a t3 on t2.id = 1) on t2.id = 1;

explain (costs off)
select d.* from d left join (select id from a union select id from b) s
  on d.a = s.id;

explain (costs off)
select i8.* from int8_tbl i8 left join (select f1 from int4_tbl group by f1) i4
  on i8.q1 = i4.f1;

explain (costs off)
select 1 from (select a.id FROM a left join b on a.b_id = b.id) q,
			  lateral generate_series(1, q.id) gs(i) where q.id = gs.i;

explain (costs off)
select c.id, ss.a from c
  left join (select d.a from onerow, d left join b on d.a = b.id) ss
  on c.id = ss.a;

CREATE TEMP TABLE parted_b (id int PRIMARY KEY) partition by range(id);
CREATE TEMP TABLE parted_b1 partition of parted_b for values from (0) to (10);

explain (costs off)
select a.* from a left join parted_b pb on a.b_id = pb.id;

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

SELECT * FROM
    (SELECT 1 AS x) ss1
  LEFT JOIN
    (SELECT q1, q2, COALESCE(dat1, q1) AS y
     FROM int8_tbl LEFT JOIN innertab ON q2 = id) ss2
  ON true;

EXPLAIN (COSTS OFF)
SELECT q2 FROM
  (SELECT *
   FROM int8_tbl LEFT JOIN innertab ON q2 = id) ss
 WHERE COALESCE(dat1, 0) = q1;

EXPLAIN (VERBOSE, COSTS OFF)
SELECT q2 FROM
  (SELECT q2, 'constant'::text AS x
   FROM int8_tbl LEFT JOIN innertab ON q2 = id) ss
  RIGHT JOIN int4_tbl ON NULL
 WHERE x >= x;

EXPLAIN (COSTS OFF)
SELECT f1, x
FROM int4_tbl
     JOIN ((SELECT 42 AS x FROM int8_tbl LEFT JOIN innertab ON q1 = id) AS ss1
           RIGHT JOIN tenk1 ON NULL)
        ON tenk1.unique1 = ss1.x OR tenk1.unique2 = ss1.x;

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

explain (costs off)
select t0.*
from
 text_tbl t0
 left join
   (select case t1.ten when 0 then 'doh!'::text else null::text end as case1,
           t1.stringu2
     from tenk1 t1
     join int4_tbl i4 ON i4.f1 = t1.unique2
     left join uniquetbl u1 ON u1.f1 = t1.string4) ss
  on t0.f1 = ss.case1
where ss.stringu2 !~* ss.case1;

select t0.*
from
 text_tbl t0
 left join
   (select case t1.ten when 0 then 'doh!'::text else null::text end as case1,
           t1.stringu2
     from tenk1 t1
     join int4_tbl i4 ON i4.f1 = t1.unique2
     left join uniquetbl u1 ON u1.f1 = t1.string4) ss
  on t0.f1 = ss.case1
where ss.stringu2 !~* ss.case1;

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

explain (verbose, costs off)
select i8.*, ss.v, t.unique2
  from int8_tbl i8
    left join int4_tbl i4 on i4.f1 = 1
    left join lateral (select i4.f1 + 1 as v) as ss on true
    left join tenk1 t on t.unique2 = ss.v
where q2 = 456;

select i8.*, ss.v, t.unique2
  from int8_tbl i8
    left join int4_tbl i4 on i4.f1 = 1
    left join lateral (select i4.f1 + 1 as v) as ss on true
    left join tenk1 t on t.unique2 = ss.v
where q2 = 456;

create temp table parttbl (a integer primary key) partition by range (a);
create temp table parttbl1 partition of parttbl for values from (1) to (100);
insert into parttbl values (11), (12);
explain (costs off)
select * from
  (select *, 12 as phv from parttbl) as ss
  right join int4_tbl on true
where ss.a = ss.phv and f1 = 0;

select * from
  (select *, 12 as phv from parttbl) as ss
  right join int4_tbl on true
where ss.a = ss.phv and f1 = 0;


select * from
  int8_tbl x join (int4_tbl x cross join int4_tbl y) j on q1 = f1; 
select * from
  int8_tbl x join (int4_tbl x cross join int4_tbl y) j on q1 = y.f1; 
select * from
  int8_tbl x join (int4_tbl x cross join int4_tbl y(ff)) j on q1 = f1; 


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
select * from sj x join sj y on x.a = y.a
left join int8_tbl z on x.a = z.q1;

explain (costs off)
select * from sj x join sj y on x.a = y.a
left join int8_tbl z on y.a = z.q1;

explain (costs off)
select * from (
  select t1.*, t2.a as ax from sj t1 join sj t2
  on (t1.a = t2.a and t1.c * t1.c = t2.c + 2 and t2.b is null)
) as q1
left join
  (select t3.* from sj t3, sj t4 where t3.c = t4.c) as q2
on q1.ax = q2.a;

explain (costs off)
select * from (values (1)) x
left join (select coalesce(y.q1, 1) from int8_tbl y
	right join sj j1 inner join sj j2 on j1.a = j2.a
	on true) z
on true;

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

explain (verbose, costs off)
select 1 from (select y.* from sj x, sj y where x.a = y.a) q,
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
SELECT count(*) FROM emp1 c1, emp1 c2, emp1 c3
WHERE c1.id=c3.id AND c1.id*c3.id=c2.id*c2.id;

EXPLAIN (COSTS OFF)
SELECT count(*) FROM emp1 c1, emp1 c2, emp1 c3
WHERE c3.id=c2.id AND c3.id*c2.id=c1.id*c1.id;

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


select t1.uunique1 from
  tenk1 t1 join tenk2 t2 on t1.two = t2.two; 
select t2.uunique1 from
  tenk1 t1 join tenk2 t2 on t1.two = t2.two; 
select uunique1 from
  tenk1 t1 join tenk2 t2 on t1.two = t2.two; 
select ctid from
  tenk1 t1 join tenk2 t2 on t1.two = t2.two; 


select atts.relid::regclass, s.* from pg_stats s join
    pg_attribute a on s.attname = a.attname and s.tablename =
    a.attrelid::regclass::text join (select unnest(indkey) attnum,
    indexrelid from pg_index i) atts on atts.attnum = a.attnum where
    schemaname != 'pg_catalog';

explain (verbose, costs off)
select 1 from
  (select * from int8_tbl where q1 <> (select 42) offset 0) ss
where false;


select unique2, x.*
from tenk1 a, lateral (select * from int4_tbl b where f1 = a.unique1) x;
explain (costs off)
  select unique2, x.*
  from tenk1 a, lateral (select * from int4_tbl b where f1 = a.unique1) x;
select unique2, x.*
from int4_tbl x, lateral (select unique2 from tenk1 where f1 = unique1) ss;
explain (costs off)
  select unique2, x.*
  from int4_tbl x, lateral (select unique2 from tenk1 where f1 = unique1) ss;
explain (costs off)
  select unique2, x.*
  from int4_tbl x cross join lateral (select unique2 from tenk1 where f1 = unique1) ss;
select unique2, x.*
from int4_tbl x left join lateral (select unique1, unique2 from tenk1 where f1 = unique1) ss on true;
explain (costs off)
  select unique2, x.*
  from int4_tbl x left join lateral (select unique1, unique2 from tenk1 where f1 = unique1) ss on true;

select *, (select r from (select q1 as q2) x, (select q2 as r) y) from int8_tbl;
select *, (select r from (select q1 as q2) x, lateral (select q2 as r) y) from int8_tbl;

select count(*) from tenk1 a, lateral generate_series(1,two) g;
explain (costs off)
  select count(*) from tenk1 a, lateral generate_series(1,two) g;
explain (costs off)
  select count(*) from tenk1 a cross join lateral generate_series(1,two) g;
explain (costs off)
  select count(*) from tenk1 a, generate_series(1,two) g;

explain (costs off)
  select * from generate_series(100,200) g,
    lateral (select * from int8_tbl a where g = q1 union all
             select * from int8_tbl b where g = q2) ss;
select * from generate_series(100,200) g,
  lateral (select * from int8_tbl a where g = q1 union all
           select * from int8_tbl b where g = q2) ss;

explain (costs off)
  select count(*) from tenk1 a,
    tenk1 b join lateral (values(a.unique1)) ss(x) on b.unique2 = ss.x;
select count(*) from tenk1 a,
  tenk1 b join lateral (values(a.unique1)) ss(x) on b.unique2 = ss.x;

explain (costs off)
  select count(*) from tenk1 a,
    tenk1 b join lateral (values(a.unique1),(-1)) ss(x) on b.unique2 = ss.x;
select count(*) from tenk1 a,
  tenk1 b join lateral (values(a.unique1),(-1)) ss(x) on b.unique2 = ss.x;

explain (costs off)
  select * from int8_tbl a,
    int8_tbl x left join lateral (select a.q1 from int4_tbl y) ss(z)
      on x.q2 = ss.z
  order by a.q1, a.q2, x.q1, x.q2, ss.z;
select * from int8_tbl a,
  int8_tbl x left join lateral (select a.q1 from int4_tbl y) ss(z)
    on x.q2 = ss.z
  order by a.q1, a.q2, x.q1, x.q2, ss.z;

select * from (select f1/2 as x from int4_tbl) ss1 join int4_tbl i4 on x = f1,
  lateral (select x) ss2(y);
select * from (select f1 as x from int4_tbl) ss1 join int4_tbl i4 on x = f1,
  lateral (values(x)) ss2(y);
select * from ((select f1/2 as x from int4_tbl) ss1 join int4_tbl i4 on x = f1) j,
  lateral (select x) ss2(y);

select * from (values(1)) x(lb),
  lateral generate_series(lb,4) x4;
select * from (select f1/1000000000 from int4_tbl) x(lb),
  lateral generate_series(lb,4) x4;
select * from (values(1)) x(lb),
  lateral (values(lb)) y(lbcopy);
select * from (values(1)) x(lb),
  lateral (select lb from int4_tbl) y(lbcopy);
select * from
  int8_tbl x left join (select q1,coalesce(q2,0) q2 from int8_tbl) y on x.q2 = y.q1,
  lateral (values(x.q1,y.q1,y.q2)) v(xq1,yq1,yq2);
select * from
  int8_tbl x left join (select q1,coalesce(q2,0) q2 from int8_tbl) y on x.q2 = y.q1,
  lateral (select x.q1,y.q1,y.q2) v(xq1,yq1,yq2);
select x.* from
  int8_tbl x left join (select q1,coalesce(q2,0) q2 from int8_tbl) y on x.q2 = y.q1,
  lateral (select x.q1,y.q1,y.q2) v(xq1,yq1,yq2);
select v.* from
  (int8_tbl x left join (select q1,coalesce(q2,0) q2 from int8_tbl) y on x.q2 = y.q1)
  left join int4_tbl z on z.f1 = x.q2,
  lateral (select x.q1,y.q1 union all select x.q2,y.q2) v(vx,vy);
select v.* from
  (int8_tbl x left join (select q1,(select coalesce(q2,0)) q2 from int8_tbl) y on x.q2 = y.q1)
  left join int4_tbl z on z.f1 = x.q2,
  lateral (select x.q1,y.q1 union all select x.q2,y.q2) v(vx,vy);
select v.* from
  (int8_tbl x left join (select q1,(select coalesce(q2,0)) q2 from int8_tbl) y on x.q2 = y.q1)
  left join int4_tbl z on z.f1 = x.q2,
  lateral (select x.q1,y.q1 from onerow union all select x.q2,y.q2 from onerow) v(vx,vy);

explain (verbose, costs off)
select * from
  int8_tbl a left join
  lateral (select *, a.q2 as x from int8_tbl b) ss on a.q2 = ss.q1;
select * from
  int8_tbl a left join
  lateral (select *, a.q2 as x from int8_tbl b) ss on a.q2 = ss.q1;
explain (verbose, costs off)
select * from
  int8_tbl a left join
  lateral (select *, coalesce(a.q2, 42) as x from int8_tbl b) ss on a.q2 = ss.q1;
select * from
  int8_tbl a left join
  lateral (select *, coalesce(a.q2, 42) as x from int8_tbl b) ss on a.q2 = ss.q1;

explain (verbose, costs off)
select * from int4_tbl i left join
  lateral (select * from int2_tbl j where i.f1 = j.f1) k on true;
select * from int4_tbl i left join
  lateral (select * from int2_tbl j where i.f1 = j.f1) k on true;
explain (verbose, costs off)
select * from int4_tbl i left join
  lateral (select coalesce(i) from int2_tbl j where i.f1 = j.f1) k on true;
select * from int4_tbl i left join
  lateral (select coalesce(i) from int2_tbl j where i.f1 = j.f1) k on true;
explain (verbose, costs off)
select * from int4_tbl a,
  lateral (
    select * from int4_tbl b left join int8_tbl c on (b.f1 = q1 and a.f1 = q2)
  ) ss;
select * from int4_tbl a,
  lateral (
    select * from int4_tbl b left join int8_tbl c on (b.f1 = q1 and a.f1 = q2)
  ) ss;

explain (verbose, costs off)
select * from
  int8_tbl a left join lateral
  (select b.q1 as bq1, c.q1 as cq1, least(a.q1,b.q1,c.q1) from
   int8_tbl b cross join int8_tbl c) ss
  on a.q2 = ss.bq1;
select * from
  int8_tbl a left join lateral
  (select b.q1 as bq1, c.q1 as cq1, least(a.q1,b.q1,c.q1) from
   int8_tbl b cross join int8_tbl c) ss
  on a.q2 = ss.bq1;

explain (verbose, costs off)
select * from
  int8_tbl c left join (
    int8_tbl a left join (select q1, coalesce(q2,42) as x from int8_tbl b) ss1
      on a.q2 = ss1.q1
    cross join
    lateral (select q1, coalesce(ss1.x,q2) as y from int8_tbl d) ss2
  ) on c.q2 = ss2.q1,
  lateral (select ss2.y offset 0) ss3;

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
select c.*,a.*,ss1.q1,ss2.q1,ss3.* from
  int8_tbl c left join (
    int8_tbl a left join
      (select q1, coalesce(q2,f1) as x from int8_tbl b, int4_tbl b2
       where q1 < f1) ss1
      on a.q2 = ss1.q1
    cross join
    lateral (select q1, coalesce(ss1.x,q2) as y from int8_tbl d) ss2
  ) on c.q2 = ss2.q1,
  lateral (select * from int4_tbl i where ss2.y > f1) ss3;

explain (verbose, costs off)
select * from
  (select 1 as x offset 0) x cross join (select 2 as y offset 0) y
  left join lateral (
    select * from (select 3 as z offset 0) z where z.z = x.x
  ) zz on zz.z = y.y;

explain (costs off)
select * from int4_tbl t1,
  lateral (select * from int4_tbl t2 inner join int4_tbl t3 on t1.f1 = 1
           inner join (int4_tbl t4 left join int4_tbl t5 on true) on true) ss;

explain (verbose, costs off)
select * from int8_tbl i8 left join lateral
  (select *, i8.q2 from int4_tbl where false) ss on true;
explain (verbose, costs off)
select * from int8_tbl i8 left join lateral
  (select *, i8.q2 from int4_tbl i1, int4_tbl i2 where false) ss on true;

select * from
  ((select 2 as v) union all (select 3 as v)) as q1
  cross join lateral
  ((select * from
      ((select 4 as v) union all (select 5 as v)) as q3)
   union all
   (select q1.v)
  ) as q2;

SELECT * FROM (int8_tbl i cross join int4_tbl j) ss(a,b,c,d);

explain (verbose, costs off)
select * from
  (values (0,9998), (1,1000)) v(id,x),
  lateral (select f1 from int4_tbl
           where f1 = any (select unique1 from tenk1
                           where unique2 = v.x offset 0)) ss;
select * from
  (values (0,9998), (1,1000)) v(id,x),
  lateral (select f1 from int4_tbl
           where f1 = any (select unique1 from tenk1
                           where unique2 = v.x offset 0)) ss;

explain (verbose, costs off)
select * from (values (0), (1)) v(id),
lateral (select * from int8_tbl t1,
         lateral (select * from
                    (select * from int8_tbl t2
                     where (q1, random() > 0) = any (select q2, random() > 0 from int8_tbl t3
                                     where q2 = (select greatest(t1.q1,t2.q2))
                                       and (select v.id=0)) offset 0) ss2) ss
         where t1.q1 = ss.q2) ss0;

select * from (values (0), (1)) v(id),
lateral (select * from int8_tbl t1,
         lateral (select * from
                    (select * from int8_tbl t2
                     where (q1, random() > 0) = any (select q2, random() > 0 from int8_tbl t3
                                     where q2 = (select greatest(t1.q1,t2.q2))
                                       and (select v.id=0)) offset 0) ss2) ss
         where t1.q1 = ss.q2) ss0;

select f1,g from int4_tbl a, (select f1 as g) ss;
select f1,g from int4_tbl a, (select a.f1 as g) ss;
select f1,g from int4_tbl a cross join (select f1 as g) ss;
select f1,g from int4_tbl a cross join (select a.f1 as g) ss;
select f1,g from int4_tbl a right join lateral generate_series(0, a.f1) g on true;
select f1,g from int4_tbl a full join lateral generate_series(0, a.f1) g on true;
select * from
  int8_tbl x cross join (int4_tbl x cross join lateral (select x.f1) ss);
select 1 from tenk1 a, lateral (select max(a.unique1) from int4_tbl b) ss;


create temp table xx1 as select f1 as x1, -f1 as x2 from int4_tbl;

update xx1 set x2 = f1 from (select * from int4_tbl where f1 = x1) ss;
update xx1 set x2 = f1 from (select * from int4_tbl where f1 = xx1.x1) ss;
update xx1 set x2 = f1 from lateral (select * from int4_tbl where f1 = x1) ss;
update xx1 set x2 = f1 from xx1, lateral (select * from int4_tbl where f1 = x1) ss;

delete from xx1 using (select * from int4_tbl where f1 = x1) ss;
delete from xx1 using (select * from int4_tbl where f1 = xx1.x1) ss;
delete from xx1 using lateral (select * from int4_tbl where f1 = x1) ss;

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

explain (verbose, costs off)
select t1.unique1, t2.hundred
from onek t1, tenk1 t2
where exists (select 1 from tenk1 t3
              where t3.thousand = t1.unique1 and t3.tenthous = t2.hundred)
      and t1.unique1 < 1;

create table j3 as select unique1, tenthous from onek;
vacuum analyze j3;
create unique index on j3(unique1, tenthous);

explain (verbose, costs off)
select t1.unique1, t2.hundred
from onek t1, tenk1 t2
where exists (select 1 from j3
              where j3.unique1 = t1.unique1 and j3.tenthous = t2.hundred)
      and t1.unique1 < 1;

drop table j3;
