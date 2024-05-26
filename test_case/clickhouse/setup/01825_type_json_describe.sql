SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_desc;
CREATE TABLE t_json_desc (data JSON) ENGINE = MergeTree ORDER BY tuple();
