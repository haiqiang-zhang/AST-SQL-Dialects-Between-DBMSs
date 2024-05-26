SELECT name, type, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_1' AND column = 's' AND active
ORDER BY name;
SELECT countIf(s = 'foo'), arraySort(groupUniqArray(s)) FROM t_sparse_mutations_1;
ALTER TABLE t_sparse_mutations_1 MODIFY COLUMN s Nullable(String);
SELECT name, type, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_1' AND column = 's' AND active
ORDER BY name;
INSERT INTO t_sparse_mutations_1 SELECT 2, number, if (number % 21 = 0, 'foo', '') FROM numbers (10000);
SELECT name, type, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_1' AND column = 's' AND active
ORDER BY name;
ALTER TABLE t_sparse_mutations_1 MODIFY COLUMN s String;
SELECT name, type, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_1' AND column = 's' AND active
ORDER BY name;
OPTIMIZE TABLE t_sparse_mutations_1 FINAL;
SELECT name, type, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_1' AND column = 's' AND active
ORDER BY name;
DROP TABLE t_sparse_mutations_1;
