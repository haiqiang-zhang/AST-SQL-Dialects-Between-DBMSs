select a,ord from unnest(array['a','b']) with ordinality as z(a,ord);
select * from unnest(array['a','b']) with ordinality as z(a,ord);
select a,ord from unnest(array[1.0::float8]) with ordinality as z(a,ord);
select * from unnest(array[1.0::float8]) with ordinality as z(a,ord);
select row_to_json(s.*) from generate_series(11,14) with ordinality s;
select definition from pg_views where viewname='vw_ord';
select definition from pg_views where viewname='vw_ord';
select * from unnest(array[10,20],array['foo','bar'],array[1.0]);
select * from unnest(array[10,20],array['foo','bar'],array[1.0]) with ordinality as z(a,b,c,ord);
select * from rows from(unnest(array[10,20],array['foo','bar'],array[1.0])) with ordinality as z(a,b,c,ord);
select * from rows from(unnest(array[10,20],array['foo','bar']), generate_series(101,102)) with ordinality as z(a,b,c,ord);
create temporary view vw_ord as select * from unnest(array[10,20],array['foo','bar'],array[1.0]) as z(a,b,c);
select * from vw_ord;
select definition from pg_views where viewname='vw_ord';
drop view vw_ord;
create temporary view vw_ord as select * from rows from(unnest(array[10,20],array['foo','bar'],array[1.0])) as z(a,b,c);
select * from vw_ord;
select definition from pg_views where viewname='vw_ord';
drop view vw_ord;
create temporary view vw_ord as select * from rows from(unnest(array[10,20],array['foo','bar']), generate_series(1,2)) as z(a,b,c);
select * from vw_ord;
select definition from pg_views where viewname='vw_ord';
drop view vw_ord;
begin;
declare rf_cur scroll cursor for select * from rows from(generate_series(1,5),generate_series(1,2)) with ordinality as g(i,j,o);
fetch all from rf_cur;
fetch backward all from rf_cur;
fetch all from rf_cur;
fetch next from rf_cur;
fetch next from rf_cur;
fetch prior from rf_cur;
fetch absolute 1 from rf_cur;
fetch next from rf_cur;
fetch next from rf_cur;
fetch next from rf_cur;
fetch prior from rf_cur;
fetch prior from rf_cur;
fetch prior from rf_cur;
commit;
CREATE TABLE rngfunc (rngfuncid int, rngfuncsubid int, rngfuncname text, primary key(rngfuncid,rngfuncsubid));
INSERT INTO rngfunc VALUES(1,1,'Joe');
INSERT INTO rngfunc VALUES(1,2,'Ed');
INSERT INTO rngfunc VALUES(2,1,'Mary');
END;
END;
DROP TABLE rngfunc2;
DROP TABLE rngfunc;
CREATE TEMPORARY SEQUENCE rngfunc_rescan_seq1;
CREATE TEMPORARY SEQUENCE rngfunc_rescan_seq2;
CREATE TYPE rngfunc_rescan_t AS (i integer, s bigint);
end;
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT * FROM (VALUES (1),(2),(3)) v(r) LEFT JOIN generate_series(11,13) f(i) ON (r+i)<100;
SELECT * FROM (VALUES (1),(2),(3)) v(r) LEFT JOIN generate_series(11,13) WITH ORDINALITY AS f(i,o) ON (r+i)<100;
SELECT * FROM (VALUES (1),(2),(3)) v(r) LEFT JOIN unnest(array[10,20,30]) f(i) ON (r+i)<100;
SELECT * FROM (VALUES (1),(2),(3)) v(r) LEFT JOIN unnest(array[10,20,30]) WITH ORDINALITY AS f(i,o) ON (r+i)<100;
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT setval('rngfunc_rescan_seq1',1,false),setval('rngfunc_rescan_seq2',1,false);
SELECT * FROM (VALUES (1),(2),(3)) v(r), generate_series(10+r,20-r) f(i);
SELECT * FROM (VALUES (1),(2),(3)) v(r), generate_series(10+r,20-r) WITH ORDINALITY AS f(i,o);
SELECT * FROM (VALUES (1),(2),(3)) v(r), unnest(array[r*10,r*20,r*30]) f(i);
SELECT * FROM (VALUES (1),(2),(3)) v(r), unnest(array[r*10,r*20,r*30]) WITH ORDINALITY AS f(i,o);
SELECT * FROM (VALUES (1),(2),(3)) v1(r1),
              LATERAL (SELECT r1, * FROM (VALUES (10),(20),(30)) v2(r2)
                                         LEFT JOIN generate_series(21,23) f(i) ON ((r2+i)<100) OFFSET 0) s1;
SELECT * FROM (VALUES (1),(2),(3)) v1(r1),
              LATERAL (SELECT r1, * FROM (VALUES (10),(20),(30)) v2(r2)
                                         LEFT JOIN generate_series(20+r1,23) f(i) ON ((r2+i)<100) OFFSET 0) s1;
