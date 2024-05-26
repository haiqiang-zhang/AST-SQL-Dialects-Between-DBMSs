SELECT any(toTypeName(data)), count() FROM t_json_parallel;
DROP TABLE t_json_parallel;
