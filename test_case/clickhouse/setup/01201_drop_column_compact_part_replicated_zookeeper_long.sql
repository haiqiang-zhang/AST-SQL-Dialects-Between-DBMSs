set insert_keeper_max_retries=100;
set insert_keeper_retry_max_backoff_ms=10;
set replication_alter_partitions_sync = 2;
drop table if exists mt_compact;
