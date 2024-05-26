OPTIMIZE TABLE t_json FINAL;
SELECT any(toTypeName(obj)) from t_json;
DROP TABLE IF EXISTS t_json;
