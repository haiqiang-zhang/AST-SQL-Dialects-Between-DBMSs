

SELECT 1 AS two UNION SELECT 2 ORDER BY 1;

SELECT 1 AS one UNION SELECT 1 ORDER BY 1;

SELECT 1 AS two UNION ALL SELECT 2;

SELECT 1 AS two UNION ALL SELECT 1;

SELECT 1 AS three UNION SELECT 2 UNION SELECT 3 ORDER BY 1;

SELECT 1 AS two UNION SELECT 2 UNION SELECT 2 ORDER BY 1;

SELECT 1 AS three UNION SELECT 2 UNION ALL SELECT 2 ORDER BY 1;

SELECT 1.1 AS two UNION SELECT 2.2 ORDER BY 1;


SELECT 1.1 AS two UNION SELECT 2 ORDER BY 1;

SELECT 1 AS two UNION SELECT 2.2 ORDER BY 1;

SELECT 1 AS one UNION SELECT 1.0::float8 ORDER BY 1;

SELECT 1.1 AS two UNION ALL SELECT 2 ORDER BY 1;

SELECT 1.0::float8 AS two UNION ALL SELECT 1 ORDER BY 1;

SELECT 1.1 AS three UNION SELECT 2 UNION SELECT 3 ORDER BY 1;

SELECT 1.1::float8 AS two UNION SELECT 2 UNION SELECT 2.0::float8 ORDER BY 1;

SELECT 1.1 AS three UNION SELECT 2 UNION ALL SELECT 2 ORDER BY 1;

SELECT 1.1 AS two UNION (SELECT 2 UNION ALL SELECT 2) ORDER BY 1;


SELECT f1 AS five FROM FLOAT8_TBL
UNION
SELECT f1 FROM FLOAT8_TBL
ORDER BY 1;

SELECT f1 AS ten FROM FLOAT8_TBL
UNION ALL
SELECT f1 FROM FLOAT8_TBL;

SELECT f1 AS nine FROM FLOAT8_TBL
UNION
SELECT f1 FROM INT4_TBL
ORDER BY 1;

SELECT f1 AS ten FROM FLOAT8_TBL
UNION ALL
SELECT f1 FROM INT4_TBL;

SELECT f1 AS five FROM FLOAT8_TBL
  WHERE f1 BETWEEN -1e6 AND 1e6
UNION
SELECT f1 FROM INT4_TBL
  WHERE f1 BETWEEN 0 AND 1000000
ORDER BY 1;

SELECT CAST(f1 AS char(4)) AS three FROM VARCHAR_TBL
UNION
SELECT f1 FROM CHAR_TBL
ORDER BY 1;

SELECT f1 AS three FROM VARCHAR_TBL
UNION
SELECT CAST(f1 AS varchar) FROM CHAR_TBL
ORDER BY 1;

SELECT f1 AS eight FROM VARCHAR_TBL
UNION ALL
SELECT f1 FROM CHAR_TBL;

SELECT f1 AS five FROM TEXT_TBL
UNION
SELECT f1 FROM VARCHAR_TBL
UNION
SELECT TRIM(TRAILING FROM f1) FROM CHAR_TBL
ORDER BY 1;


SELECT q2 FROM int8_tbl INTERSECT SELECT q1 FROM int8_tbl ORDER BY 1;

SELECT q2 FROM int8_tbl INTERSECT ALL SELECT q1 FROM int8_tbl ORDER BY 1;

SELECT q2 FROM int8_tbl EXCEPT SELECT q1 FROM int8_tbl ORDER BY 1;

SELECT q2 FROM int8_tbl EXCEPT ALL SELECT q1 FROM int8_tbl ORDER BY 1;

SELECT q2 FROM int8_tbl EXCEPT ALL SELECT DISTINCT q1 FROM int8_tbl ORDER BY 1;

SELECT q1 FROM int8_tbl EXCEPT SELECT q2 FROM int8_tbl ORDER BY 1;

SELECT q1 FROM int8_tbl EXCEPT ALL SELECT q2 FROM int8_tbl ORDER BY 1;

