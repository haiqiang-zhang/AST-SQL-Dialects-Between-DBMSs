SELECT partition, rows FROM system.parts WHERE database = currentDatabase() AND table = 'move_partition_to_oneself' and active;
ALTER TABLE move_partition_to_oneself MOVE PARTITION tuple() TO TABLE move_partition_to_oneself;
SELECT partition, rows FROM system.parts WHERE database = currentDatabase() AND table = 'move_partition_to_oneself' and active;
