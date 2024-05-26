SELECT r % 2, r, median(r) over (partition by r % 2 order by r) FROM quantiles ORDER BY 1, 2;
SELECT r, median(r) over (order by r rows between 1 preceding and 1 following) FROM quantiles ORDER BY 1, 2;
SELECT r, median(r) over (order by r rows between 1 preceding and 3 following) FROM quantiles ORDER BY 1, 2;
SELECT r, quantile(r, 0.5) over (order by r rows between 1 preceding and 3 following) FROM quantiles ORDER BY 1, 2;
SELECT r % 2, r, median(r::VARCHAR) over (partition by r % 2 order by r) FROM quantiles ORDER BY 1, 2;
SELECT r, median(r::VARCHAR) over (order by r rows between 1 preceding and 1 following) FROM quantiles ORDER BY 1, 2;
SELECT r, quantile(r::VARCHAR, 0.5) over (order by r rows between 1 preceding and 3 following) FROM quantiles ORDER BY 1, 2;
SELECT r, median('prefix-' || r::VARCHAR || '-suffix') over (order by r rows between 1 preceding and 1 following) FROM quantiles ORDER BY 1, 2;
SELECT r % 3, r, n, median(n) over (partition by r % 3 order by r)
FROM (SELECT r, CASE r % 2 WHEN 0 THEN r ELSE NULL END AS n FROM quantiles) nulls
ORDER BY 1, 2;
SELECT r, n, median(n) over (order by r rows between 1 preceding and 1 following)
FROM (SELECT r, CASE r % 2 WHEN 0 THEN r ELSE NULL END AS n FROM quantiles) nulls
ORDER BY 1;
SELECT r, n, median(n) over (order by r rows between 1 preceding and 3 following)
FROM (SELECT r, CASE r % 2 WHEN 0 THEN r ELSE NULL END AS n FROM quantiles) nulls
ORDER BY 1;
SELECT r, n, median(n) over (order by r rows between unbounded preceding and unbounded following)
FROM (SELECT r, CASE r % 2 WHEN 0 THEN r ELSE NULL END AS n FROM quantiles) nulls
ORDER BY 1;
WITH t(i, p, f) AS (VALUES
	(0, 1, 1),
	(1, 1, 1),
	(2, 1, 1),
	(3, 3, 1),
	(4, 1, 1),
	(5, 3, 1)
)
SELECT i, MEDIAN(i) OVER (ORDER BY i ROWS BETWEEN p PRECEDING and f FOLLOWING)
FROM t
ORDER BY 1;
WITH t(r, i, p, f) AS (VALUES
	(0, 0, 1, 1),
	(1, 1, 1, 1),
	(2, 2, 1, 1),
	(3, 0, 1, 1),
	(4, 1, 1, 1),
	(5, 2, 1, 1)
)
SELECT r, MEDIAN(i) OVER (ORDER BY r ROWS BETWEEN p PRECEDING and f FOLLOWING)
FROM t
ORDER BY 1;
WITH t(r, i, p, f) AS (VALUES
	(0, 0, 1, 2),
	(1, 1, 1, 2),
	(2, 2, 1, 2),
	(3, 3, 1, 2),
	(4, 4, 1, 2),
	(5, 5, 1, 2)
)
SELECT r, QUANTILE_DISC(i, [0.25, 0.5, 0.75]) OVER (ORDER BY r ROWS BETWEEN p PRECEDING and f FOLLOWING)
FROM t
ORDER BY 1;
WITH t(r, i, p, f) AS (VALUES
	(0, NULL, 1, 2),
	(1, 1, 1, 2),
	(2, 2, 1, 2),
	(3, 3, 1, 2),
	(4, 4, 1, 2),
	(5, 5, 1, 2)
)
SELECT r, QUANTILE_DISC(i, [0.25, 0.5, 0.75]) OVER (ORDER BY r ROWS BETWEEN p PRECEDING and f FOLLOWING)
FROM t
ORDER BY 1;
WITH t(r, i, p, f) AS (VALUES
	(0, NULL, 1, 2),
	(1, NULL, 1, 2),
	(2, NULL, 1, 2),
	(3, NULL, 1, 2),
	(4, NULL, 1, 2),
	(5, NULL, 1, 2)
)
SELECT r, QUANTILE_DISC(i, [0.25, 0.5, 0.75]) OVER (ORDER BY r ROWS BETWEEN p PRECEDING and f FOLLOWING)
FROM t
ORDER BY 1;
WITH t(r, i, p, f) AS (VALUES
	(0, 0, 1, 2),
	(1, 1, 1, 2),
	(2, 2, 1, 2),
	(3, 3, 1, 2),
	(4, 4, 1, 2),
	(5, 5, 1, 2)
)
SELECT r, QUANTILE_CONT(i, [0.25, 0.5, 0.75]) OVER (ORDER BY r ROWS BETWEEN p PRECEDING and f FOLLOWING)
FROM t
ORDER BY 1;
WITH t(r, i, p, f) AS (VALUES
	(0, 0, 1, 2),
	(1, 1, 1, 2),
	(2, 2, 1, 2),
	(3, 0, 1, 2),
	(4, 1, 1, 2),
	(5, 2, 1, 2)
)
SELECT r, QUANTILE_CONT(i, [0.25, 0.5, 0.75]) OVER (ORDER BY r ROWS BETWEEN p PRECEDING and f FOLLOWING)
FROM t
ORDER BY 1;
SELECT r, quantile_disc(i, 0.5) OVER (ORDER BY r ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) q
FROM (VALUES
	(0, 0),
	(1, 1),
	(2, 2),
	(3, 0),
	(4, 1)
	) tbl(r, i)
