SHOW datestyle;

SET vacuum_cost_delay TO 40;
SET datestyle = 'ISO, YMD';
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;

SET LOCAL vacuum_cost_delay TO 50;
SHOW vacuum_cost_delay;
SET LOCAL datestyle = 'SQL';
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;

BEGIN;
SET LOCAL vacuum_cost_delay TO 50;
SHOW vacuum_cost_delay;
SET LOCAL datestyle = 'SQL';
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
COMMIT;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;

BEGIN;
SET vacuum_cost_delay TO 60;
SHOW vacuum_cost_delay;
SET datestyle = 'German';
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
ROLLBACK;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;

BEGIN;
SET vacuum_cost_delay TO 70;
SET datestyle = 'MDY';
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
SAVEPOINT first_sp;
SET vacuum_cost_delay TO 80.1;
SHOW vacuum_cost_delay;
SET datestyle = 'German, DMY';
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
ROLLBACK TO first_sp;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
SAVEPOINT second_sp;
SET vacuum_cost_delay TO '900us';
SET datestyle = 'SQL, YMD';
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
SAVEPOINT third_sp;
SET vacuum_cost_delay TO 100;
SHOW vacuum_cost_delay;
SET datestyle = 'Postgres, MDY';
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
ROLLBACK TO third_sp;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
ROLLBACK TO second_sp;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
ROLLBACK;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;

BEGIN;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
SAVEPOINT sp;
SET LOCAL vacuum_cost_delay TO 30;
SHOW vacuum_cost_delay;
SET LOCAL datestyle = 'Postgres, MDY';
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
ROLLBACK TO sp;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
ROLLBACK;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;

BEGIN;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
SAVEPOINT sp;
SET LOCAL vacuum_cost_delay TO 30;
SHOW vacuum_cost_delay;
SET LOCAL datestyle = 'Postgres, MDY';
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
RELEASE SAVEPOINT sp;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
ROLLBACK;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;

BEGIN;
SET vacuum_cost_delay TO 40;
SET LOCAL vacuum_cost_delay TO 50;
SHOW vacuum_cost_delay;
SET datestyle = 'ISO, DMY';
SET LOCAL datestyle = 'Postgres, MDY';
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
COMMIT;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;

SET datestyle = iso, ymd;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
RESET datestyle;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;

SET seq_page_cost TO 'NaN';
SET vacuum_cost_delay TO '10s';
SET no_such_variable TO 42;

SHOW custom.my_guc;  
SET custom.my_guc = 42;
SHOW custom.my_guc;
RESET custom.my_guc;  
SHOW custom.my_guc;
SET custom.my.qualified.guc = 'foo';
SHOW custom.my.qualified.guc;
SET custom."bad-guc" = 42;  
SHOW custom."bad-guc";
SET special."weird name" = 'foo';  
SHOW special."weird name";

SET plpgsql.extra_foo_warnings = true;  
LOAD 'plpgsql';  
SET plpgsql.extra_foo_warnings = true;  
SHOW plpgsql.extra_foo_warnings;

CREATE TEMP TABLE reset_test ( data text ) ON COMMIT DELETE ROWS;
SELECT relname FROM pg_class WHERE relname = 'reset_test';
DISCARD TEMP;
SELECT relname FROM pg_class WHERE relname = 'reset_test';


DECLARE foo CURSOR WITH HOLD FOR SELECT 1;
PREPARE foo AS SELECT 1;
LISTEN foo_event;
SET vacuum_cost_delay = 13;
CREATE TEMP TABLE tmp_foo (data text) ON COMMIT DELETE ROWS;
CREATE ROLE regress_guc_user;
SET SESSION AUTHORIZATION regress_guc_user;
SELECT pg_listening_channels();
SELECT name FROM pg_prepared_statements;
SELECT name FROM pg_cursors;
SHOW vacuum_cost_delay;
SELECT relname from pg_class where relname = 'tmp_foo';
SELECT current_user = 'regress_guc_user';
DISCARD ALL;
SELECT pg_listening_channels();
SELECT name FROM pg_prepared_statements;
SELECT name FROM pg_cursors;
SHOW vacuum_cost_delay;
SELECT relname from pg_class where relname = 'tmp_foo';
SELECT current_user = 'regress_guc_user';
DROP ROLE regress_guc_user;


