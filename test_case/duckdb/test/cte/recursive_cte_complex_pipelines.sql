PRAGMA enable_verification;
CREATE TABLE a AS SELECT * FROM range(100) t1(i);
WITH RECURSIVE t AS
(
	SELECT 1 AS x
UNION
	SELECT t1.x + t2.x + t3.x AS x
	FROM t t1, t t2, t t3
	WHERE t1.x < 100
)
SELECT * FROM t ORDER BY 1;;
WITH RECURSIVE t AS
(
	SELECT 1 AS x
UNION
	SELECT (t1.x + t2.x + t3.x)::HUGEINT AS x
	FROM t t1, t t2, t t3
	WHERE t1.x < 100
)
SELECT * FROM t ORDER BY 1;;
WITH RECURSIVE t AS
(
	SELECT 1 AS x
UNION
	SELECT SUM(x) AS x
	FROM t, a
	WHERE x < 1000000
)
SELECT * FROM t ORDER BY 1 NULLS LAST;;
WITH RECURSIVE t AS
(
	SELECT 1 AS x
UNION
	SELECT SUM(x) AS x
	FROM t, a
	WHERE x < 1000000 AND t.x=a.i
)
SELECT * FROM t ORDER BY 1 NULLS LAST;;
WITH RECURSIVE t AS
(
	SELECT 1 AS x
UNION
	SELECT SUM(x)
	FROM
		(SELECT SUM(x) FROM t) t1(x), a
	WHERE x < 1000
)
SELECT * FROM t ORDER BY 1 NULLS LAST;;
WITH RECURSIVE t AS
(
	SELECT 1 AS x
UNION
	SELECT (SELECT x + 1 FROM t) AS x
	FROM t
	WHERE x < 5
)
SELECT * FROM t ORDER BY 1 NULLS LAST;;
WITH RECURSIVE t AS
(
	SELECT 1 AS x
UNION
	SELECT (SELECT t.x+t2.x FROM t t2 LIMIT 1) AS x
	FROM t
	WHERE x < 10
)
SELECT * FROM t ORDER BY 1 NULLS LAST;;
