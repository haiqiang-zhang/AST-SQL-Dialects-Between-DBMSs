SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_2;
CREATE TABLE t_json_2(id UInt64, data Object('JSON'))
ENGINE = MergeTree ORDER BY tuple();