SELECT q1 FROM int8_tbl EXCEPT ALL SELECT DISTINCT q2 FROM int8_tbl ORDER BY 1;

SELECT q1 FROM int8_tbl EXCEPT ALL SELECT q1 FROM int8_tbl FOR NO KEY UPDATE;

(SELECT 1,2,3 UNION SELECT 4,5,6) INTERSECT SELECT 4,5,6;
(SELECT 1,2,3 UNION SELECT 4,5,6 ORDER BY 1,2) INTERSECT SELECT 4,5,6;
(SELECT 1,2,3 UNION SELECT 4,5,6) EXCEPT SELECT 4,5,6;
(SELECT 1,2,3 UNION SELECT 4,5,6 ORDER BY 1,2) EXCEPT SELECT 4,5,6;


set enable_hashagg to on;

explain (costs off)
select count(*) from
  ( select unique1 from tenk1 union select fivethous from tenk1 ) ss;
select count(*) from
  ( select unique1 from tenk1 union select fivethous from tenk1 ) ss;

explain (costs off)
select count(*) from
  ( select unique1 from tenk1 intersect select fivethous from tenk1 ) ss;
select count(*) from
  ( select unique1 from tenk1 intersect select fivethous from tenk1 ) ss;

explain (costs off)
select unique1 from tenk1 except select unique2 from tenk1 where unique2 != 10;
select unique1 from tenk1 except select unique2 from tenk1 where unique2 != 10;

set enable_hashagg to off;

explain (costs off)
select count(*) from
  ( select unique1 from tenk1 union select fivethous from tenk1 ) ss;
select count(*) from
  ( select unique1 from tenk1 union select fivethous from tenk1 ) ss;

explain (costs off)
select count(*) from
  ( select unique1 from tenk1 intersect select fivethous from tenk1 ) ss;
select count(*) from
  ( select unique1 from tenk1 intersect select fivethous from tenk1 ) ss;

explain (costs off)
select unique1 from tenk1 except select unique2 from tenk1 where unique2 != 10;
select unique1 from tenk1 except select unique2 from tenk1 where unique2 != 10;

reset enable_hashagg;

set enable_hashagg to on;

explain (costs off)
select x from (values ('11'::varbit), ('10'::varbit)) _(x) union select x from (values ('11'::varbit), ('10'::varbit)) _(x);

set enable_hashagg to off;

explain (costs off)
select x from (values ('11'::varbit), ('10'::varbit)) _(x) union select x from (values ('11'::varbit), ('10'::varbit)) _(x);

reset enable_hashagg;

set enable_hashagg to on;

explain (costs off)
select x from (values (array[1, 2]), (array[1, 3])) _(x) union select x from (values (array[1, 2]), (array[1, 4])) _(x);
select x from (values (array[1, 2]), (array[1, 3])) _(x) union select x from (values (array[1, 2]), (array[1, 4])) _(x);
explain (costs off)
select x from (values (array[1, 2]), (array[1, 3])) _(x) intersect select x from (values (array[1, 2]), (array[1, 4])) _(x);
select x from (values (array[1, 2]), (array[1, 3])) _(x) intersect select x from (values (array[1, 2]), (array[1, 4])) _(x);
explain (costs off)
select x from (values (array[1, 2]), (array[1, 3])) _(x) except select x from (values (array[1, 2]), (array[1, 4])) _(x);
select x from (values (array[1, 2]), (array[1, 3])) _(x) except select x from (values (array[1, 2]), (array[1, 4])) _(x);

explain (costs off)
select x from (values (array['10'::varbit]), (array['11'::varbit])) _(x) union select x from (values (array['10'::varbit]), (array['01'::varbit])) _(x);
select x from (values (array['10'::varbit]), (array['11'::varbit])) _(x) union select x from (values (array['10'::varbit]), (array['01'::varbit])) _(x);

set enable_hashagg to off;

