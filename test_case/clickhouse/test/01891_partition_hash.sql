SELECT partition_id FROM system.parts WHERE table = 'tab' AND database = currentDatabase();
DROP TABLE IF EXISTS tab;
