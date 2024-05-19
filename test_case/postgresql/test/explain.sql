

create function explain_filter(text) returns setof text
language plpgsql as
$$
declare
    ln text;
begin
    for ln in execute $1
    loop
        ln := regexp_replace(ln, '-?\m\d+\M', 'N', 'g');
        ln := regexp_replace(ln, '\m\d+kB', 'NkB', 'g');
        CONTINUE WHEN (ln ~ ' +Buffers: .*');
        CONTINUE WHEN (ln = 'Planning:');
        return next ln;
    end loop;
end;
$$;

create function explain_filter_to_json(text) returns jsonb
language plpgsql as
$$
declare
    data text := '';
    ln text;
begin
    for ln in execute $1
    loop
        ln := regexp_replace(ln, '\m\d+\M', '0', 'g');
        data := data || ln;
    end loop;
    return data::jsonb;
end;
$$;

set jit = off;

set track_io_timing = off;


select explain_filter('explain select * from int8_tbl i8');
select explain_filter('explain (analyze) select * from int8_tbl i8');
select explain_filter('explain (analyze, verbose) select * from int8_tbl i8');
select explain_filter('explain (analyze, buffers, format text) select * from int8_tbl i8');
select explain_filter('explain (analyze, buffers, format xml) select * from int8_tbl i8');
select explain_filter('explain (analyze, buffers, format yaml) select * from int8_tbl i8');
select explain_filter('explain (buffers, format text) select * from int8_tbl i8');
select explain_filter('explain (buffers, format json) select * from int8_tbl i8');

set track_io_timing = on;
select explain_filter('explain (analyze, buffers, format json) select * from int8_tbl i8');
set track_io_timing = off;


begin;
set local plan_cache_mode = force_generic_plan;
select true as "OK"
  from explain_filter('explain (settings) select * from int8_tbl i8') ln
  where ln ~ '^ *Settings: .*plan_cache_mode = ''force_generic_plan''';
select explain_filter_to_json('explain (settings, format json) select * from int8_tbl i8') #> '{0,Settings,plan_cache_mode}';
rollback;


select explain_filter('explain (generic_plan) select unique1 from tenk1 where thousand = $1');
select explain_filter('explain (analyze, generic_plan) select unique1 from tenk1 where thousand = $1');

select explain_filter('explain (memory) select * from int8_tbl i8');
select explain_filter('explain (memory, analyze) select * from int8_tbl i8');
select explain_filter('explain (memory, summary, format yaml) select * from int8_tbl i8');
select explain_filter('explain (memory, analyze, format json) select * from int8_tbl i8');
prepare int8_query as select * from int8_tbl i8;
select explain_filter('explain (memory) execute int8_query');

create table gen_part (
  key1 integer not null,
  key2 integer not null
) partition by list (key1);
create table gen_part_1
  partition of gen_part for values in (1)
  partition by range (key2);
create table gen_part_1_1
  partition of gen_part_1 for values from (1) to (2);
create table gen_part_1_2
  partition of gen_part_1 for values from (2) to (3);
create table gen_part_2
  partition of gen_part for values in (2);
select explain_filter('explain (generic_plan) select key1, key2 from gen_part where key1 = 1 and key2 = $1');
drop table gen_part;


begin;
set parallel_setup_cost=0;
set parallel_tuple_cost=0;
set min_parallel_table_scan_size=0;
set max_parallel_workers_per_gather=4;

select jsonb_pretty(
  explain_filter_to_json('explain (analyze, verbose, buffers, format json)
                         select * from tenk1 order by tenthous')
  #- '{0,Plan,Plans,0,Plans,0,Workers}'
  #- '{0,Plan,Plans,0,Workers}'
  #- '{0,Plan,Plans,0,Sort Method}'
  #- '{0,Plan,Plans,0,Sort Space Type}'
);

rollback;

create temp table t1(f1 float8);

create function pg_temp.mysin(float8) returns float8 language plpgsql
as 'begin return sin($1); end';

select explain_filter('explain (verbose) select * from t1 where pg_temp.mysin(f1) < 0.5');

set compute_query_id = on;
select explain_filter('explain (verbose) select * from int8_tbl i8');
