SELECT type, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_2' AND column = 's' AND active
ORDER BY name;
SELECT count(), sum(s::UInt64) FROM t_sparse_mutations_2 WHERE s != '';
ALTER TABLE t_sparse_mutations_2 UPDATE s = '' WHERE id % 13 != 0;
SELECT type, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_2' AND column = 's' AND active
ORDER BY name;
OPTIMIZE TABLE t_sparse_mutations_2 FINAL;
SELECT type, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_2' AND column = 's' AND active
ORDER BY name;
DROP TABLE t_sparse_mutations_2;
