SET max_memory_usage = 10000000000;
SELECT count() FROM (SELECT number, groupArray(repeat(toString(number), 1000000)) FROM numbers(1000000) GROUP BY number);
SELECT count() FROM (SELECT number, groupArray(repeat(toString(number), 1000000)) AS agg FROM numbers(1000000) GROUP BY number HAVING notEmpty(agg));