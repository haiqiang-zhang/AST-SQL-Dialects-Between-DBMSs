SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_null;
CREATE TABLE t_json_null(id UInt64, data Object(Nullable('JSON')))
ENGINE = MergeTree ORDER BY tuple();
SELECT id, data, toTypeName(data) FROM t_json_null ORDER BY id;
SELECT id, data.k1, data.k2, data.k3 FROM t_json_null ORDER BY id;
SELECT id, data.k1, data.k2, data.k3 FROM t_json_null ORDER BY id;
SELECT '============';
TRUNCATE TABLE t_json_null;
SELECT id, data.k1.k2, data.k1.k3, data.k1.k4 FROM t_json_null ORDER BY id;
DROP TABLE t_json_null;
