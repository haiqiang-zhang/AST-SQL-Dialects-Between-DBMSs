SET allow_experimental_object_type = 1;
CREATE TABLE t_json_17(obj JSON)
ENGINE = MergeTree ORDER BY tuple();
DROP FUNCTION IF EXISTS hasValidSizes17;
CREATE FUNCTION hasValidSizes17 AS (arr1, arr2) -> length(arr1) = length(arr2) AND arrayAll((x, y) -> length(x) = length(y), arr1, arr2);
SYSTEM STOP MERGES t_json_17;
TRUNCATE TABLE t_json_17;
TRUNCATE TABLE t_json_17;
DROP FUNCTION hasValidSizes17;
DROP TABLE t_json_17;
