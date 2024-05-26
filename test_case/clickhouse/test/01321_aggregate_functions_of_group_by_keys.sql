SELECT min(number % 2) AS a, max(number % 3) AS b FROM numbers(10000000) GROUP BY number % 2, number % 3 ORDER BY a, b;
SELECT foo FROM (SELECT anyLast(number) AS foo FROM numbers(1) GROUP BY number);
SELECT anyLast(number) FROM numbers(1) GROUP BY number;
EXPLAIN SYNTAX SELECT min(number % 2) AS a, max(number % 3) AS b FROM numbers(10000000) GROUP BY number % 2, number % 3 ORDER BY a, b;
EXPLAIN SYNTAX SELECT foo FROM (SELECT anyLast(number) AS foo FROM numbers(1) GROUP BY number);
set optimize_aggregators_of_group_by_keys = 0;
SELECT foo FROM (SELECT anyLast(number) AS foo FROM numbers(1) GROUP BY number);
EXPLAIN SYNTAX SELECT foo FROM (SELECT anyLast(number) AS foo FROM numbers(1) GROUP BY number);
