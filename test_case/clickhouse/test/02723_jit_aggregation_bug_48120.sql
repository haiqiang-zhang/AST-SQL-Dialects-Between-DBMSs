set compile_aggregate_expressions=1;
set min_count_to_compile_aggregate_expression=0;
SELECT minIf(num1, num1 < 5) FROM dummy GROUP BY num2;
SELECT minIf(num1, num1 >= 5) FROM dummy GROUP BY num2;
drop table dummy;
