-- Tag no-parallel: static UUID
-- Tag no-ordinary-database: requires UUID
-- Tag no-replicated-database: executes with ON CLUSTER anyway

-- Ignore "ATTACH TABLE query with full table definition is not recommended"
-- Ignore BAD_ARGUMENTS
SET send_logs_level='fatal';
DROP TABLE IF EXISTS x;
SELECT uuid FROM system.tables WHERE database = currentDatabase() and table = 'x';
SELECT replica_path FROM system.replicas WHERE database = currentDatabase() and table = 'x';
SELECT uuid FROM system.tables WHERE database = currentDatabase() and table = 'x';
SELECT replica_path FROM system.replicas WHERE database = currentDatabase() and table = 'x';
