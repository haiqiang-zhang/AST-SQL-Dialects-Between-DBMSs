SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_10;
CREATE TABLE t_json_10 (o JSON) ENGINE = Memory;
DROP TABLE t_json_10;
