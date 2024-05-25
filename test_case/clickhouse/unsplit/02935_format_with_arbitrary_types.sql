-- no-fasttest: json type needs rapidjson library, geo types need s2 geometry

SET allow_experimental_object_type = 1;
SET allow_suspicious_low_cardinality_types=1;
SELECT '-- Const string + non-const arbitrary type';
SELECT '-- Nested';
SELECT '-- NULL arguments';
SELECT '-- Various arguments tests';
SELECT '-- Single argument tests';
