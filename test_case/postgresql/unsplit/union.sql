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
(SELECT 1,2,3 UNION SELECT 4,5,6) INTERSECT SELECT 4,5,6;
(SELECT 1,2,3 UNION SELECT 4,5,6 ORDER BY 1,2) INTERSECT SELECT 4,5,6;
(SELECT 1,2,3 UNION SELECT 4,5,6) EXCEPT SELECT 4,5,6;
(SELECT 1,2,3 UNION SELECT 4,5,6 ORDER BY 1,2) EXCEPT SELECT 4,5,6;
set enable_hashagg to on;
set enable_hashagg to off;
reset enable_hashagg;
set enable_hashagg to on;
explain (costs off)
select x from (values ('11'::varbit), ('10'::varbit)) _(x) union select x from (values ('11'::varbit), ('10'::varbit)) _(x);
set enable_hashagg to off;
reset enable_hashagg;
set enable_hashagg to on;
select x from (values (array[1, 2]), (array[1, 3])) _(x) union select x from (values (array[1, 2]), (array[1, 4])) _(x);
set enable_hashagg to off;
reset enable_hashagg;
set enable_hashagg to on;
create type ct1 as (f1 varbit);
drop type ct1;
set enable_hashagg to off;
reset enable_hashagg;
select union select;
select intersect select;
select except select;
set enable_hashagg = true;
set enable_sort = false;
explain (costs off)
select from generate_series(1,5) intersect select from generate_series(1,3);
select from generate_series(1,5) union all select from generate_series(1,3);
set enable_hashagg = false;
set enable_sort = true;
reset enable_hashagg;
reset enable_sort;
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
create function expensivefunc(int) returns int
language plpgsql immutable strict cost 10000
as $$begin return $1; end$$;
create temp table t3 as select generate_series(-1000,1000) as x;
create index t3i on t3 (expensivefunc(x));
analyze t3;
drop table t3;
drop function expensivefunc(int);
