SELECT '-- Negative tests';
SELECT '-- Tests';
SELECT '   -- Array';
SELECT [1, 2, 3]::Array(UInt8) AS x, [4, 5, 6]::Array(UInt8) AS y, dotProduct(x, y) AS res, toTypeName(res);
SELECT '   -- Tuple';
SELECT '-- Non-const argument';
SELECT ' -- Array with mixed element arguments types (result type is the supertype)';
SELECT ' -- Tuple with mixed element arguments types';
SELECT '-- Aliases';
SELECT scalarProduct([1, 2, 3], [4, 5, 6]);
SELECT arrayDotProduct([1, 2, 3], [4, 5, 6]);
SELECT '-- Tests that trigger special paths';
DROP TABLE IF EXISTS tab;
CREATE TABLE tab(id UInt64, vec Array(Float32)) ENGINE = MergeTree ORDER BY id;
INSERT INTO tab VALUES (0, [0.0, 1.0, 2.0, 3.0, 0.0, 1.0, 2.0, 3.0, 0.0, 1.0, 2.0, 3.0, 0.0, 1.0, 2.0, 3.0, 0.0, 1.0, 2.0]) (1, [5.0, 1.0, 2.0, 3.0, 5.0, 1.0, 2.0, 3.0, 5.0, 1.0, 2.0, 3.0, 5.0, 1.0, 2.0, 3.0, 5.0, 1.0, 2.0]);
SELECT '   -- non-const / non-const';
SELECT '   -- const / non-const';
DROP TABLE tab;
