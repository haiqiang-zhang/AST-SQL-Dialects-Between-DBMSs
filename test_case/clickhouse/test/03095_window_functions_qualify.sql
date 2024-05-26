SELECT number, COUNT() OVER (PARTITION BY number % 3) AS partition_count FROM numbers(10) QUALIFY partition_count = 4 ORDER BY number;
SELECT '--';
SELECT '--';
SELECT '--';
SELECT (number % 2) AS key, count() FROM numbers(10) GROUP BY key HAVING key = 0 QUALIFY key == 0;
SELECT '--';
SELECT '--';
SELECT '--';
EXPLAIN header = 1, actions = 1
SELECT number, COUNT() OVER (PARTITION BY number % 3) AS partition_count FROM numbers(10) QUALIFY COUNT() OVER (PARTITION BY number % 3) = 4 ORDER BY number;
