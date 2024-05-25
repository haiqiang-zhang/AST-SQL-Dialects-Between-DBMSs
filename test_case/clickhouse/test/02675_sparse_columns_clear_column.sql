SELECT column, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_columns_clear' AND active
ORDER BY column;
SET mutations_sync = 2;
SET alter_sync = 2;
ALTER TABLE t_sparse_columns_clear CLEAR COLUMN v;
SELECT column, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_columns_clear' AND active
ORDER BY column;
OPTIMIZE TABLE t_sparse_columns_clear FINAL;
SELECT column, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_columns_clear' AND active
ORDER BY column;
DROP TABLE t_sparse_columns_clear SYNC;
SYSTEM FLUSH LOGS;
