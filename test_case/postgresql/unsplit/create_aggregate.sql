CREATE AGGREGATE newavg (
   sfunc = int4_avg_accum, basetype = int4, stype = _int8,
   finalfunc = int8_avg,
   initcond1 = '{0,0}'
);
COMMENT ON AGGREGATE newavg (int4) IS 'an agg comment';
CREATE AGGREGATE newsum (
   sfunc1 = int4pl, basetype = int4, stype1 = int4,
   initcond1 = '0'
);
CREATE AGGREGATE newcnt (*) (
   sfunc = int8inc, stype = int8,
   initcond = '0', parallel = safe
);
CREATE AGGREGATE oldcnt (
   sfunc = int8inc, basetype = 'ANY', stype = int8,
   initcond = '0'
);
CREATE AGGREGATE newcnt ("any") (
   sfunc = int8inc_any, stype = int8,
   initcond = '0'
);
COMMENT ON AGGREGATE newcnt (*) IS 'an agg(*) comment';
create function sum3(int8,int8,int8) returns int8 as
'select $1 + $2 + $3' language sql strict immutable;
create aggregate sum2(int8,int8) (
   sfunc = sum3, stype = int8,
   initcond = '0'
);
create type aggtype as (a integer, b integer, c text);
create function aggf_trans(aggtype[],integer,integer,text) returns aggtype[]
as 'select array_append($1,ROW($2,$3,$4)::aggtype)'
language sql strict immutable;
create function aggfns_trans(aggtype[],integer,integer,text) returns aggtype[]
as 'select array_append($1,ROW($2,$3,$4)::aggtype)'
language sql immutable;
create aggregate aggfstr(integer,integer,text) (
   sfunc = aggf_trans, stype = aggtype[],
   initcond = '{}'
);
create aggregate aggfns(integer,integer,text) (
   sfunc = aggfns_trans, stype = aggtype[], sspace = 10000,
   initcond = '{}'
);
create function least_accum(int8, int8) returns int8 language sql as
  'select least($1, $2)';
drop function least_accum(int8, int8);
create function least_accum(anycompatible, anycompatible)
returns anycompatible language sql as
  'select least($1, $2)';
create aggregate least_agg(int8) (
  stype = int8, sfunc = least_accum
);
drop function least_accum(anycompatible, anycompatible) cascade;
create function least_accum(anyelement, variadic anyarray)
returns anyelement language sql as
  'select least($1, min($2[i])) from generate_subscripts($2,1) g(i)';
create aggregate least_agg(variadic items anyarray) (
  stype = anyelement, sfunc = least_accum
);
create function cleast_accum(anycompatible, variadic anycompatiblearray)
returns anycompatible language sql as
  'select least($1, min($2[i])) from generate_subscripts($2,1) g(i)';
create aggregate cleast_agg(variadic items anycompatiblearray) (
  stype = anycompatible, sfunc = cleast_accum
);
CREATE AGGREGATE sumdouble (float8)
(
    stype = float8,
    sfunc = float8pl,
    mstype = float8,
    msfunc = float8pl,
    minvfunc = float8mi
);
CREATE OR REPLACE AGGREGATE myavg (numeric)
(
	stype = numeric,
	sfunc = numeric_add
);
SELECT aggfnoid, aggtransfn, aggcombinefn, aggtranstype::regtype,
       aggserialfn, aggdeserialfn, aggfinalmodify
FROM pg_aggregate
WHERE aggfnoid = 'myavg'::REGPROC;
create function sum4(int8,int8,int8,int8) returns int8 as
'select $1 + $2 + $3 + $4' language sql strict immutable;
drop function sum4(int8,int8,int8,int8);
DROP AGGREGATE myavg (numeric);
CREATE FUNCTION float8mi_n(float8, float8) RETURNS float8 AS
$$ SELECT $1 - $2; $$
LANGUAGE SQL;
CREATE FUNCTION float8mi_int(float8, float8) RETURNS int AS
$$ SELECT CAST($1 - $2 AS INT); $$
LANGUAGE SQL;