ORDER BY 1, 2;
SELECT r, quantile_cont(i, 0.5) OVER (ORDER BY r ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING) q
FROM (VALUES
	(0, 0),
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 0),
	(5, 1)
	) tbl(r, i)
ORDER BY 1, 2;
SELECT r, quantile_cont(i, 0.5) OVER (ORDER BY r ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING) q
FROM (VALUES
	(0, NULL),
	(1, 1),
	(2, 2),
	(3, 3),
	(4, NULL),
	(5, 1)
	) tbl(r, i)
ORDER BY 1, 2;
WITH t(r, i, p, f) AS (VALUES
	(0, 0, 1, 1),
	(1, 1, 1, 1),
	(2, 2, 1, 1),
	(3, 0, 1, 1),
	(4, 1, 1, 1),
	(5, 2, 1, 1)
)
SELECT r, MEDIAN(i) OVER (ORDER BY r ROWS BETWEEN p PRECEDING and f FOLLOWING)
FROM t
ORDER BY 1;
WITH t(r, i, p, f) AS (VALUES
	(0, 0, 1, 1),
	(1, 1, 1, 1),
	(2, 2, 1, 1),
	(3, 0, 1, 1),
	(4, 1, 1, 1),
	(5, 2, 1, 1)
)
SELECT r, QUANTILE_DISC(i, 0.5) OVER (ORDER BY r ROWS BETWEEN p PRECEDING and f FOLLOWING)
FROM t
ORDER BY 1;
WITH t(r, i, p, f) AS (VALUES
	(0, NULL, 1, 2),
	(1, 1, 1, 2),
	(2, 2, 1, 2),
	(3, 3, 1, 2),
	(4, 4, 1, 2),
	(5, 5, 1, 2)
)
SELECT r, QUANTILE_DISC(i, [0.25, 0.5, 0.75]) OVER (ORDER BY r ROWS BETWEEN p PRECEDING and f FOLLOWING)
FROM t
ORDER BY 1;
WITH t(r, i, p, f) AS (VALUES
	(0, 0, 1, 2),
	(1, 1, 1, 2),
	(2, 2, 1, 2),
	(3, 0, 1, 2),
	(4, 1, 1, 2),
	(5, 2, 1, 2)
)
SELECT r, QUANTILE_CONT(i, [0.25, 0.5, 0.75]) OVER (ORDER BY r ROWS BETWEEN p PRECEDING and f FOLLOWING)
FROM t
ORDER BY 1;
