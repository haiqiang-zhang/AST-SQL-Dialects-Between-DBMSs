SYSTEM STOP MERGES t_sparse_02235;
INSERT INTO t_sparse_02235 SELECT 1 FROM numbers(1000);
INSERT INTO t_sparse_02235 SELECT 0 FROM numbers(1000);
SELECT name, column, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_02235'
ORDER BY name, column;
CHECK TABLE t_sparse_02235 SETTINGS check_query_single_value_result = 0, max_threads = 1;
DROP TABLE t_sparse_02235;
