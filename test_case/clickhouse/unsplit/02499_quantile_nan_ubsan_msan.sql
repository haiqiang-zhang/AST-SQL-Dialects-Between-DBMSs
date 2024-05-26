SELECT quantiles(0.5)(now()::DateTime('UTC')) WHERE 0;
SELECT arrayReduce('quantiles(0.5)', []::Array(DateTime('UTC')));
SELECT DISTINCT arrayReduce('quantiles(0.5)', materialize([]::Array(DateTime('UTC')))) FROM numbers(1000) LIMIT 10;
SELECT quantile(0.5)(now()::DateTime('UTC')) WHERE 0;
