SELECT * FROM system.data_skipping_indices WHERE database = currentDatabase();
SELECT count(*) FROM system.data_skipping_indices WHERE table = 'data_01917' AND database = currentDatabase();
SELECT name FROM system.data_skipping_indices WHERE type = 'minmax' AND database = currentDatabase();
DROP TABLE data_01917;
DROP TABLE data_01917_2;