SELECT * FROM (VALUES (1),(2),(3)) v1(r1),
              LATERAL (SELECT r1, * FROM (VALUES (10),(20),(30)) v2(r2)
                                         LEFT JOIN generate_series(r2,r2+3) f(i) ON ((r2+i)<100) OFFSET 0) s1;
SELECT * FROM (VALUES (1),(2),(3)) v1(r1),
              LATERAL (SELECT r1, * FROM (VALUES (10),(20),(30)) v2(r2)
                                         LEFT JOIN generate_series(r1,2+r2/5) f(i) ON ((r2+i)<100) OFFSET 0) s1;
SELECT *
FROM (VALUES (1),(2)) v1(r1)
    LEFT JOIN LATERAL (
        SELECT *
        FROM generate_series(1, v1.r1) AS gs1
        LEFT JOIN LATERAL (
            SELECT *
            FROM generate_series(1, gs1) AS gs2
            LEFT JOIN generate_series(1, gs2) AS gs3 ON TRUE
        ) AS ss1 ON TRUE
        FULL JOIN generate_series(1, v1.r1) AS gs4 ON FALSE
    ) AS ss0 ON TRUE;
DROP SEQUENCE rngfunc_rescan_seq1;
DROP SEQUENCE rngfunc_rescan_seq2;
CREATE FUNCTION rngfunc(in f1 int, out f2 int)
AS 'select $1+1' LANGUAGE sql;
SELECT rngfunc(42);
SELECT * FROM rngfunc(42);
SELECT * FROM rngfunc(42) AS p(x);
CREATE OR REPLACE FUNCTION rngfunc(in f1 int, out f2 int) RETURNS int
AS 'select $1+1' LANGUAGE sql;
CREATE OR REPLACE FUNCTION rngfuncr(in f1 int, out f2 int, out text)
AS $$select $1-1, $1::text || 'z'$$ LANGUAGE sql;
SELECT * FROM rngfuncr(42);
SELECT * FROM rngfuncr(42) AS p(a,b);
CREATE OR REPLACE FUNCTION rngfuncb(in f1 int, inout f2 int, out text)
AS $$select $2-1, $1::text || 'z'$$ LANGUAGE sql;
SELECT * FROM rngfuncb(42, 99);
SELECT * FROM rngfuncb(42, 99) AS p(a,b);
DROP FUNCTION rngfunc(int);
DROP FUNCTION rngfuncr(in f2 int, out f1 int, out text);
DROP FUNCTION rngfuncb(in f1 int, inout f2 int);
CREATE FUNCTION dup (f1 anyelement, f2 out anyelement, f3 out anyarray)
AS 'select $1, array[$1,$1]' LANGUAGE sql;
SELECT dup(22);
SELECT dup('xyz'::text);
SELECT * FROM dup('xyz'::text);
DROP FUNCTION dup(anyelement);
CREATE OR REPLACE FUNCTION dup (inout f2 anyelement, out f3 anyarray)
AS 'select $1, array[$1,$1]' LANGUAGE sql;
SELECT dup(22);
DROP FUNCTION dup(anyelement);
CREATE FUNCTION dup (f1 anycompatible, f2 anycompatiblearray, f3 out anycompatible, f4 out anycompatiblearray)
AS 'select $1, $2' LANGUAGE sql;
SELECT dup(22, array[44]);
SELECT dup(4.5, array[44]);
SELECT dup(22, array[44::bigint]);
SELECT *, pg_typeof(f3), pg_typeof(f4) FROM dup(22, array[44::bigint]);
DROP FUNCTION dup(f1 anycompatible, f2 anycompatiblearray);
CREATE FUNCTION dup (f1 anycompatiblerange, f2 out anycompatible, f3 out anycompatiblearray, f4 out anycompatiblerange)
AS 'select lower($1), array[lower($1), upper($1)], $1' LANGUAGE sql;
SELECT dup(int4range(4,7));
SELECT dup(numrange(4,7));
DROP FUNCTION dup(f1 anycompatiblerange);
CREATE OR REPLACE FUNCTION rngfunc()
RETURNS TABLE(a int)
AS $$ SELECT a FROM generate_series(1,5) a(a) $$ LANGUAGE sql;
SELECT * FROM rngfunc();
DROP FUNCTION rngfunc();
CREATE OR REPLACE FUNCTION rngfunc(int)
RETURNS TABLE(a int, b int)
AS $$ SELECT a, b
         FROM generate_series(1,$1) a(a),
              generate_series(1,$1) b(b) $$ LANGUAGE sql;
