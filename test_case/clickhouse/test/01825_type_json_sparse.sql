SYSTEM STOP MERGES t_json_sparse;
INSERT INTO t_json_sparse VALUES ('{"k1": 1, "k2": {"k3": 4}}');
INSERT INTO t_json_sparse SELECT '{"k1": 2}' FROM numbers(200000);
SELECT subcolumns.names, subcolumns.serializations, count() FROM system.parts_columns
ARRAY JOIN subcolumns
WHERE database = currentDatabase()
    AND table = 't_json_sparse' AND column = 'data' AND active
GROUP BY subcolumns.names, subcolumns.serializations
ORDER BY subcolumns.names;
SELECT '=============';
SYSTEM START MERGES t_json_sparse;
OPTIMIZE TABLE t_json_sparse FINAL;
SELECT '=============';
DETACH TABLE t_json_sparse;
ATTACH TABLE t_json_sparse;
INSERT INTO t_json_sparse SELECT '{"k1": 2}' FROM numbers(200000);
SELECT '=============';
OPTIMIZE TABLE t_json_sparse FINAL;
SELECT data.k1, count(), sum(data.k2.k3) FROM t_json_sparse GROUP BY data.k1 ORDER BY data.k1;
