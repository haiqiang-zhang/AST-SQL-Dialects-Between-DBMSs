SELECT COUNT(*) FROM duckdb_sequences();
SELECT database_name, schema_name, sequence_name, temporary, start_value, min_value, max_value, increment_by, cycle FROM duckdb_sequences() ORDER BY sequence_name;
