SELECT round(max(log(2) * number), 6) AS k FROM numbers(10000000) GROUP BY number % 2, number % 3, (number % 2 + number % 3) % 2 ORDER BY k;
EXPLAIN SYNTAX SELECT max(log(2) * number) AS k FROM numbers(10000000) GROUP BY number % 2, number % 3, (number % 2 + number % 3) % 2 ORDER BY k;
set optimize_group_by_function_keys = 0;
