-- Different result means Backward Incompatible Change. Old partitions will not be accepted by new server.
SELECT partition_id FROM system.parts WHERE table = 'tab' AND database = currentDatabase();
DROP TABLE IF EXISTS tab;
