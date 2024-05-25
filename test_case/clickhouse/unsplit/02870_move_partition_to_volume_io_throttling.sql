SELECT disk_name, partition, rows FROM system.parts WHERE database = currentDatabase() AND table = 'test_move_partition_throttling' and active;
SYSTEM FLUSH LOGS;
SELECT disk_name, partition, rows FROM system.parts WHERE database = currentDatabase() AND table = 'test_move_partition_throttling' and active;
