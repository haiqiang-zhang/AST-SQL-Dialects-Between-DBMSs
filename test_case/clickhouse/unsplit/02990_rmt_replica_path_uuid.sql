SET send_logs_level='fatal';
DROP TABLE IF EXISTS x;
SELECT uuid FROM system.tables WHERE database = currentDatabase() and table = 'x';
SELECT replica_path FROM system.replicas WHERE database = currentDatabase() and table = 'x';
SELECT uuid FROM system.tables WHERE database = currentDatabase() and table = 'x';
SELECT replica_path FROM system.replicas WHERE database = currentDatabase() and table = 'x';
