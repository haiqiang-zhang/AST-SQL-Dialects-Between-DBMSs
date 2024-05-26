PRAGMA enable_verification;
CREATE TABLE wide AS (
	SELECT
		i,
		10 * (i + 0) AS c0,
		10 * (i + 1) AS c1,
		10 * (i + 2) AS c2,
		10 * (i + 3) AS c3,
		10 * (i + 4) AS c4,
		10 * (i + 5) AS c5,
		10 * (i + 6) AS c6,
		10 * (i + 7) AS c7,
		10 * (i + 8) AS c8,
		10 * (i + 9) AS c9
	FROM range(1, 10) tbl(i)
);
CREATE TABLE limits AS (
	SELECT 100 + (i * 17 % 100) AS z
	FROM range(1, 10) tbl(i)
);
CREATE TABLE wide_nulls AS (
	SELECT i, c0, c1, c2,
		CASE WHEN i % 7 = 0 THEN NULL ELSE c3 END AS c3,
		c4, c5, c6, c7,
		CASE WHEN i % 5 = 0 THEN NULL ELSE c8 END AS c8,
		c9
	FROM wide
);
CREATE TABLE limits_nulls AS (
	SELECT CASE WHEN z % 9 = 0 THEN NULL ELSE z END AS z
	FROM limits
);
CREATE TABLE many_bounds AS (
	SELECT * FROM (VALUES (2000, 4000)) tbl(lo, hi)
);
CREATE TABLE many_values AS (
	SELECT * from range(10 * 1024) tbl(val)
);
