PRAGMA enable_verification;
WITH t AS (
	SELECT i, RANK() OVER (ORDER BY i % 50) AS d
	FROM range(3000) tbl(i)
), w AS (
	SELECT d, COUNT(*) as c
	FROM t
	GROUP BY ALL
)
SELECT COUNT(*), MIN(d), MAX(d), MIN(c), MAX(c)
FROM w;
WITH t AS (
	SELECT i, RANK() OVER (PARTITION BY i // 3000 ORDER BY i % 50) AS d
	FROM range(9000) tbl(i)
), w AS (
	SELECT d, COUNT(*) as c
	FROM t
	GROUP BY ALL
)
SELECT COUNT(*), MIN(d), MAX(d), MIN(c), MAX(c)
FROM w;
SELECT 
	*, 
	RANK() OVER (ORDER BY x NULLS FIRST) rank_nulls_first,
	RANK() OVER (ORDER BY x NULLS LAST) rank_nulls_last,
FROM VALUES (1), (1), (1), (NULL) as issue8315(x)
ORDER BY x;
