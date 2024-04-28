PRAGMA enable_verification;
CREATE TABLE issue7353 (
    Season VARCHAR,
    Medal VARCHAR,
    Sex VARCHAR,
    Ct INT,
    Depth INT
);;
INSERT INTO issue7353 (Season, Medal, Sex, Ct, Depth) VALUES
    (NULL, NULL, NULL, 271116, 0),
    ('Summer', NULL, NULL, 222552, 1),
    ('Winter', NULL, NULL, 48564, 1),
    ('Summer', 'NA', NULL, 188464, 2),
    ('Summer', 'Gold', NULL, 11459, 2),
    ('Winter', 'NA', NULL, 42869, 2),
    ('Summer', 'Bronze', NULL, 11409, 2),
    ('Winter', 'Bronze', NULL, 1886, 2),
    ('Winter', 'Gold', NULL, 1913, 2),
    ('Winter', 'Silver', NULL, 1896, 2),
    ('Summer', 'Silver', NULL, 11220, 2),
    ('Summer', 'NA', 'M', 138463, 3),
    ('Summer', 'Gold', 'M', 8319, 3),
    ('Winter', 'NA', 'F', 13268, 3),
    ('Winter', 'NA', 'M', 29601, 3),
    ('Summer', 'NA', 'F', 50001, 3),
    ('Summer', 'Bronze', 'M', 8235, 3),
    ('Winter', 'Bronze', 'M', 1289, 3),
    ('Winter', 'Gold', 'M', 1306, 3),
    ('Winter', 'Silver', 'M', 1289, 3),
    ('Summer', 'Gold', 'F', 3140, 3),
    ('Summer', 'Silver', 'M', 8092, 3),
    ('Summer', 'Bronze', 'F', 3174, 3),
    ('Summer', 'Silver', 'F', 3128, 3),
    ('Winter', 'Bronze', 'F', 597, 3),
    ('Winter', 'Gold', 'F', 607, 3),
    ('Winter', 'Silver', 'F', 607, 3);;
PRAGMA default_null_order='NULLS LAST';;
SELECT part, id, sum(val) OVER(PARTITION BY part ORDER BY id), lead(val) OVER(PARTITION BY part ORDER BY id)
FROM (SELECT range AS id, range % 5 AS part, range AS val FROM range(13)) t
ORDER BY ALL;;
SELECT part, id, list_sort(list(val) OVER(PARTITION BY part))
FROM (SELECT range AS id, range % 5 AS part, range AS val FROM range(13)) t
ORDER BY ALL;;
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
ORDER BY ALL
;;
SELECT part, min(const) AS lo, max(const) AS hi
FROM (
	SELECT part, sum(val) OVER(PARTITION BY part) AS const
	FROM (
		SELECT part, val
		FROM (
			(SELECT range as part, random() AS val FROM range(10)) r
		CROSS JOIN 
			range(3000)
		) p
	) t
) w
GROUP BY ALL
HAVING lo <> hi
ORDER BY ALL
;;
SELECT *, max(Ct) FILTER (WHERE Depth=1) OVER (PARTITION BY Season) as value_depth1 
from issue7353
order by all;;
