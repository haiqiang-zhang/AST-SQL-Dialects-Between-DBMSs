SELECT '#02136_scalar_subquery_1', (SELECT max(number) FROM numbers(1000)) as n;
SELECT '#02136_scalar_subquery_2', (SELECT max(number) FROM numbers(1000)) as n, (SELECT min(number) FROM numbers(1000)) as n2;
SELECT '#02136_scalar_subquery_3', (SELECT max(number) FROM numbers(1000)) as n, (SELECT max(number) FROM numbers(1000)) as n2;
SELECT '#02136_scalar_subquery_4', (SELECT max(number) FROM numbers(1000)) as n FROM system.numbers LIMIT 2;
SYSTEM FLUSH LOGS;
