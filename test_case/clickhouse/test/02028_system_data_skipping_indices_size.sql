SELECT * FROM system.data_skipping_indices WHERE database = currentDatabase();
ALTER TABLE test_table DROP INDEX value_index;
ALTER TABLE test_table ADD INDEX value_index value TYPE minmax GRANULARITY 1;
ALTER TABLE test_table MATERIALIZE INDEX value_index SETTINGS mutations_sync=1;
SELECT * FROM system.data_skipping_indices WHERE database = currentDatabase();
DROP TABLE test_table;
