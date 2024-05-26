SELECT varSamp(x_value) FROM (SELECT x_value FROM series LIMIT 0);
SELECT round(abs(res1 - res2), 6) FROM
(
SELECT
    varSamp(x_value) AS res1,
    (sum(x_value * x_value) - ((sum(x_value) * sum(x_value)) / count())) / (count() - 1) AS res2
FROM series
);
SELECT stddevSamp(x_value) FROM (SELECT x_value FROM series LIMIT 0);
SELECT skewSamp(x_value) FROM (SELECT x_value FROM series LIMIT 0);
SELECT kurtSamp(x_value) FROM (SELECT x_value FROM series LIMIT 0);
SELECT varPop(x_value) FROM (SELECT x_value FROM series LIMIT 0);
SELECT stddevPop(x_value) FROM (SELECT x_value FROM series LIMIT 0);
SELECT skewPop(x_value) FROM (SELECT x_value FROM series LIMIT 0);
SELECT kurtPop(x_value) FROM (SELECT x_value FROM series LIMIT 0);
SELECT covarSamp(x_value, y_value) FROM (SELECT x_value, y_value FROM series LIMIT 0);
SELECT covarPop(x_value, y_value) FROM (SELECT x_value, y_value FROM series LIMIT 0);
SELECT corr(x_value, y_value) FROM (SELECT x_value, y_value FROM series LIMIT 0);
SELECT '----quantile----';
SELECT quantileExactIf(number, number > 0) FROM numbers(90);
SELECT quantileIf(number, number > 100) FROM numbers(90);
DROP TABLE series;
