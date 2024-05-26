create function polyf(x anyelement) returns anyelement as $$
  select x + 1
$$ language sql;
select polyf(42) as int, polyf(4.5) as num;
drop function polyf(x anyelement);
create function polyf(x anyelement) returns anyarray as $$
  select array[x + 1, x + 2]
$$ language sql;
select polyf(42) as int, polyf(4.5) as num;
drop function polyf(x anyelement);
create function polyf(x anyarray) returns anyelement as $$
  select x[1]
$$ language sql;
select polyf(array[2,4]) as int, polyf(array[4.5, 7.7]) as num;
drop function polyf(x anyarray);
create function polyf(x anyarray) returns anyarray as $$
  select x
$$ language sql;
select polyf(array[2,4]) as int, polyf(array[4.5, 7.7]) as num;
drop function polyf(x anyarray);
create function polyf(x anyrange) returns anyarray as $$
  select array[lower(x), upper(x)]
$$ language sql;
drop function polyf(x anyrange);
create function polyf(x anycompatible, y anycompatible) returns anycompatiblearray as $$
  select array[x, y]
$$ language sql;
select polyf(2, 4) as int, polyf(2, 4.5) as num;
drop function polyf(x anycompatible, y anycompatible);
create function polyf(x anycompatiblerange, y anycompatible, z anycompatible) returns anycompatiblearray as $$
  select array[lower(x), upper(x), y, z]
$$ language sql;
drop function polyf(x anycompatiblerange, y anycompatible, z anycompatible);
create function polyf(x anycompatiblemultirange, y anycompatible, z anycompatible) returns anycompatiblearray as $$
  select array[lower(x), upper(x), y, z]
$$ language sql;
drop function polyf(x anycompatiblemultirange, y anycompatible, z anycompatible);
create function polyf(x anycompatiblerange, y anycompatiblearray) returns anycompatiblerange as $$
  select x
$$ language sql;
drop function polyf(x anycompatiblerange, y anycompatiblearray);
create function polyf(x anycompatiblemultirange, y anycompatiblearray) returns anycompatiblemultirange as $$
  select x
$$ language sql;
drop function polyf(x anycompatiblemultirange, y anycompatiblearray);
create function polyf(a anyelement, b anyarray,
                      c anycompatible, d anycompatible,
                      OUT x anyarray, OUT y anycompatiblearray)
as $$
  select a || b, array[c, d]
$$ language sql;
select x, pg_typeof(x), y, pg_typeof(y)
  from polyf(11, array[1, 2], 42, 34.5);
drop function polyf(a anyelement, b anyarray,
                    c anycompatible, d anycompatible);
CREATE FUNCTION stfp(anyarray) RETURNS anyarray AS
'select $1' LANGUAGE SQL;
CREATE FUNCTION stfnp(int[]) RETURNS int[] AS
'select $1' LANGUAGE SQL;
CREATE FUNCTION tfp(anyarray,anyelement) RETURNS anyarray AS
'select $1 || $2' LANGUAGE SQL;
CREATE FUNCTION tfnp(int[],int) RETURNS int[] AS
'select $1 || $2' LANGUAGE SQL;
CREATE FUNCTION tf1p(anyarray,int) RETURNS anyarray AS
'select $1' LANGUAGE SQL;
CREATE FUNCTION tf2p(int[],anyelement) RETURNS int[] AS
'select $1' LANGUAGE SQL;
CREATE FUNCTION sum3(anyelement,anyelement,anyelement) returns anyelement AS
'select $1+$2+$3' language sql strict;
CREATE FUNCTION ffp(anyarray) RETURNS anyarray AS
'select $1' LANGUAGE SQL;
CREATE FUNCTION ffnp(int[]) returns int[] as
'select $1' LANGUAGE SQL;
CREATE AGGREGATE myaggp01a(*) (SFUNC = stfnp, STYPE = int4[],
  FINALFUNC = ffp, INITCOND = '{}');
CREATE AGGREGATE myaggp03a(*) (SFUNC = stfp, STYPE = int4[],
  FINALFUNC = ffp, INITCOND = '{}');
CREATE AGGREGATE myaggp03b(*) (SFUNC = stfp, STYPE = int4[],
  INITCOND = '{}');
CREATE AGGREGATE myaggp05a(BASETYPE = int, SFUNC = tfnp, STYPE = int[],
  FINALFUNC = ffp, INITCOND = '{}');
CREATE AGGREGATE myaggp06a(BASETYPE = int, SFUNC = tf2p, STYPE = int[],
  FINALFUNC = ffp, INITCOND = '{}');
