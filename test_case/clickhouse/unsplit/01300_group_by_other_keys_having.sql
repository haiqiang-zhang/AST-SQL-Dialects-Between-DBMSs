set optimize_group_by_function_keys = 1;
set optimize_syntax_fuse_functions = 0;
set allow_experimental_analyzer = 1;
SELECT round(avg(log(2) * number), 6) AS k FROM numbers(10000000) GROUP BY (number % 2) * (number % 3), number % 3, number % 2 HAVING avg(log(2) * number) > 3465735.3 ORDER BY k;
EXPLAIN SYNTAX SELECT avg(log(2) * number) AS k FROM numbers(10000000) GROUP BY (number % 2) * (number % 3), number % 3, number % 2 HAVING avg(log(2) * number) > 3465735.3 ORDER BY k;
set optimize_group_by_function_keys = 0;
