PRAGMA force_compression='dictionary';
CREATE TABLE test (a VARCHAR[]);;
INSERT INTO test SELECT CASE WHEN i%2=0 THEN [] ELSE ['Hello', 'World'] END FROM range(10000) t(i);;
CREATE TABLE test2 AS SELECT * FROM test ORDER BY a;
SELECT MIN(t), MAX(t), COUNT(t) FROM (SELECT a[2] FROM test) t(t);
SELECT SUM(CASE WHEN a IS DISTINCT FROM ['Hello', 'World'] THEN 1 ELSE 0 END) FROM test;
SELECT COUNT(*) FROM test WHERE a=['Hello', 'World'];
SELECT DISTINCT a FROM test ORDER BY ALL;
SELECT MIN(t), MAX(t), COUNT(t) FROM (SELECT a[2:2] FROM test) t(t);
SELECT * FROM test2 LIMIT 3;
SELECT * FROM test2 LIMIT 3 OFFSET 5000;
SELECT MIN(t), MAX(t) FROM (SELECT UNNEST(a) AS t FROM test) t(t);
SELECT COUNT(*) FROM test WHERE a IN (SELECT * FROM test);
SELECT MIN(t), MAX(t), MIN(t[1]), MAX(t[1]), MIN(t[2]), MAX(t[2]) FROM (SELECT [lower(x) for x in a] FROM test) t(t);
SELECT MIN(t), MAX(t) FROM (SELECT [lower(x) for x in a if x!='Hello'] FROM test) t(t);
SELECT MIN(a), MAX(a), MIN(b), MAX(b) FROM (SELECT list_min(a), list_max(a) FROM test) t(a, b);
SELECT MIN(list_sort(a)[2]) FROM test;
SELECT COUNT(*) FROM test WHERE array_contains(a, 'World');
