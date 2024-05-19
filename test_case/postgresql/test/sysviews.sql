
select count(*) >= 0 as ok from pg_available_extension_versions;

select count(*) >= 0 as ok from pg_available_extensions;

select name, ident, parent, level, total_bytes >= free_bytes
  from pg_backend_memory_contexts where level = 0;

select count(*) > 20 as ok from pg_config;

select count(*) = 0 as ok from pg_cursors;

select count(*) >= 0 as ok from pg_file_settings;

select count(*) > 0 as ok, count(*) FILTER (WHERE error IS NOT NULL) = 0 AS no_err
  from pg_hba_file_rules;

select count(*) >= 0 as ok, count(*) FILTER (WHERE error IS NOT NULL) = 0 AS no_err
  from pg_ident_file_mappings;

select count(*) > 0 as ok from pg_locks;

select count(*) = 0 as ok from pg_prepared_statements;

select count(*) >= 0 as ok from pg_prepared_xacts;

select count(*) > 0 as ok from pg_stat_slru;

select count(*) = 1 as ok from pg_stat_wal;

select count(*) = 0 as ok from pg_stat_wal_receiver;

select name, setting from pg_settings where name like 'enable%';

select type, count(*) > 0 as ok FROM pg_wait_events
  group by type order by type COLLATE "C";

select count(distinct utc_offset) >= 24 as ok from pg_timezone_names;
select count(distinct utc_offset) >= 24 as ok from pg_timezone_abbrevs;
set timezone_abbreviations = 'Australia';
select count(distinct utc_offset) >= 24 as ok from pg_timezone_abbrevs;
set timezone_abbreviations = 'India';
select count(distinct utc_offset) >= 24 as ok from pg_timezone_abbrevs;
