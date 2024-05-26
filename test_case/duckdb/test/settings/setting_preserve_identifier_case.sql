SELECT value FROM duckdb_settings() WHERE name='preserve_identifier_case';
SELECT duckdb_tables.schema_name, duckdb_tables.table_name, column_name FROM duckdb_tables JOIN duckdb_columns USING (table_oid);
SELECT value FROM duckdb_settings() WHERE name='preserve_identifier_case';
SELECT duckdb_tables.schema_name, duckdb_tables.table_name, column_name FROM duckdb_tables JOIN duckdb_columns USING (table_oid);
