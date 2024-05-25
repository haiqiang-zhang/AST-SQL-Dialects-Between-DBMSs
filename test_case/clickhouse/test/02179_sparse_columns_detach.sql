OPTIMIZE TABLE t_sparse_detach FINAL;
SELECT count() FROM t_sparse_detach WHERE s != '';
SELECT column, serialization_kind FROM system.parts_columns
WHERE table = 't_sparse_detach' AND database = currentDatabase() AND active
ORDER BY column;
DETACH TABLE t_sparse_detach;
ATTACH TABLE t_sparse_detach;
SELECT count() FROM t_sparse_detach WHERE s != '';
SELECT column, serialization_kind FROM system.parts_columns
WHERE table = 't_sparse_detach' AND database = currentDatabase() AND active
ORDER BY column;
TRUNCATE TABLE t_sparse_detach;
ALTER TABLE t_sparse_detach
    MODIFY SETTING vertical_merge_algorithm_min_rows_to_activate = 1,
    vertical_merge_algorithm_min_columns_to_activate = 1;
INSERT INTO t_sparse_detach SELECT number, number % 21 = 0 ? toString(number) : '' FROM numbers(10000);
INSERT INTO t_sparse_detach SELECT number, number % 21 = 0 ? toString(number) : '' FROM numbers(10000);
OPTIMIZE TABLE t_sparse_detach FINAL;
SELECT count() FROM t_sparse_detach WHERE s != '';
SELECT column, serialization_kind FROM system.parts_columns
WHERE table = 't_sparse_detach' AND database = currentDatabase() AND active
ORDER BY column;
DETACH TABLE t_sparse_detach;
ATTACH TABLE t_sparse_detach;
SELECT count() FROM t_sparse_detach WHERE s != '';
SELECT column, serialization_kind FROM system.parts_columns
WHERE table = 't_sparse_detach' AND database = currentDatabase() AND active
ORDER BY column;
DROP TABLE t_sparse_detach;
