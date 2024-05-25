SELECT _part, count() FROM test_not_found_column_nothing PREWHERE col001 % 3 != 0 GROUP BY _part ORDER BY _part;
SELECT _part FROM test_not_found_column_nothing PREWHERE col001 = 0;
DROP TABLE test_not_found_column_nothing;
