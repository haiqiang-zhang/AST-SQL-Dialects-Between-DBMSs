SELECT id, data, toTypeName(data) FROM t_object_convert ORDER BY id;
INSERT INTO t_object_convert SELECT 2, CAST(CAST('{"y" : 2}', 'Object(\'json\')'), 'Object(Nullable(\'json\'))');
SELECT id, data.x, data.y FROM t_object_convert ORDER BY id;
CREATE TABLE t_object_convert2(id UInt64, data Object('JSON')) Engine=Memory;
INSERT INTO t_object_convert2 SELECT 1, CAST(CAST('{"x" : 1}', 'Object(\'json\')'), 'Object(Nullable(\'json\'))');
INSERT INTO t_object_convert2 SELECT 2, CAST(CAST('{"y" : 2}', 'Object(\'json\')'), 'Object(Nullable(\'json\'))');
DROP TABLE t_object_convert;
DROP TABLE t_object_convert2;
