create table integers(i int primary key, check (i < 10));
create table test(i varchar unique, k varchar, check(len(i || k) < 10));
create table fk_integers(j int, foreign key (j) references integers(i));
create table fk_integers_2(k int, foreign key (k) references integers(i));
SELECT * FROM duckdb_constraints();
SELECT * FROM duckdb_constraints;
SELECT table_name, constraint_index, constraint_type, UNNEST(constraint_column_names) col_name FROM duckdb_constraints ORDER BY table_name, constraint_index, col_name;
