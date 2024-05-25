SELECT mark_number, a, b FROM mergeTreeIndex(currentDatabase(), t_index_lazy_load) ORDER BY mark_number;
DETACH TABLE t_index_lazy_load;
ATTACH TABLE t_index_lazy_load;
SELECT mark_number, a, b FROM mergeTreeIndex(currentDatabase(), t_index_lazy_load) ORDER BY mark_number;
DROP TABLE t_index_lazy_load;
