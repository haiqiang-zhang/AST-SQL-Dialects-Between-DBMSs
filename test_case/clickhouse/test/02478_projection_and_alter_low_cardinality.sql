OPTIMIZE TABLE testing FINAL;
ALTER TABLE testing MODIFY COLUMN c LowCardinality(String) SETTINGS mutations_sync=2;
SELECT * FROM system.mutations WHERE database = currentDatabase() AND table = 'testing' AND not is_done;
DROP TABLE testing;
