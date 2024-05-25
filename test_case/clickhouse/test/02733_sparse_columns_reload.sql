SELECT count() FROM t_sparse_reload WHERE NOT ignore(*);
ALTER TABLE t_sparse_reload MODIFY SETTING ratio_of_defaults_for_sparse_serialization = 1.0;
DETACH TABLE t_sparse_reload;
ATTACH TABLE t_sparse_reload;
SELECT count() FROM t_sparse_reload WHERE NOT ignore(*);
DROP TABLE t_sparse_reload;
