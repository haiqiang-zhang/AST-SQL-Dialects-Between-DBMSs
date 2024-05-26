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
COMMIT;
SHOW vacuum_cost_delay;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
BEGIN;
SET vacuum_cost_delay TO 60;
SHOW vacuum_cost_delay;
SET datestyle = 'German';
SHOW datestyle;
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
ROLLBACK TO first_sp;
SHOW datestyle;
SELECT '2006-08-13 12:34:56'::timestamptz;
SAVEPOINT second_sp;
SET vacuum_cost_delay TO '900us';
SET datestyle = 'SQL, YMD';
SHOW datestyle;
SAVEPOINT third_sp;
SET vacuum_cost_delay TO 100;
SHOW vacuum_cost_delay;
SET datestyle = 'Postgres, MDY';
SHOW datestyle;
ROLLBACK TO third_sp;
SHOW vacuum_cost_delay;
SHOW datestyle;
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
RELEASE SAVEPOINT sp;
SHOW vacuum_cost_delay;
SHOW datestyle;
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
SET custom.my_guc = 42;
SHOW custom.my_guc;
RESET custom.my_guc;
SHOW custom.my_guc;
SET custom.my.qualified.guc = 'foo';
SHOW custom.my.qualified.guc;
SET plpgsql.extra_foo_warnings = true;
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
SELECT pg_listening_channels();
SELECT name FROM pg_prepared_statements;
SELECT name FROM pg_cursors;
SHOW vacuum_cost_delay;
SELECT relname from pg_class where relname = 'tmp_foo';
SELECT current_user = 'regress_guc_user';
DISCARD ALL;
SELECT name FROM pg_prepared_statements;
SELECT name FROM pg_cursors;
SHOW vacuum_cost_delay;
SELECT relname from pg_class where relname = 'tmp_foo';
SELECT current_user = 'regress_guc_user';
set search_path = foo, public, not_there_initially;
select current_schemas(false);
create schema not_there_initially;
drop schema not_there_initially;
reset search_path;
set work_mem = '3MB';
create function report_guc(text) returns text as
$$ select current_setting($1) $$ language sql
set work_mem = '1MB';
select report_guc('work_mem'), current_setting('work_mem');
alter function report_guc(text) set work_mem = '2MB';
alter function report_guc(text) reset all;
set work_mem = '3MB';
set work_mem = '3MB';
select current_setting('work_mem');
set nosuch.setting = 'nada';
set check_function_bodies = off;
create function func_with_bad_set() returns int as $$ select 1 $$
language sql
set default_text_search_config = no_such_config;
reset check_function_bodies;
set default_with_oids to f;
SELECT pg_settings_get_flags(NULL);
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
