SELECT * FROM (SELECT sum(x) AS a, avg(x) AS b FROM (SELECT number AS x FROM numbers(10)));
SELECT a, b FROM (SELECT sum(x) AS a, avg(x) AS b FROM (SELECT number AS x FROM numbers(10)));
SELECT a FROM (SELECT sum(x) AS a, avg(x) AS b FROM (SELECT number AS x FROM numbers(10)));
SELECT b FROM (SELECT sum(x) AS a, avg(x) AS b FROM (SELECT number AS x FROM numbers(10)));
SELECT 1 FROM (SELECT sum(x) AS a, avg(x) AS b FROM (SELECT number AS x FROM numbers(10)));
SELECT 1 FROM (SELECT sum(x), avg(x) FROM (SELECT number AS x FROM numbers(10)));
SELECT count() FROM (SELECT sum(x) AS a, avg(x) AS b FROM (SELECT number AS x FROM numbers(10)));
SELECT 1 FROM (SELECT DISTINCT sum(x), avg(x) FROM (SELECT number AS x FROM numbers(10)));
SELECT 1 FROM (SELECT arrayJoin([sum(x), medianExact(x)]), arrayJoin([min(x), max(x)]) FROM (SELECT number AS x FROM numbers(10)));
