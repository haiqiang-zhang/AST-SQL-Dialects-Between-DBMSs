WITH map(1, 'Test') AS value, 'Array(Tuple(UInt64, String))' AS type
SELECT value, cast(value, type), cast(materialize(value), type);
WITH map(1, 'val1', 2, 'val2') AS map
SELECT CAST(map, 'Array(Tuple(k UInt32, v String))') AS c, toTypeName(c);
