SELECT sumMerge(s) FROM (SELECT sumState(number) s FROM numbers(0));
SELECT sumIf(1, 0);
SELECT sumIfOrNull(1, 0);
SELECT sumOrNullIf(1, 0);
SELECT nullIf(1, 0);
SET aggregate_functions_null_for_empty=1;
