CREATE SCHEMA scheme;
SELECT COUNT(*) FROM duckdb_schemas;
SELECT COUNT(*) FROM duckdb_schemas() WHERE schema_name='scheme';
SELECT COUNT(*) FROM duckdb_schemas WHERE schema_name='scheme';
