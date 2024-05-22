SET allow_experimental_object_type = 1;
SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS t_json_analyzer;
CREATE TABLE t_json_analyzer (a JSON) ENGINE = Memory;
INSERT INTO t_json_analyzer VALUES ('{"id": 2, "obj": {"k2": {"k3": "str", "k4": [{"k6": 55}]}, "some": 42}, "s": "bar"}');
DROP TABLE t_json_analyzer;
