SELECT id, data, toTypeName(data) FROM t_json_null ORDER BY id;
SELECT id, data.k1, data.k2, data.k3 FROM t_json_null ORDER BY id;
SELECT id, data.k1, data.k2, data.k3 FROM t_json_null ORDER BY id;
SELECT '============';
TRUNCATE TABLE t_json_null;
SELECT id, data.k1.k2, data.k1.k3, data.k1.k4 FROM t_json_null ORDER BY id;
DROP TABLE t_json_null;
