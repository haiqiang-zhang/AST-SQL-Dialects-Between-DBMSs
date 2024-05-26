SELECT 'totals';
SELECT number % 3 + 1 AS n, min(n), max(n) FROM numbers(100) GROUP BY n WITH TOTALS;
SELECT 'rollup';
SELECT 'cube';
SELECT '=======';
SELECT
    x,
    min(x) AS lower,
    max(x) + 1 AS upper,
    upper - lower AS range
FROM
(
    SELECT arrayJoin([1, 2]) AS x
) 
GROUP BY x WITH ROLLUP;