set search_path = foo, public, not_there_initially;
select current_schemas(false);
create schema not_there_initially;
select current_schemas(false);
drop schema not_there_initially;
select current_schemas(false);
reset search_path;


set work_mem = '3MB';

create function report_guc(text) returns text as
$$ select current_setting($1) $$ language sql
set work_mem = '1MB';

select report_guc('work_mem'), current_setting('work_mem');

alter function report_guc(text) set work_mem = '2MB';

select report_guc('work_mem'), current_setting('work_mem');

alter function report_guc(text) reset all;

select report_guc('work_mem'), current_setting('work_mem');

create or replace function myfunc(int) returns text as $$
begin
  set local work_mem = '2MB';
  return current_setting('work_mem');
end $$
language plpgsql
set work_mem = '1MB';

select myfunc(0), current_setting('work_mem');

alter function myfunc(int) reset all;

select myfunc(0), current_setting('work_mem');

set work_mem = '3MB';

create or replace function myfunc(int) returns text as $$
begin
  set work_mem = '2MB';
  return current_setting('work_mem');
end $$
language plpgsql
set work_mem = '1MB';

select myfunc(0), current_setting('work_mem');

set work_mem = '3MB';

create or replace function myfunc(int) returns text as $$
begin
  set work_mem = '2MB';
  perform 1/$1;
  return current_setting('work_mem');
end $$
language plpgsql
set work_mem = '1MB';

select myfunc(0);
select current_setting('work_mem');
select myfunc(1), current_setting('work_mem');


select current_setting('nosuch.setting');  
select current_setting('nosuch.setting', false);  
select current_setting('nosuch.setting', true) is null;

set nosuch.setting = 'nada';

select current_setting('nosuch.setting');
select current_setting('nosuch.setting', false);
select current_setting('nosuch.setting', true);


create function func_with_bad_set() returns int as $$ select 1 $$
language sql
set default_text_search_config = no_such_config;

set check_function_bodies = off;

create function func_with_bad_set() returns int as $$ select 1 $$
language sql
set default_text_search_config = no_such_config;

select func_with_bad_set();

reset check_function_bodies;

set default_with_oids to f;
set default_with_oids to t;

SELECT pg_settings_get_flags(NULL);
SELECT pg_settings_get_flags('does_not_exist');
CREATE TABLE tab_settings_flags AS SELECT name, category,
    'EXPLAIN'          = ANY(flags) AS explain,
    'NO_RESET'         = ANY(flags) AS no_reset,
    'NO_RESET_ALL'     = ANY(flags) AS no_reset_all,
    'NOT_IN_SAMPLE'    = ANY(flags) AS not_in_sample,
    'RUNTIME_COMPUTED' = ANY(flags) AS runtime_computed
  FROM pg_show_all_settings() AS psas,
    pg_settings_get_flags(psas.name) AS flags;

SELECT name FROM tab_settings_flags
  WHERE category = 'Developer Options' AND NOT not_in_sample
  ORDER BY 1;
SELECT name FROM tab_settings_flags
  WHERE category ~ '^Query Tuning' AND NOT explain
  ORDER BY 1;
SELECT name FROM tab_settings_flags
  WHERE NOT category = 'Preset Options' AND runtime_computed
  ORDER BY 1;
SELECT name FROM tab_settings_flags
  WHERE category = 'Preset Options' AND NOT not_in_sample
  ORDER BY 1;
SELECT name FROM tab_settings_flags
  WHERE no_reset AND NOT no_reset_all
  ORDER BY 1;
DROP TABLE tab_settings_flags;
