SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_field;
CREATE TABLE t_json_field (id UInt32, data JSON)
ENGINE = MergeTree ORDER BY tuple();
INSERT INTO t_json_field VALUES (1, (10, 'a')::Tuple(a UInt32, s String));