SELECT * FROM rngfunc(3);
DROP FUNCTION rngfunc(int);
CREATE OR REPLACE FUNCTION rngfunc()
RETURNS TABLE(a varchar(5))
AS $$ SELECT 'hello'::varchar(5) $$ LANGUAGE sql STABLE;
SELECT * FROM rngfunc() GROUP BY 1;
DROP FUNCTION rngfunc();
create temp table tt(f1 serial, data text);
create function insert_tt(text) returns int as
$$ insert into tt(data) values($1) returning f1 $$
language sql;
select insert_tt('foo');
select insert_tt('bar');
select * from tt;
create or replace function insert_tt(text) returns int as
$$ insert into tt(data) values($1),($1||$1) returning f1 $$
language sql;
select insert_tt('fool');
select * from tt;
create or replace function insert_tt2(text,text) returns setof int as
$$ insert into tt(data) values($1),($2) returning f1 $$
language sql;
select insert_tt2('foolish','barrish');
select * from insert_tt2('baz','quux');
select * from tt;
select insert_tt2('foolish','barrish') limit 1;
select * from tt;
select insert_tt2('foolme','barme') limit 1;
select * from tt;
create temp table tt_log(f1 int, data text);
create rule insert_tt_rule as on insert to tt do also
  insert into tt_log values(new.*);
select insert_tt2('foollog','barlog') limit 1;
select * from tt;
select * from tt_log;
create function rngfunc1(n integer, out a text, out b text)
  returns setof record
  language sql
  as $$ select 'foo ' || i, 'bar ' || i from generate_series(1,$1) i $$;
set work_mem='64kB';
select t.a, t, t.a from rngfunc1(10000) t limit 1;
reset work_mem;
select t.a, t, t.a from rngfunc1(10000) t limit 1;
drop function rngfunc1(n integer);
create function array_to_set(anyarray) returns setof record as $$
  select i AS "index", $1[i] AS "value" from generate_subscripts($1, 1) i
$$ language sql strict immutable;
select array_to_set(array['one', 'two']);
select * from array_to_set(array['one', 'two']) as t(f1 int,f2 text);
select * from array_to_set(array['one', 'two']) as t(f1 numeric(4,2),f2 text);
explain (verbose, costs off)
  select * from array_to_set(array['one', 'two']) as t(f1 numeric(4,2),f2 text);
create or replace function array_to_set(anyarray) returns setof record as $$
  select i AS "index", $1[i] AS "value" from generate_subscripts($1, 1) i
$$ language sql immutable;
select array_to_set(array['one', 'two']);
select * from array_to_set(array['one', 'two']) as t(f1 int,f2 text);
select * from array_to_set(array['one', 'two']) as t(f1 numeric(4,2),f2 text);
explain (verbose, costs off)
  select * from array_to_set(array['one', 'two']) as t(f1 numeric(4,2),f2 text);
create temp table rngfunc(f1 int8, f2 int8);
create type rngfunc_type as (f1 numeric(35,6), f2 numeric(35,2));
drop type rngfunc_type cascade;
create temp table users (userid text, seq int, email text, todrop bool, moredrop int, enabled bool);
insert into users values ('id',1,'email',true,11,true);
insert into users values ('id2',2,'email2',true,12,true);
alter table users drop column todrop;
alter table users add column junk text;
alter table users drop column moredrop;
begin;
rollback;
alter table users alter column seq type numeric;
begin;
rollback;
drop table users;
create or replace function rngfuncbar() returns setof text as
$$ select 'foo'::varchar union all select 'bar'::varchar ; $$
language sql stable;
select rngfuncbar();
select * from rngfuncbar();
explain (verbose, costs off) select * from rngfuncbar();
drop function rngfuncbar();
create or replace function rngfuncbar(out integer, out numeric) as
$$ select (1, 2.1) $$ language sql;
select * from rngfuncbar();
create or replace function rngfuncbar(out integer, out numeric) as
$$ select (1, 2) $$ language sql;
create or replace function rngfuncbar(out integer, out numeric) as
$$ select (1, 2.1, 3) $$ language sql;
drop function rngfuncbar();
create type rngfunc2 as (a integer, b text);
select *, row_to_json(u) from unnest(array[(1,'foo')::rngfunc2, null::rngfunc2]) u;
select *, row_to_json(u) from unnest(array[null::rngfunc2, null::rngfunc2]) u;
select *, row_to_json(u) from unnest(array[null::rngfunc2, (1,'foo')::rngfunc2, null::rngfunc2]) u;
select *, row_to_json(u) from unnest(array[]::rngfunc2[]) u;
drop type rngfunc2;
explain (verbose, costs off)
select * from
  (select jsonb_path_query_array(module->'lectures', '$[*]') as lecture
   from unnest(array['{"lectures": [{"id": "1"}]}'::jsonb])
        as unnested_modules(module)) as ss,
  jsonb_to_recordset(ss.lecture) as j (id text);
select * from
  (select jsonb_path_query_array(module->'lectures', '$[*]') as lecture
   from unnest(array['{"lectures": [{"id": "1"}]}'::jsonb])
        as unnested_modules(module)) as ss,
  jsonb_to_recordset(ss.lecture) as j (id text);
