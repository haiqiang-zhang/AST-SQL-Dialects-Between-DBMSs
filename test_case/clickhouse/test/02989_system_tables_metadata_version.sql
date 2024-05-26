SELECT name, metadata_version FROM system.tables WHERE name = 'test_temporary_table_02989' AND is_temporary;
DROP TABLE test_temporary_table_02989;
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
    id UInt64,
    value String
) ENGINE=MergeTree ORDER BY id;
SELECT '--';
SELECT name, metadata_version FROM system.tables WHERE database = currentDatabase() AND name = 'test_table';
DROP TABLE test_table;
DROP TABLE IF EXISTS test_table_replicated;
SELECT '--';
SELECT name, metadata_version FROM system.tables WHERE database = currentDatabase() AND name = 'test_table_replicated';
SELECT '--';
SELECT name, metadata_version FROM system.tables WHERE database = currentDatabase() AND name = 'test_table_replicated';
SELECT '--';
SELECT name, metadata_version FROM system.tables WHERE database = currentDatabase() AND name = 'test_table_replicated';
