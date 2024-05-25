DROP TABLE IF EXISTS aggregate_functions_null_for_empty;
CREATE TABLE aggregate_functions_null_for_empty (`x` UInt32, `y` UInt64, PROJECTION p (SELECT sum(y))) ENGINE = MergeTree ORDER BY tuple();
INSERT INTO aggregate_functions_null_for_empty SELECT number, number * 2 FROM numbers(8192 * 10) SETTINGS aggregate_functions_null_for_empty = true;
