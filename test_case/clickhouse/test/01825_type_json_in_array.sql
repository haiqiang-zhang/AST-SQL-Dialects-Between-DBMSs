SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_array;
CREATE TABLE t_json_array (id UInt32, arr Array(JSON)) ENGINE = MergeTree ORDER BY id;
SELECT id, arr.k1, arr.k2.k3, arr.k2.k4, arr.k2.k5 FROM t_json_array ORDER BY id;
SELECT toTypeName(arr) FROM t_json_array LIMIT 1;
TRUNCATE TABLE t_json_array;
SELECT id, arr.k1.k2, arr.k1.k3, arr.k1.k4, arr.k5.k6 FROM t_json_array ORDER BY id;
SELECT toTypeName(arrayJoin(arrayJoin(arr.k1))) AS arr FROM t_json_array LIMIT 1;
DROP TABLE t_json_array;