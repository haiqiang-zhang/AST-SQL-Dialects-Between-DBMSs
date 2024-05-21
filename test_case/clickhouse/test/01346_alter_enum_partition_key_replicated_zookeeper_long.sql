SET insert_keeper_fault_injection_probability=0;
DROP TABLE IF EXISTS test SYNC;
DROP TABLE IF EXISTS test2 SYNC;
SELECT min_block_number, max_block_number, partition, partition_id FROM system.parts WHERE database = currentDatabase() AND table = 'test' AND active ORDER BY partition;
SELECT min_block_number, max_block_number, partition, partition_id FROM system.parts WHERE database = currentDatabase() AND table = 'test2' AND active ORDER BY partition;
SELECT min_block_number, max_block_number, partition, partition_id FROM system.parts WHERE database = currentDatabase() AND table = 'test' AND active ORDER BY partition;
SELECT min_block_number, max_block_number, partition, partition_id FROM system.parts WHERE database = currentDatabase() AND table = 'test2' AND active ORDER BY partition;
SELECT min_block_number, max_block_number, partition, partition_id FROM system.parts WHERE database = currentDatabase() AND table = 'test' AND active ORDER BY partition;
SELECT min_block_number, max_block_number, partition, partition_id FROM system.parts WHERE database = currentDatabase() AND table = 'test2' AND active ORDER BY partition;
