SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_local;
DROP TABLE IF EXISTS t_json_dist;
CREATE TABLE t_json_local(data JSON) ENGINE = MergeTree ORDER BY tuple();
DROP TABLE IF EXISTS t_json_local;
DROP TABLE IF EXISTS t_json_dist;
