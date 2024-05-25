SET allow_experimental_object_type = 1;
CREATE TABLE t_json(id UInt64, obj JSON) ENGINE = MergeTree ORDER BY id;
OPTIMIZE TABLE t_json FINAL;
SELECT any(toTypeName(obj)) from t_json;
DROP TABLE IF EXISTS t_json;
