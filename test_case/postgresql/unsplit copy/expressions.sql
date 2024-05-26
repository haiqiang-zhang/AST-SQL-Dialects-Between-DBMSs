SELECT date(now())::text = current_date::text;
SELECT now()::timetz::text = current_time::text;
SELECT now()::timetz(4)::text = current_time(4)::text;
SELECT now()::time::text = localtime::text;
SELECT now()::time(3)::text = localtime(3)::text;
SELECT current_timestamp = NOW();
SELECT length(current_timestamp::text) >= length(current_timestamp(0)::text);
SELECT now()::timestamp::text = localtimestamp::text;
SELECT current_time = current_time(7);
SELECT current_timestamp = current_timestamp(7);
SELECT localtime = localtime(7);
SELECT localtimestamp = localtimestamp(7);
SELECT current_catalog = current_database();
SELECT current_schema;
SET search_path = 'notme';
SELECT current_schema;
SET search_path = 'pg_catalog';
SELECT current_schema;
RESET search_path;
begin;
create table numeric_tbl (f1 numeric(18,3), f2 numeric);
create view numeric_view as
  select
    f1, f1::numeric(16,4) as f1164, f1::numeric as f1n,
    f2, f2::numeric(16,4) as f2164, f2::numeric as f2n
  from numeric_tbl;
explain (verbose, costs off) select * from numeric_view;
create table bpchar_tbl (f1 character(16) unique, f2 bpchar);
create view bpchar_view as
  select
    f1, f1::character(14) as f114, f1::bpchar as f1n,
    f2, f2::character(14) as f214, f2::bpchar as f2n
  from bpchar_tbl;
explain (verbose, costs off) select * from bpchar_view
  where f1::bpchar = 'foo';
rollback;
explain (verbose, costs off)
select random() IN (1, 4, 8.0);
explain (verbose, costs off)
select random()::int IN (1, 4, 8.0);
begin;
create function return_int_input(int) returns int as $$
begin
	return $1;
end;
$$ language plpgsql stable;
create function return_text_input(text) returns text as $$
begin
	return $1;
end;
$$ language plpgsql stable;
select return_int_input(1) in (10, 9, 2, 8, 3, 7, 4, 6, 5, 1);
select return_int_input(1) in (10, 9, 2, 8, 3, 7, 4, 6, 5, null);
select return_int_input(1) in (null, null, null, null, null, null, null, null, null, null, null);
select return_int_input(1) in (10, 9, 2, 8, 3, 7, 4, 6, 5, 1, null);
select return_int_input(null::int) in (10, 9, 2, 8, 3, 7, 4, 6, 5, 1);
select return_int_input(null::int) in (10, 9, 2, 8, 3, 7, 4, 6, 5, null);
select return_text_input('a') in ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j');
select return_int_input(1) not in (10, 9, 2, 8, 3, 7, 4, 6, 5, 1);
select return_int_input(1) not in (10, 9, 2, 8, 3, 7, 4, 6, 5, 0);
select return_int_input(1) not in (10, 9, 2, 8, 3, 7, 4, 6, 5, 2, null);
select return_int_input(1) not in (10, 9, 2, 8, 3, 7, 4, 6, 5, 1, null);
select return_int_input(1) not in (null, null, null, null, null, null, null, null, null, null, null);
select return_int_input(null::int) not in (10, 9, 2, 8, 3, 7, 4, 6, 5, 1);
select return_int_input(null::int) not in (10, 9, 2, 8, 3, 7, 4, 6, 5, null);
select return_text_input('a') not in ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j');
rollback;
begin;
rollback;
