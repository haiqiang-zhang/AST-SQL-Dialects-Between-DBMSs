SELECT varSampStable(x_value) FROM (SELECT x_value FROM series LIMIT 0);
SELECT round(abs(res1 - res2), 6) FROM
(
SELECT
    varSampStable(x_value) AS res1,
    (sum(x_value * x_value) - ((sum(x_value) * sum(x_value)) / count())) / (count() - 1) AS res2
FROM series
);
SELECT stddevSampStable(x_value) FROM (SELECT x_value FROM series LIMIT 0);
SELECT varPopStable(x_value) FROM (SELECT x_value FROM series LIMIT 0);
SELECT stddevPopStable(x_value) FROM (SELECT x_value FROM series LIMIT 0);
SELECT covarSampStable(x_value, y_value) FROM (SELECT x_value, y_value FROM series LIMIT 0);
SELECT covarPopStable(x_value, y_value) FROM (SELECT x_value, y_value FROM series LIMIT 0);
SELECT corrStable(x_value, y_value) FROM (SELECT x_value, y_value FROM series LIMIT 0);
DROP TABLE series;
