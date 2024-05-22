SET compile_expressions = 1;
SET min_count_to_compile_expression = 0;
SELECT number + number + number FROM numbers(1);
SYSTEM FLUSH LOGS;
SET compile_aggregate_expressions = 1;
SET min_count_to_compile_aggregate_expression = 0;
SELECT avg(number), avg(number + 1), avg(number + 2) FROM numbers(1) GROUP BY number;
SYSTEM FLUSH LOGS;
