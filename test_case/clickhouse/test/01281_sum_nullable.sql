SELECT sumKahan(toFloat64(number)) FROM numbers(10);
SELECT sum(toNullable(number)) FROM numbers(10);
SELECT sum(x) FROM (SELECT 1 AS x UNION ALL SELECT NULL);
