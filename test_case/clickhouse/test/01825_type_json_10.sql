SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_10;
CREATE TABLE t_json_10 (o JSON) ENGINE = Memory;
SELECT o.a.b, o.a.c.d, o.a.c.e, o.a.c.f FROM t_json_10 ORDER BY o.a.b;
DROP TABLE t_json_10;