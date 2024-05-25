SELECT * FROM t_create_as_tuple ORDER BY number;
DETACH TABLE t_create_as_tuple;
ATTACH TABLE t_create_as_tuple;
SELECT * FROM t_create_as_tuple ORDER BY number;
DROP TABLE t_create_as_tuple;
