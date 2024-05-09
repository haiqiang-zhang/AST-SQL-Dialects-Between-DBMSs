select @@global.profiling;
select @@local.profiling;
select @@global.profiling_history_size;
select @@local.profiling_history_size;
select @@global.have_profiling;
select count(*) from information_schema.tables where table_name like 'host' and table_schema like 'mysql' and table_type like 'BASE TABLE';
SELECT * FROM INFORMATION_SCHEMA.profiling;
