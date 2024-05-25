SELECT c, count(*) FROM test_missing_target GROUP BY test_missing_target.c ORDER BY c;
SELECT count(*) FROM test_missing_target GROUP BY test_missing_target.c ORDER BY c;
SELECT count(*) FROM test_missing_target GROUP BY b ORDER BY b;
SELECT test_missing_target.b, count(*)
  FROM test_missing_target GROUP BY b ORDER BY b;
SELECT c FROM test_missing_target ORDER BY a;
SELECT count(*) FROM test_missing_target GROUP BY b ORDER BY b desc;
SELECT count(*) FROM test_missing_target ORDER BY 1 desc;
SELECT c, count(*) FROM test_missing_target GROUP BY 1 ORDER BY 1;
SELECT a, a FROM test_missing_target
	ORDER BY a;
SELECT a/2, a/2 FROM test_missing_target
	ORDER BY a/2;
SELECT a/2, a/2 FROM test_missing_target
	GROUP BY a/2 ORDER BY a/2;
SELECT x.b, count(*) FROM test_missing_target x, test_missing_target y
	WHERE x.a = y.a
	GROUP BY x.b ORDER BY x.b;
SELECT count(*) FROM test_missing_target x, test_missing_target y
	WHERE x.a = y.a
	GROUP BY x.b ORDER BY x.b;
CREATE TABLE test_missing_target2 AS
SELECT count(*)
FROM test_missing_target x, test_missing_target y
	WHERE x.a = y.a
	GROUP BY x.b ORDER BY x.b;
SELECT * FROM test_missing_target2;
SELECT a%2, count(b) FROM test_missing_target
GROUP BY test_missing_target.a%2
ORDER BY test_missing_target.a%2;
SELECT count(c) FROM test_missing_target
GROUP BY lower(test_missing_target.c)
ORDER BY lower(test_missing_target.c);
SELECT count(b) FROM test_missing_target GROUP BY b/2 ORDER BY b/2;
SELECT lower(test_missing_target.c), count(c)
  FROM test_missing_target GROUP BY lower(c) ORDER BY lower(c);
SELECT a FROM test_missing_target ORDER BY upper(d);
SELECT count(b) FROM test_missing_target
	GROUP BY (b + 1) / 2 ORDER BY (b + 1) / 2 desc;
SELECT x.b/2, count(x.b) FROM test_missing_target x, test_missing_target y
	WHERE x.a = y.a
	GROUP BY x.b/2 ORDER BY x.b/2;
CREATE TABLE test_missing_target3 AS
SELECT count(x.b)
FROM test_missing_target x, test_missing_target y
	WHERE x.a = y.a
	GROUP BY x.b/2 ORDER BY x.b/2;
SELECT * FROM test_missing_target3;
DROP TABLE test_missing_target;
DROP TABLE test_missing_target2;
DROP TABLE test_missing_target3;
