SET any_join_distinct_right_table_keys = 1;
SET joined_subquery_requires_alias = 0;
DROP TABLE IF EXISTS series;
CREATE TABLE series(i UInt32, x_value Float64, y_value Float64) ENGINE = Memory;
INSERT INTO series(i, x_value, y_value) VALUES (1, 5.6,-4.4),(2, -9.6,3),(3, -1.3,-4),(4, 5.3,9.7),(5, 4.4,0.037),(6, -8.6,-7.8),(7, 5.1,9.3),(8, 7.9,-3.6),(9, -8.2,0.62),(10, -3,7.3);
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