explain (costs off)
select x from (values (array[1, 2]), (array[1, 3])) _(x) union select x from (values (array[1, 2]), (array[1, 4])) _(x);
select x from (values (array[1, 2]), (array[1, 3])) _(x) union select x from (values (array[1, 2]), (array[1, 4])) _(x);
explain (costs off)
select x from (values (array[1, 2]), (array[1, 3])) _(x) intersect select x from (values (array[1, 2]), (array[1, 4])) _(x);
select x from (values (array[1, 2]), (array[1, 3])) _(x) intersect select x from (values (array[1, 2]), (array[1, 4])) _(x);
explain (costs off)
select x from (values (array[1, 2]), (array[1, 3])) _(x) except select x from (values (array[1, 2]), (array[1, 4])) _(x);
select x from (values (array[1, 2]), (array[1, 3])) _(x) except select x from (values (array[1, 2]), (array[1, 4])) _(x);

reset enable_hashagg;

set enable_hashagg to on;

explain (costs off)
select x from (values (row(1, 2)), (row(1, 3))) _(x) union select x from (values (row(1, 2)), (row(1, 4))) _(x);
select x from (values (row(1, 2)), (row(1, 3))) _(x) union select x from (values (row(1, 2)), (row(1, 4))) _(x);
explain (costs off)
select x from (values (row(1, 2)), (row(1, 3))) _(x) intersect select x from (values (row(1, 2)), (row(1, 4))) _(x);
select x from (values (row(1, 2)), (row(1, 3))) _(x) intersect select x from (values (row(1, 2)), (row(1, 4))) _(x);
explain (costs off)
select x from (values (row(1, 2)), (row(1, 3))) _(x) except select x from (values (row(1, 2)), (row(1, 4))) _(x);
select x from (values (row(1, 2)), (row(1, 3))) _(x) except select x from (values (row(1, 2)), (row(1, 4))) _(x);


explain (costs off)
select x from (values (row('10'::varbit)), (row('11'::varbit))) _(x) union select x from (values (row('10'::varbit)), (row('01'::varbit))) _(x);
select x from (values (row('10'::varbit)), (row('11'::varbit))) _(x) union select x from (values (row('10'::varbit)), (row('01'::varbit))) _(x);

create type ct1 as (f1 varbit);
explain (costs off)
select x from (values (row('10'::varbit)::ct1), (row('11'::varbit)::ct1)) _(x) union select x from (values (row('10'::varbit)::ct1), (row('01'::varbit)::ct1)) _(x);
select x from (values (row('10'::varbit)::ct1), (row('11'::varbit)::ct1)) _(x) union select x from (values (row('10'::varbit)::ct1), (row('01'::varbit)::ct1)) _(x);
drop type ct1;

set enable_hashagg to off;

explain (costs off)
select x from (values (row(1, 2)), (row(1, 3))) _(x) union select x from (values (row(1, 2)), (row(1, 4))) _(x);
select x from (values (row(1, 2)), (row(1, 3))) _(x) union select x from (values (row(1, 2)), (row(1, 4))) _(x);
explain (costs off)
select x from (values (row(1, 2)), (row(1, 3))) _(x) intersect select x from (values (row(1, 2)), (row(1, 4))) _(x);
select x from (values (row(1, 2)), (row(1, 3))) _(x) intersect select x from (values (row(1, 2)), (row(1, 4))) _(x);
explain (costs off)
select x from (values (row(1, 2)), (row(1, 3))) _(x) except select x from (values (row(1, 2)), (row(1, 4))) _(x);
select x from (values (row(1, 2)), (row(1, 3))) _(x) except select x from (values (row(1, 2)), (row(1, 4))) _(x);

reset enable_hashagg;


SELECT f1 FROM float8_tbl INTERSECT SELECT f1 FROM int4_tbl ORDER BY 1;

SELECT f1 FROM float8_tbl EXCEPT SELECT f1 FROM int4_tbl ORDER BY 1;


SELECT q1 FROM int8_tbl INTERSECT SELECT q2 FROM int8_tbl UNION ALL SELECT q2 FROM int8_tbl  ORDER BY 1;

SELECT q1 FROM int8_tbl INTERSECT (((SELECT q2 FROM int8_tbl UNION ALL SELECT q2 FROM int8_tbl))) ORDER BY 1;

