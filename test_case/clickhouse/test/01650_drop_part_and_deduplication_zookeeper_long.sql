-- Tag no-replicated-database: Fails due to additional replicas or shards

SET insert_keeper_fault_injection_probability=0;
DROP TABLE IF EXISTS partitioned_table SYNC;
SYSTEM STOP MERGES partitioned_table;
SELECT '~~~~source parts~~~~~';
SELECT partition_id, name FROM system.parts WHERE table = 'partitioned_table' AND database = currentDatabase() and active ORDER BY name;
SELECT '~~~~parts after deduplication~~~~~';
SELECT partition_id, name FROM system.parts WHERE table = 'partitioned_table' AND database = currentDatabase() and active ORDER BY name;
SELECT '~~~~parts after drop 3_1_1_0~~~~~';
SELECT partition_id, name FROM system.parts WHERE table = 'partitioned_table' AND database = currentDatabase() and active ORDER BY name;
SELECT '~~~~parts after new part without deduplication~~~~~';
SELECT partition_id, name FROM system.parts WHERE table = 'partitioned_table' AND database = currentDatabase() and active ORDER BY name;
DROP TABLE IF EXISTS partitioned_table SYNC;
