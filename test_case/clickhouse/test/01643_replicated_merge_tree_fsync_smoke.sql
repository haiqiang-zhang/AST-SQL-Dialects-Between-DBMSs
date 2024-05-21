-- no-parallel -- for flaky check and to avoid "Removing leftovers from table" (for other tables)

-- Temporarily skip warning 'table was created by another server at the same moment, will retry'
set send_logs_level='error';
set database_atomic_wait_for_drop_and_detach_synchronously=1;
drop table if exists rep_fsync_r1;
drop table if exists rep_fsync_r2;
select 'default';
select 'compact fsync_after_insert';
select 'compact fsync_after_insert,fsync_part_directory';
select 'wide fsync_after_insert';
select 'wide fsync_after_insert,fsync_part_directory';
select 'wide fsync_part_directory,vertical';
