SELECT type, serialization_kind, subcolumns.names, subcolumns.types, subcolumns.serializations FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_5' AND column = 't' AND active
ORDER BY name;
ALTER TABLE t_sparse_mutations_5 MODIFY COLUMN t Tuple(UInt64, String);
SELECT type, serialization_kind, subcolumns.names, subcolumns.types, subcolumns.serializations FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_5' AND column = 't' AND active
ORDER BY name;
DROP TABLE t_sparse_mutations_5;
