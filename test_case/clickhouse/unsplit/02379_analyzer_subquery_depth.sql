SET allow_experimental_analyzer = 1;
SELECT (SELECT a FROM (SELECT 1 AS a)) SETTINGS max_subquery_depth = 2;