CREATE AGGREGATE myaggp08a(BASETYPE = anyelement, SFUNC = tf2p, STYPE = int[],
  FINALFUNC = ffp, INITCOND = '{}');
CREATE AGGREGATE myaggp09a(BASETYPE = int, SFUNC = tf1p, STYPE = int[],
  FINALFUNC = ffp, INITCOND = '{}');
CREATE AGGREGATE myaggp09b(BASETYPE = int, SFUNC = tf1p, STYPE = int[],
  INITCOND = '{}');
CREATE AGGREGATE myaggp10a(BASETYPE = int, SFUNC = tfp, STYPE = int[],
  FINALFUNC = ffp, INITCOND = '{}');
CREATE AGGREGATE myaggp10b(BASETYPE = int, SFUNC = tfp, STYPE = int[],
  INITCOND = '{}');
CREATE AGGREGATE myaggp20a(BASETYPE = anyelement, SFUNC = tfp,
  STYPE = anyarray, FINALFUNC = ffp, INITCOND = '{}');
CREATE AGGREGATE myaggp20b(BASETYPE = anyelement, SFUNC = tfp,
  STYPE = anyarray, INITCOND = '{}');
CREATE AGGREGATE myaggn01a(*) (SFUNC = stfnp, STYPE = int4[],
  FINALFUNC = ffnp, INITCOND = '{}');
CREATE AGGREGATE myaggn01b(*) (SFUNC = stfnp, STYPE = int4[],
  INITCOND = '{}');
CREATE AGGREGATE myaggn03a(*) (SFUNC = stfp, STYPE = int4[],
  FINALFUNC = ffnp, INITCOND = '{}');
CREATE AGGREGATE myaggn05a(BASETYPE = int, SFUNC = tfnp, STYPE = int[],
  FINALFUNC = ffnp, INITCOND = '{}');
CREATE AGGREGATE myaggn05b(BASETYPE = int, SFUNC = tfnp, STYPE = int[],
  INITCOND = '{}');
CREATE AGGREGATE myaggn06a(BASETYPE = int, SFUNC = tf2p, STYPE = int[],
  FINALFUNC = ffnp, INITCOND = '{}');
CREATE AGGREGATE myaggn06b(BASETYPE = int, SFUNC = tf2p, STYPE = int[],
  INITCOND = '{}');
CREATE AGGREGATE myaggn08a(BASETYPE = anyelement, SFUNC = tf2p, STYPE = int[],
  FINALFUNC = ffnp, INITCOND = '{}');
CREATE AGGREGATE myaggn08b(BASETYPE = anyelement, SFUNC = tf2p, STYPE = int[],
  INITCOND = '{}');
CREATE AGGREGATE myaggn09a(BASETYPE = int, SFUNC = tf1p, STYPE = int[],
  FINALFUNC = ffnp, INITCOND = '{}');
CREATE AGGREGATE myaggn10a(BASETYPE = int, SFUNC = tfp, STYPE = int[],
  FINALFUNC = ffnp, INITCOND = '{}');
CREATE AGGREGATE mysum2(anyelement,anyelement) (SFUNC = sum3,
  STYPE = anyelement, INITCOND = '0');
