-- Tag no-replicated-database: Fails due to additional replicas or shards

SET replication_alter_partitions_sync = 2;
DROP TABLE IF EXISTS replica1 SYNC;
DROP TABLE IF EXISTS replica2 SYNC;
SELECT name FROM system.detached_parts WHERE table = 'replica2' AND database = currentDatabase();
SELECT name FROM system.detached_parts WHERE table = 'replica2' AND database = currentDatabase();
SELECT '-- drop part --';
SELECT '-- resume merges --';
SELECT name FROM system.parts WHERE table = 'replica2' AND active AND database = currentDatabase();
