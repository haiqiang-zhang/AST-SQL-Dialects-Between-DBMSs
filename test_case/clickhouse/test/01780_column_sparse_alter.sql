SELECT column, serialization_kind FROM system.parts_columns WHERE database = currentDatabase() AND table = 't_sparse_alter' AND active ORDER BY column;
SELECT uniqExact(u), uniqExact(s) FROM t_sparse_alter;
ALTER TABLE t_sparse_alter DROP COLUMN s, RENAME COLUMN u TO t;
ALTER TABLE t_sparse_alter MODIFY COLUMN t UInt16;
SELECT column, serialization_kind FROM system.parts_columns WHERE database = currentDatabase() AND table = 't_sparse_alter' AND active ORDER BY column;
DETACH TABLE t_sparse_alter;
ATTACH TABLE t_sparse_alter;
SELECT column, serialization_kind FROM system.parts_columns WHERE database = currentDatabase() AND table = 't_sparse_alter' AND active ORDER BY column;
DROP TABLE t_sparse_alter;
