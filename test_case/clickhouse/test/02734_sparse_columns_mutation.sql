SELECT count(), sum(v) FROM t_sparse_mutation;
SELECT sum(has_lightweight_delete) FROM system.parts
WHERE database = currentDatabase() AND table = 't_sparse_mutation' AND active;
ALTER TABLE t_sparse_mutation UPDATE v = v * 2 WHERE id % 5 = 0;
ALTER TABLE t_sparse_mutation DELETE WHERE id % 3 = 0;
OPTIMIZE TABLE t_sparse_mutation FINAL;
DROP TABLE t_sparse_mutation;
