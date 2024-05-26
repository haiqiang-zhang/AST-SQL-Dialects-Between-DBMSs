DROP TABLE IF EXISTS replicated_deduplicate_by_columns_r1 SYNC;
DROP TABLE IF EXISTS replicated_deduplicate_by_columns_r2 SYNC;
SET replication_alter_partitions_sync = 2;
