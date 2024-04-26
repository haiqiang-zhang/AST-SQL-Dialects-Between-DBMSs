
CREATE TABLE t1 (a INT);

SET lock_wait_timeout=1;
SET DEBUG_SYNC='mysql_rm_table_after_lock_table_names SIGNAL run_backup_lock WAIT_FOR continue_dropping_table';

SET DEBUG_SYNC='now WAIT_FOR run_backup_lock';

SET DEBUG_SYNC='now SIGNAL continue_dropping_table';
