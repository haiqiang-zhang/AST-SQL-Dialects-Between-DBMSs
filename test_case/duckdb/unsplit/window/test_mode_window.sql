SET default_null_order='nulls_first';
PRAGMA enable_verification;
PRAGMA verify_external;
create table modes as select range r from range(10) union all values (NULL), (NULL), (NULL);
SELECT r % 2, r, r//3, mode(r//3) over (partition by r % 2 order by r) FROM modes ORDER BY 1, 2;
SELECT r, r//3, mode(r//3) over (order by r rows between 1 preceding and 1 following) 
FROM modes 
ORDER BY ALL;
SELECT r, r//3, mode(r//3) over (order by r rows between 1 preceding and 3 following) FROM modes ORDER BY 1, 2;
SELECT r, r // 3, n, mode(n) over (partition by r % 3 order by r)
FROM (SELECT r, CASE r % 2 WHEN 0 THEN r ELSE NULL END AS n FROM modes) nulls
ORDER BY 1;
SELECT r, n, mode(n) over (order by r rows between 1 preceding and 1 following)
FROM (SELECT r, CASE r % 2 WHEN 0 THEN r ELSE NULL END AS n FROM modes) nulls
ORDER BY ALL;
SELECT r, n, mode(n) over (order by r rows between 1 preceding and 3 following)
FROM (SELECT r, CASE r % 2 WHEN 0 THEN r ELSE NULL END AS n FROM modes) nulls
ORDER BY 1;
SELECT r, n, mode(n) over (order by r rows between unbounded preceding and unbounded following)
FROM (SELECT r, CASE r % 2 WHEN 0 THEN r ELSE NULL END AS n FROM modes) nulls
ORDER BY 1;
WITH t(r) AS (VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (NULL), (NULL), (NULL))
SELECT r, r//3, mode(r//3) over (order by r rows between 1 preceding and 1 following) 
FROM t 
ORDER BY ALL;
