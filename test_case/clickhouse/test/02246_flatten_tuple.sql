SELECT flattenTuple(t) AS ft, toTypeName(ft) FROM t_flatten_tuple;
SET allow_experimental_object_type = 1;
CREATE TABLE t_flatten_object(data JSON) ENGINE = Memory;
INSERT INTO t_flatten_object VALUES ('{"id": 1, "obj": {"k1": 1, "k2": {"k3": 2, "k4": [{"k5": 3}, {"k5": 4}]}}, "s": "foo"}');
INSERT INTO t_flatten_object VALUES ('{"id": 2, "obj": {"k2": {"k3": "str", "k4": [{"k6": 55}]}, "some": 42}, "s": "bar"}');
SELECT untuple(flattenTuple(data)) FROM t_flatten_object ORDER BY data.id;
DROP TABLE IF EXISTS t_flatten_tuple;
DROP TABLE IF EXISTS t_flatten_object;
