SELECT b, c FROM test_having
	GROUP BY b, c HAVING count(*) = 1 ORDER BY b, c;
SELECT b, c FROM test_having
	GROUP BY b, c HAVING b = 3 ORDER BY b, c;
SELECT lower(c), count(c) FROM test_having
	GROUP BY lower(c) HAVING count(*) > 2 OR min(a) = max(a)
	ORDER BY lower(c);
SELECT c, max(a) FROM test_having
	GROUP BY c HAVING count(*) > 2 OR min(a) = max(a)
	ORDER BY c;
SELECT min(a), max(a) FROM test_having HAVING min(a) = max(a);
SELECT min(a), max(a) FROM test_having HAVING min(a) < max(a);
SELECT 1 AS one FROM test_having HAVING 1 > 2;
SELECT 1 AS one FROM test_having HAVING 1 < 2;
SELECT 1 AS one FROM test_having WHERE 1/a = 1 HAVING 1 < 2;
DROP TABLE test_having;
