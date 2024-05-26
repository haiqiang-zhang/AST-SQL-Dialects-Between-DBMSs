set send_logs_level='error';
set database_atomic_wait_for_drop_and_detach_synchronously=1;
drop table if exists rep_fsync_r1;
drop table if exists rep_fsync_r2;