(((SELECT q1 FROM int8_tbl INTERSECT SELECT q2 FROM int8_tbl ORDER BY 1))) UNION ALL SELECT q2 FROM int8_tbl;

SELECT q1 FROM int8_tbl UNION ALL SELECT q2 FROM int8_tbl EXCEPT SELECT q1 FROM int8_tbl ORDER BY 1;

SELECT q1 FROM int8_tbl UNION ALL (((SELECT q2 FROM int8_tbl EXCEPT SELECT q1 FROM int8_tbl ORDER BY 1)));

(((SELECT q1 FROM int8_tbl UNION ALL SELECT q2 FROM int8_tbl))) EXCEPT SELECT q1 FROM int8_tbl ORDER BY 1;


SELECT q1,q2 FROM int8_tbl EXCEPT SELECT q2,q1 FROM int8_tbl
ORDER BY q2,q1;

SELECT q1 FROM int8_tbl EXCEPT SELECT q2 FROM int8_tbl ORDER BY q2 LIMIT 1;

SELECT q1 FROM int8_tbl EXCEPT (((SELECT q2 FROM int8_tbl ORDER BY q2 LIMIT 1))) ORDER BY 1;


(((((select * from int8_tbl)))));


select union select;
select intersect select;
select except select;

set enable_hashagg = true;
set enable_sort = false;

explain (costs off)
select from generate_series(1,5) intersect select from generate_series(1,3);

select from generate_series(1,5) union all select from generate_series(1,3);
select from generate_series(1,5) intersect select from generate_series(1,3);
select from generate_series(1,5) intersect all select from generate_series(1,3);
select from generate_series(1,5) except select from generate_series(1,3);
select from generate_series(1,5) except all select from generate_series(1,3);

set enable_hashagg = false;
set enable_sort = true;

explain (costs off)
select from generate_series(1,5) union select from generate_series(1,3);
explain (costs off)
select from generate_series(1,5) intersect select from generate_series(1,3);

select from generate_series(1,5) union select from generate_series(1,3);
select from generate_series(1,5) union all select from generate_series(1,3);
select from generate_series(1,5) intersect select from generate_series(1,3);
select from generate_series(1,5) intersect all select from generate_series(1,3);
select from generate_series(1,5) except select from generate_series(1,3);
select from generate_series(1,5) except all select from generate_series(1,3);

reset enable_hashagg;
reset enable_sort;


SELECT a.f1 FROM (SELECT 'test' AS f1 FROM varchar_tbl) a
UNION
SELECT b.f1 FROM (SELECT f1 FROM varchar_tbl) b
ORDER BY 1;

SELECT '3.4'::numeric UNION SELECT 'foo';


CREATE TEMP TABLE t1 (a text, b text);
CREATE INDEX t1_ab_idx on t1 ((a || b));
CREATE TEMP TABLE t2 (ab text primary key);
INSERT INTO t1 VALUES ('a', 'b'), ('x', 'y');
INSERT INTO t2 VALUES ('ab'), ('xy');

set enable_seqscan = off;
set enable_indexscan = on;
set enable_bitmapscan = off;
set enable_sort = off;

explain (costs off)
 SELECT * FROM
 (SELECT a || b AS ab FROM t1
  UNION ALL
  SELECT * FROM t2) t
 WHERE ab = 'ab';

explain (costs off)
 SELECT * FROM
 (SELECT a || b AS ab FROM t1
  UNION
  SELECT * FROM t2) t
 WHERE ab = 'ab';


CREATE TEMP TABLE t1c (b text, a text);
ALTER TABLE t1c INHERIT t1;
CREATE TEMP TABLE t2c (primary key (ab)) INHERITS (t2);
INSERT INTO t1c VALUES ('v', 'w'), ('c', 'd'), ('m', 'n'), ('e', 'f');
INSERT INTO t2c VALUES ('vw'), ('cd'), ('mn'), ('ef');
CREATE INDEX t1c_ab_idx on t1c ((a || b));

set enable_seqscan = on;
set enable_indexonlyscan = off;

