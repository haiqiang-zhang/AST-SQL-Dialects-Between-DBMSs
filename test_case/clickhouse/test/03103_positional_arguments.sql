SELECT *
FROM
(
    SELECT
        name,
        age
    FROM users
)
GROUP BY
    1,
    2
ORDER BY ALL;
SELECT *
FROM
(
	SELECT *
	FROM
	(
    	SELECT
        	name,
        	age
    	FROM users
	)
	GROUP BY
    	1,
    	2
)
ORDER BY ALL;
DROP TABLE IF EXISTS users;
