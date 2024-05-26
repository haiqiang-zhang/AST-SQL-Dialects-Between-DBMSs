SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_object_convert;
CREATE TABLE t_object_convert(id UInt64, data Object(Nullable('JSON'))) Engine=Memory;
INSERT INTO t_object_convert SELECT 1, CAST(CAST('{"x" : 1}', 'Object(\'json\')'), 'Object(Nullable(\'json\'))');
