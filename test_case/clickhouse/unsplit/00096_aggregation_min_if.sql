DROP TABLE IF EXISTS min_if;
CREATE TABLE min_if (arr Array(UInt8), str String, int Int32) ENGINE = Memory;
INSERT INTO min_if SELECT emptyArrayUInt8() AS arr, '' AS str, toInt32(0) AS int FROM system.numbers LIMIT 100000;
INSERT INTO min_if SELECT [1] AS arr, '2' AS str, toInt32(3) AS int;
INSERT INTO min_if SELECT emptyArrayUInt8() AS arr, '' AS str, toInt32(0) AS int FROM system.numbers LIMIT 100000;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(arr, notEmpty(arr)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(str, notEmpty(str)) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
SELECT minIf(int, int != 0) FROM min_if;
DROP TABLE min_if;