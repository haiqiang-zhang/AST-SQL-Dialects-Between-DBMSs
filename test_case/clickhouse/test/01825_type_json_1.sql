SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json;
CREATE TABLE t_json(id UInt64, data Object('JSON'))
ENGINE = MergeTree ORDER BY tuple();
SYSTEM STOP MERGES t_json;
SELECT name, column, type
FROM system.parts_columns
WHERE table = 't_json' AND database = currentDatabase() AND active AND column = 'data'
ORDER BY name;
SYSTEM START MERGES t_json;
OPTIMIZE TABLE t_json FINAL;
SELECT name, column, type
FROM system.parts_columns
WHERE table = 't_json' AND database = currentDatabase() AND active AND column = 'data'
ORDER BY name;
SELECT '============';
TRUNCATE TABLE t_json;
SELECT name, column, type
FROM system.parts_columns
WHERE table = 't_json' AND database = currentDatabase() AND active AND column = 'data'
ORDER BY name;
SELECT '============';
TRUNCATE TABLE t_json;
SYSTEM STOP MERGES t_json;
SELECT name, column, type
FROM system.parts_columns
WHERE table = 't_json' AND database = currentDatabase() AND active AND column = 'data'
ORDER BY name;
SELECT name, column, type
FROM system.parts_columns
WHERE table = 't_json' AND database = currentDatabase() AND active AND column = 'data'
ORDER BY name;
SELECT name, column, type
FROM system.parts_columns
WHERE table = 't_json' AND database = currentDatabase() AND active AND column = 'data'
ORDER BY name;
SYSTEM START MERGES t_json;
OPTIMIZE TABLE t_json FINAL;
SELECT name, column, type
FROM system.parts_columns
WHERE table = 't_json' AND database = currentDatabase() AND active AND column = 'data'
ORDER BY name;
DROP TABLE IF EXISTS t_json;
