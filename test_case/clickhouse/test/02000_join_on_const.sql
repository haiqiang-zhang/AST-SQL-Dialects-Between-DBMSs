SELECT 70 = 10 * sum(t1.id) + sum(t2.id) AND count() == 4 FROM t1 JOIN t2 ON 1 = 1;
SELECT 70 = 10 * sum(t1.id) + sum(t2.id) AND count() == 4 FROM t1 JOIN t2 ON 1;
SELECT 70 = 10 * sum(t1.id) + sum(t2.id) AND count() == 4 FROM t1 JOIN t2 ON 2 = 2 AND 3 = 3;
SELECT 70 = 10 * sum(t1.id) + sum(t2.id) AND count() == 4 FROM t1 JOIN t2 ON toNullable(1);
SELECT 70 = 10 * sum(t1.id) + sum(t2.id) AND count() == 4 FROM t1 JOIN t2 ON toLowCardinality(1);
SELECT '- ON NULL -';
SELECT '- inner -';
SELECT * FROM t1 JOIN t2 ON NULL;
SELECT * FROM t1 JOIN t2 ON 0;
SELECT * FROM t1 JOIN t2 ON 1 = 2;
SELECT '- left -';
SELECT * FROM t1 LEFT JOIN t2 ON NULL ORDER BY t1.id, t2.id;
SELECT '- right -';
SELECT * FROM t1 RIGHT JOIN t2 ON NULL ORDER BY t1.id, t2.id;
SELECT '- full -';
SELECT * FROM t1 FULL JOIN t2 ON NULL ORDER BY t1.id, t2.id;
SELECT '- inner -';
SELECT * FROM t1 JOIN t2 ON NULL ORDER BY t1.id NULLS FIRST, t2.id SETTINGS join_use_nulls = 1;
SELECT '- left -';
SELECT * FROM t1 LEFT JOIN t2 ON NULL ORDER BY t1.id NULLS FIRST, t2.id SETTINGS join_use_nulls = 1;
SELECT '- right -';
SELECT * FROM t1 RIGHT JOIN t2 ON NULL ORDER BY t1.id NULLS FIRST, t2.id SETTINGS join_use_nulls = 1;
SELECT '- full -';
SELECT * FROM t1 FULL JOIN t2 ON NULL ORDER BY t1.id NULLS FIRST, t2.id SETTINGS join_use_nulls = 1;
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id AND 1 == 1 SETTINGS allow_experimental_analyzer = 1;
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id AND 1 == 2 SETTINGS allow_experimental_analyzer = 1;
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id AND 1 != 1 SETTINGS allow_experimental_analyzer = 1;
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id AND 0 SETTINGS allow_experimental_analyzer = 1;
SELECT * FROM t1 JOIN t2 ON t1.id = t2.id AND 1 SETTINGS allow_experimental_analyzer = 1;
SELECT * FROM t1 LEFT JOIN t2 ON t1.id = t2.id AND 1 = 1 SETTINGS allow_experimental_analyzer = 1;
SELECT * FROM t1 RIGHT JOIN t2 ON t1.id = t2.id AND 1 = 1 SETTINGS allow_experimental_analyzer = 1;
SELECT * FROM t1 FULL JOIN t2 ON t1.id = t2.id AND 1 = 1 SETTINGS allow_experimental_analyzer = 1;
SELECT * FROM t1 LEFT JOIN t2 ON t1.id = t2.id AND 1 = 2 SETTINGS allow_experimental_analyzer = 1;
SELECT * FROM t1 RIGHT JOIN t2 ON t1.id = t2.id AND 1 = 2 SETTINGS allow_experimental_analyzer = 1;
SELECT * FROM t1 FULL JOIN t2 ON t1.id = t2.id AND 1 = 2 SETTINGS allow_experimental_analyzer = 1;
SELECT * FROM (SELECT 1 as a) as t1 INNER JOIN  ( SELECT ('b', 256) as b ) AS t2 ON NULL;
SELECT * FROM (SELECT 1 as a) as t1 LEFT JOIN  ( SELECT ('b', 256) as b ) AS t2 ON NULL;
SELECT * FROM (SELECT 1 as a) as t1 RIGHT JOIN  ( SELECT ('b', 256) as b ) AS t2 ON NULL;
SELECT * FROM (SELECT 1 as a) as t1 FULL JOIN  ( SELECT ('b', 256) as b ) AS t2 ON NULL;
SELECT * FROM (SELECT 1 as a) as t1 SEMI JOIN  ( SELECT ('b', 256) as b ) AS t2 ON NULL;
SELECT * FROM (SELECT 1 as a) as t1 ANTI JOIN  ( SELECT ('b', 256) as b ) AS t2 ON NULL;
SELECT a + 1
FROM (SELECT 1 as x) as t1
LEFT JOIN ( SELECT 1 AS a ) AS t2
ON TRUE
SETTINGS allow_experimental_analyzer=1, join_use_nulls=1;
SELECT a + 1, x + 1, toTypeName(a), toTypeName(x)
FROM (SELECT 1 as x) as t1
LEFT JOIN ( SELECT sum(number) as a from numbers(3) GROUP BY NULL) AS t2
ON TRUE
SETTINGS allow_experimental_analyzer=1, join_use_nulls=1;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
