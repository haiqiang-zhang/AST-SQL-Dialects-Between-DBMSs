SHOW TABLES in system where engine like '%System%' and name in ('numbers', 'one');
CREATE TEMPORARY TABLE test_temporary_table (id UInt64);
SELECT name FROM system.tables WHERE is_temporary = 1 AND name = 'test_temporary_table';
SELECT dependencies_database, dependencies_table FROM system.tables WHERE name = 'test_log' and database=currentDatabase();
SELECT sum(ignore(*, metadata_modification_time, engine_full, create_table_query)) FROM system.tables WHERE database = '{CLICKHOUSE_DATABASE:String}';
