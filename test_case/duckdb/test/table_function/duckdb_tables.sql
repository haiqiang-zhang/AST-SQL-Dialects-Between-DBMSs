SELECT COUNT(*) FROM duckdb_tables();
SELECT database_name, schema_name, table_name, temporary, has_primary_key, estimated_size, column_count, index_count, check_constraint_count FROM duckdb_tables() ORDER BY table_name;
