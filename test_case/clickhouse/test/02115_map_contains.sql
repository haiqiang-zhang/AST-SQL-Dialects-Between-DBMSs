SET optimize_functions_to_subcolumns = 1;
EXPLAIN SYNTAX SELECT mapContains(m, 'a') FROM t_map_contains;
SELECT mapContains(m, 'a') FROM t_map_contains;
DROP TABLE t_map_contains;
