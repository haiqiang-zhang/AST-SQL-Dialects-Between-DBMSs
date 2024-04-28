CREATE TABLE integers(i INTEGER);
CREATE TABLE pk(i INTEGER PRIMARY KEY, j VARCHAR, CHECK(i<100));
CREATE SCHEMA myschema;;
CREATE TABLE myschema.mytable(k DOUBLE);
CREATE TEMPORARY TABLE mytemp(i INTEGER);
CREATE VIEW v1 AS SELECT 42;
SELECT COUNT(*) FROM duckdb_tables();;
SELECT database_name, schema_name, table_name, temporary, has_primary_key, estimated_size, column_count, index_count, check_constraint_count FROM duckdb_tables() ORDER BY table_name;;
