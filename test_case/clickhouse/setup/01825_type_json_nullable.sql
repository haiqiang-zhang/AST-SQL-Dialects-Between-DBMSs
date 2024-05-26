SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_null;
CREATE TABLE t_json_null(id UInt64, data Object(Nullable('JSON')))
ENGINE = MergeTree ORDER BY tuple();