explain (costs off)
  SELECT * FROM
  (SELECT a || b AS ab FROM t1
   UNION ALL
   SELECT ab FROM t2) t
  ORDER BY 1 LIMIT 8;

  SELECT * FROM
  (SELECT a || b AS ab FROM t1
   UNION ALL
   SELECT ab FROM t2) t
  ORDER BY 1 LIMIT 8;

reset enable_seqscan;
reset enable_indexscan;
reset enable_bitmapscan;
reset enable_sort;


create table events (event_id int primary key);
create table other_events (event_id int primary key);
create table events_child () inherits (events);

explain (costs off)
select event_id
 from (select event_id from events
       union all
       select event_id from other_events) ss
 order by event_id;

drop table events_child, events, other_events;

reset enable_indexonlyscan;

explain (costs off)
 SELECT * FROM
  (SELECT 1 AS t, * FROM tenk1 a
   UNION ALL
   SELECT 2 AS t, * FROM tenk1 b) c
 WHERE t = 2;

explain (costs off)
SELECT * FROM
  (SELECT 1 AS t, 2 AS x
   UNION
   SELECT 2 AS t, 4 AS x) ss
WHERE x < 4
ORDER BY x;

SELECT * FROM
  (SELECT 1 AS t, 2 AS x
   UNION
   SELECT 2 AS t, 4 AS x) ss
WHERE x < 4
ORDER BY x;

explain (costs off)
SELECT * FROM
  (SELECT 1 AS t, generate_series(1,10) AS x
   UNION
   SELECT 2 AS t, 4 AS x) ss
WHERE x < 4
ORDER BY x;

SELECT * FROM
  (SELECT 1 AS t, generate_series(1,10) AS x
   UNION
   SELECT 2 AS t, 4 AS x) ss
WHERE x < 4
ORDER BY x;

explain (costs off)
SELECT * FROM
  (SELECT 1 AS t, (random()*3)::int AS x
   UNION
   SELECT 2 AS t, 4 AS x) ss
WHERE x > 3
ORDER BY x;

SELECT * FROM
  (SELECT 1 AS t, (random()*3)::int AS x
   UNION
   SELECT 2 AS t, 4 AS x) ss
WHERE x > 3
ORDER BY x;

explain (costs off)
select distinct q1 from
  (select distinct * from int8_tbl i81
   union all
   select distinct * from int8_tbl i82) ss
where q2 = q2;

select distinct q1 from
  (select distinct * from int8_tbl i81
   union all
   select distinct * from int8_tbl i82) ss
where q2 = q2;

explain (costs off)
select distinct q1 from
  (select distinct * from int8_tbl i81
   union all
   select distinct * from int8_tbl i82) ss
where -q1 = q2;

select distinct q1 from
  (select distinct * from int8_tbl i81
   union all
   select distinct * from int8_tbl i82) ss
where -q1 = q2;

create function expensivefunc(int) returns int
language plpgsql immutable strict cost 10000
as $$begin return $1; end$$;

create temp table t3 as select generate_series(-1000,1000) as x;
create index t3i on t3 (expensivefunc(x));
analyze t3;

explain (costs off)
select * from
  (select * from t3 a union all select * from t3 b) ss
  join int4_tbl on f1 = expensivefunc(x);
select * from
  (select * from t3 a union all select * from t3 b) ss
  join int4_tbl on f1 = expensivefunc(x);

drop table t3;
drop function expensivefunc(int);

explain (costs off)
select * from
  (select *, 0 as x from int8_tbl a
   union all
   select *, 1 as x from int8_tbl b) ss
where (x = 0) or (q1 >= q2 and q1 <= q2);
select * from
  (select *, 0 as x from int8_tbl a
   union all
   select *, 1 as x from int8_tbl b) ss
where (x = 0) or (q1 >= q2 and q1 <= q2);


explain (costs off)
select t1.unique1 from tenk1 t1
inner join tenk2 t2 on t1.tenthous = t2.tenthous and t2.thousand = 0
   union all
(values(1)) limit 1;

explain (costs off)
select * from tenk1 t1
left join lateral
  (select t1.tenthous from tenk2 t2 union all (values(1)))
on true limit 1;
