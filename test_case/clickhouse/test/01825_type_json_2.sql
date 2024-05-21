SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_2;
CREATE TABLE t_json_2(id UInt64, data Object('JSON'))
ENGINE = ReplicatedMergeTree('/clickhouse/tables/{database}/test_01825_2/t_json_2', 'r1') ORDER BY tuple();
SELECT id, data, toTypeName(data) FROM t_json_2 ORDER BY id;
SELECT id, data.k1, data.k2, data.k3 FROM t_json_2 ORDER BY id;
SELECT id, data, toTypeName(data) FROM t_json_2 ORDER BY id;
SELECT id, data.k1, data.k2, data.k3 FROM t_json_2 ORDER BY id;
SELECT '============';
TRUNCATE TABLE t_json_2;
SELECT id, data, toTypeName(data) FROM t_json_2 ORDER BY id;
SELECT id, data.k1 FROM t_json_2 ORDEr BY id;
SELECT id, data, toTypeName(data) FROM t_json_2 ORDER BY id;
SELECT id, data.k1 FROM t_json_2 ORDER BY id;
SELECT '============';
TRUNCATE TABLE t_json_2;
SELECT id, data, toTypeName(data) FROM t_json_2 ORDER BY id;
SELECT id, data.k1.k2, data.k1.k3, data.k1.k4 FROM t_json_2 ORDER BY id;
DROP TABLE t_json_2;