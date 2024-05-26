SELECT COUNT(*) FROM duckdb_views;
SELECT database_name, schema_name, view_name, temporary FROM duckdb_views() WHERE NOT internal ORDER BY view_name;
SELECT database_name, schema_name, view_name, temporary FROM duckdb_views ORDER BY view_name;
