SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_array;
CREATE TABLE t_json_array (id UInt32, arr Array(JSON)) ENGINE = MergeTree ORDER BY id;
