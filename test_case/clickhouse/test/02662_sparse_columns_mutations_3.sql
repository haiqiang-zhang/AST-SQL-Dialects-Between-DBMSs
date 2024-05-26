SELECT type, serialization_kind FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_3' AND column = 's' AND active
ORDER BY name;
ALTER TABLE t_sparse_mutations_3 MODIFY COLUMN s Tuple(UInt64, UInt64, String, String, String);
SELECT
    type,
    serialization_kind,
    subcolumns.names,
    subcolumns.types,
    subcolumns.serializations
FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_3' AND column = 's' AND active
ORDER BY name;
SELECT sum(s.1), sum(s.2), groupUniqArray(s.3), groupUniqArray(s.4), groupUniqArray(s.5) FROM t_sparse_mutations_3;
OPTIMIZE TABLE t_sparse_mutations_3 FINAL;
SELECT
    type,
    serialization_kind,
    subcolumns.names,
    subcolumns.types,
    subcolumns.serializations
FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_3' AND column = 's' AND active
ORDER BY name;
ALTER TABLE t_sparse_mutations_3 MODIFY COLUMN s Tuple(UInt64, UInt64, UInt64, UInt64, String);
SELECT
    type,
    serialization_kind,
    subcolumns.names,
    subcolumns.types,
    subcolumns.serializations
FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_3' AND column = 's' AND active
ORDER BY name;
OPTIMIZE TABLE t_sparse_mutations_3 FINAL;
SELECT
    type,
    serialization_kind,
    subcolumns.names,
    subcolumns.types,
    subcolumns.serializations
FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_3' AND column = 's' AND active
ORDER BY name;
ALTER TABLE t_sparse_mutations_3 MODIFY COLUMN s Tuple(Nullable(UInt64), Nullable(UInt64), Nullable(UInt64), Nullable(UInt64), Nullable(String));
SELECT
    type,
    serialization_kind,
    subcolumns.names,
    subcolumns.types,
    subcolumns.serializations
FROM system.parts_columns
WHERE database = currentDatabase() AND table = 't_sparse_mutations_3' AND column = 's' AND active
ORDER BY name;
DROP TABLE t_sparse_mutations_3;
