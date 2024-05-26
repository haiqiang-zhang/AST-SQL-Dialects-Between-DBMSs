SELECT column, serialization_kind FROM system.parts_columns
WHERE table = 't_sparse' AND database = currentDatabase()
ORDER BY column, serialization_kind;
SELECT count() FROM t_sparse WHERE u > 0;
SYSTEM STOP MERGES t_sparse;
INSERT INTO t_sparse SELECT
    number, number, toString(number)
FROM numbers (1, 100000);
SELECT column, serialization_kind FROM system.parts_columns
WHERE table = 't_sparse' AND database = currentDatabase()
ORDER BY column, serialization_kind;
DROP TABLE t_sparse;
