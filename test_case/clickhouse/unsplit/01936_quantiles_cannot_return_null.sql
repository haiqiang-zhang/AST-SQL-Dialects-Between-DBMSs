set aggregate_functions_null_for_empty=0;
SELECT quantiles(0.95)(x) FROM (SELECT 1 x WHERE 0);
set aggregate_functions_null_for_empty=1;