create temp table t(f1 int, f2 int[], f3 text);
insert into t values(1,array[1],'a');
insert into t values(1,array[11],'b');
insert into t values(1,array[111],'c');
insert into t values(2,array[2],'a');
insert into t values(2,array[22],'b');
insert into t values(2,array[222],'c');
insert into t values(3,array[3],'a');
insert into t values(3,array[3],'b');
select f3, myaggp01a(*) from t group by f3 order by f3;
select f3, myaggp03a(*) from t group by f3 order by f3;
select f3, myaggp03b(*) from t group by f3 order by f3;
select f3, myaggp05a(f1) from t group by f3 order by f3;
select f3, myaggp06a(f1) from t group by f3 order by f3;
select f3, myaggp08a(f1) from t group by f3 order by f3;
select f3, myaggp09a(f1) from t group by f3 order by f3;
select f3, myaggp09b(f1) from t group by f3 order by f3;
select f3, myaggp10a(f1) from t group by f3 order by f3;
select f3, myaggp10b(f1) from t group by f3 order by f3;
select f3, myaggp20a(f1) from t group by f3 order by f3;
select f3, myaggp20b(f1) from t group by f3 order by f3;
select f3, myaggn01a(*) from t group by f3 order by f3;
select f3, myaggn01b(*) from t group by f3 order by f3;
select f3, myaggn03a(*) from t group by f3 order by f3;
select f3, myaggn05a(f1) from t group by f3 order by f3;
select f3, myaggn05b(f1) from t group by f3 order by f3;
select f3, myaggn06a(f1) from t group by f3 order by f3;
select f3, myaggn06b(f1) from t group by f3 order by f3;
select f3, myaggn08a(f1) from t group by f3 order by f3;
select f3, myaggn08b(f1) from t group by f3 order by f3;
select f3, myaggn09a(f1) from t group by f3 order by f3;
select f3, myaggn10a(f1) from t group by f3 order by f3;
select mysum2(f1, f1 + 1) from t;
create function sql_if(bool, anyelement, anyelement) returns anyelement as $$
select case when $1 then $2 else $3 end $$ language sql;
CREATE AGGREGATE array_larger_accum (anyarray)
(
    sfunc = array_larger,
    stype = anyarray,
    initcond = '{}'
);
SELECT array_larger_accum(i)
FROM (VALUES (ARRAY[1,2]), (ARRAY[3,4])) as t(i);
end;
create function first_el_transfn(anyarray, anyelement) returns anyarray as
'select $1 || $2' language sql immutable;
create function first_el(anyarray) returns anyelement as
'select $1[1]' language sql strict immutable;
create aggregate first_el_agg_f8(float8) (
  SFUNC = array_append,
  STYPE = float8[],
  FINALFUNC = first_el
);
create aggregate first_el_agg_any(anyelement) (
  SFUNC = first_el_transfn,
  STYPE = anyarray,
  FINALFUNC = first_el
);
select first_el_agg_f8(x::float8) from generate_series(1,10) x;
select first_el_agg_any(x) from generate_series(1,10) x;
select first_el_agg_f8(x::float8) over(order by x) from generate_series(1,10) x;
select first_el_agg_any(x) over(order by x) from generate_series(1,10) x;
select distinct array_ndims(histogram_bounds) from pg_stats
where histogram_bounds is not null;
select array_in('{1,2,3}','int4'::regtype,-1);
create function myleast(variadic anyarray) returns anyelement as $$
  select min($1[i]) from generate_subscripts($1,1) g(i)
$$ language sql immutable strict;
select myleast(10, 1, 20, 33);
select concat('%', 1, 2, 3, 4, 5);
select pg_typeof(null);
create function dfunc(a variadic int[]) returns int as
$$ select array_upper($1, 1) $$ language sql;
select dfunc(10);
create or replace function dfunc(a variadic int[] default array[]::int[]) returns int as
$$ select array_upper($1, 1) $$ language sql;
drop function dfunc(a variadic int[]);
create function anyctest(anycompatible, anycompatible)
returns anycompatible as $$
  select greatest($1, $2)
$$ language sql;
drop function anyctest(anycompatible, anycompatible);
create function anyctest(anycompatible, anycompatible)
returns anycompatiblearray as $$
  select array[$1, $2]
$$ language sql;
drop function anyctest(anycompatible, anycompatible);
create function anyctest(anycompatible, anycompatiblearray)
returns anycompatiblearray as $$
  select array[$1] || $2
$$ language sql;
drop function anyctest(anycompatible, anycompatiblearray);
create function anyctest(anycompatible, anycompatiblerange)
returns anycompatiblerange as $$
  select $2
$$ language sql;
drop function anyctest(anycompatible, anycompatiblerange);
create function anyctest(anycompatiblerange, anycompatiblerange)
returns anycompatible as $$
  select lower($1) + upper($2)
$$ language sql;
drop function anyctest(anycompatiblerange, anycompatiblerange);
create function anyctest(anycompatible, anycompatiblemultirange)
returns anycompatiblemultirange as $$
  select $2
$$ language sql;
drop function anyctest(anycompatible, anycompatiblemultirange);
create function anyctest(anycompatiblemultirange, anycompatiblemultirange)
returns anycompatible as $$
  select lower($1) + upper($2)
$$ language sql;
drop function anyctest(anycompatiblemultirange, anycompatiblemultirange);
create function anyctest(anycompatiblenonarray, anycompatiblenonarray)
returns anycompatiblearray as $$
  select array[$1, $2]
$$ language sql;
drop function anyctest(anycompatiblenonarray, anycompatiblenonarray);
create function anyctest(a anyelement, b anyarray,
                         c anycompatible, d anycompatible)
returns anycompatiblearray as $$
  select array[c, d]
$$ language sql;
drop function anyctest(a anyelement, b anyarray,
                       c anycompatible, d anycompatible);
create function anyctest(variadic anycompatiblearray)
returns anycompatiblearray as $$
  select $1
$$ language sql;
drop function anyctest(variadic anycompatiblearray);
