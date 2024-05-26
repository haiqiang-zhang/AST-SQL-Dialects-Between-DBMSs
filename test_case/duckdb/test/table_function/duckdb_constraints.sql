SELECT * FROM duckdb_constraints();
SELECT * FROM duckdb_constraints;
SELECT table_name, constraint_index, constraint_type, UNNEST(constraint_column_names) col_name FROM duckdb_constraints ORDER BY table_name, constraint_index, col_name;
