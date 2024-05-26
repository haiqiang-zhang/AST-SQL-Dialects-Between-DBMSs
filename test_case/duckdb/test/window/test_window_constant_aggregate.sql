SELECT part, id, sum(val) OVER(PARTITION BY part ORDER BY id), lead(val) OVER(PARTITION BY part ORDER BY id)
FROM (SELECT range AS id, range % 5 AS part, range AS val FROM range(13)) t
ORDER BY ALL;
SELECT part, id, list_sort(list(val) OVER(PARTITION BY part))
FROM (SELECT range AS id, range % 5 AS part, range AS val FROM range(13)) t
ORDER BY ALL;
SELECT part, min(const) AS lo, max(const) AS hi
FROM (
	SELECT part, sum(val) OVER(PARTITION BY part) as const
	FROM (
		(SELECT 1 AS part, range AS val FROM range(73))
	UNION ALL
		(SELECT 2 AS part, range AS val FROM range(75))
	UNION ALL
		(SELECT 3 AS part, range AS val FROM range(77))
	UNION ALL
		(SELECT 4 AS part, range AS val FROM range(79))
	UNION ALL
		(SELECT 5 AS part, range AS val FROM range(81))
	UNION ALL
		(SELECT 6 AS part, range AS val FROM range(83))
	) u
) t
GROUP BY ALL
ORDER BY ALL;
SELECT *, max(Ct) FILTER (WHERE Depth=1) OVER (PARTITION BY Season) as value_depth1 
from issue7353
order by all;
