PRAGMA enable_verification;
CREATE TABLE a AS SELECT * FROM range(100) t1(i);;
SELECT x, y
FROM   generate_series(1,4) AS _(x), LATERAL
(WITH RECURSIVE t(y) AS (
  SELECT _.x
    UNION ALL
  SELECT y + 1
  FROM   t
  WHERE y < 3
)
SELECT * FROM t) AS t
ORDER BY x, y;;
SELECT x, y
FROM   generate_series(1,4) AS _(x), LATERAL
(WITH RECURSIVE t(y) AS (
  SELECT 1
    UNION ALL
  SELECT y + _.x
  FROM   t
  WHERE y < 3
)
SELECT * FROM t) AS t
ORDER BY x, y;;
SELECT x, y
FROM   generate_series(1,4) AS _(x), LATERAL
(WITH RECURSIVE t(y) AS (
  SELECT _.x
    UNION ALL
  SELECT y + _.x
  FROM   t
  WHERE y < 3
)
SELECT * FROM t) AS t
ORDER BY x, y;;
SELECT x, y
FROM   generate_series(1,4) AS _(x), LATERAL
(WITH RECURSIVE t(y) AS (
  SELECT _.x
    UNION ALL
  SELECT t1.y + t2.y + _.x
  FROM   t AS t1, t AS t2
  WHERE t1.y < 3
)
SELECT * FROM t) AS t
ORDER BY x, y;;
SELECT x, y, (WITH RECURSIVE t(z) AS (
  SELECT x + y
    UNION ALL
  SELECT z + 1
  FROM   t
  WHERE z < 3
) SELECT sum(z) FROM t) AS z
FROM   generate_series(1,2) AS _(x), generate_series(1,2) AS __(y);;
SELECT x, y, (WITH RECURSIVE t(z) AS (
  SELECT x + y
    UNION ALL
  SELECT z + 1
  FROM   (WITH RECURSIVE g(a) AS (
          SELECT t.z
          FROM   t
            UNION ALL
          SELECT g.a + (x + y) / 2
          FROM   g
          WHERE  g.a < 3)
          SELECT * FROM g) AS t(z)
  WHERE z < 5
) SELECT sum(z) FROM t) AS z
FROM   generate_series(1,2) AS _(x), generate_series(1,2) AS __(y);;
SELECT t2.*
FROM (VALUES (1000000)) t(_corr), LATERAL (
WITH RECURSIVE t AS
(
	SELECT 1 AS x
UNION
	SELECT SUM(x) AS x
	FROM t, a
	WHERE x < _corr
)
SELECT * FROM t) t2
ORDER BY 1 NULLS LAST;;
SELECT t2.*
FROM (VALUES (10)) t(_corr), LATERAL (
WITH RECURSIVE t AS
(
	SELECT 1 AS x
UNION
	SELECT (SELECT t.x+t2.x FROM t t2 LIMIT 1) AS x
	FROM t
	WHERE x < _corr
)
SELECT * FROM t) t2
ORDER BY 1 NULLS LAST;;
SELECT t2.*
FROM (VALUES (1)) t(_corr), LATERAL (
WITH RECURSIVE collatz(x, t, steps) AS
(
  SELECT x, x, 0
  FROM   (WITH RECURSIVE n(t) AS (SELECT _corr UNION ALL SELECT t+_corr FROM n WHERE t < 10) SELECT * FROM n) AS _(x)
    UNION ALL
  (SELECT x, CASE WHEN t%2 = _corr THEN t * 3 + p ELSE t / 2 END, steps + p
   FROM   collatz, (WITH RECURSIVE n(t) AS (SELECT _corr UNION ALL SELECT t+_corr FROM n WHERE t < _corr) SELECT * FROM n) AS _(p)
   WHERE  t <> _corr)
)
SELECT * FROM collatz WHERE t = _corr
ORDER BY x
) t2;;
SELECT x, y
FROM   generate_series(1,4) AS _(x), LATERAL
(WITH RECURSIVE t(y) AS (
  SELECT _.x
    UNION
  SELECT y + 1
  FROM   t
  WHERE y < 3
)
SELECT * FROM t) AS t
ORDER BY x, y;;
SELECT x, y
FROM   generate_series(1,4) AS _(x), LATERAL
(WITH RECURSIVE t(y) AS (
  SELECT 1
    UNION
  SELECT y + _.x
  FROM   t
  WHERE y < 3
)
SELECT * FROM t) AS t
ORDER BY x, y;;
SELECT x, y
FROM   generate_series(1,4) AS _(x), LATERAL
(WITH RECURSIVE t(y) AS (
  SELECT _.x
    UNION
  SELECT y + _.x
  FROM   t
  WHERE y < 3
)
SELECT * FROM t) AS t
ORDER BY x, y;;
SELECT x, y
FROM   generate_series(1,4) AS _(x), LATERAL
(WITH RECURSIVE t(y) AS (
  SELECT _.x
    UNION
  SELECT t1.y + t2.y + _.x
  FROM   t AS t1, t AS t2
  WHERE t1.y < 3
)
SELECT * FROM t) AS t
ORDER BY x, y;;
SELECT x, y, (WITH RECURSIVE t(z) AS (
  SELECT x + y
    UNION
  SELECT z + 1
  FROM   t
  WHERE z < 3
) SELECT sum(z) FROM t) AS z
FROM   generate_series(1,2) AS _(x), generate_series(1,2) AS __(y);;
SELECT x, y, (WITH RECURSIVE t(z) AS (
  SELECT x + y
    UNION
  SELECT z + 1
  FROM   (WITH RECURSIVE g(a) AS (
          SELECT t.z
          FROM   t
            UNION
          SELECT g.a + (x + y) / 2
          FROM   g
          WHERE  g.a < 3)
          SELECT * FROM g) AS t(z)
  WHERE z < 5
) SELECT sum(z) FROM t) AS z
FROM   generate_series(1,2) AS _(x), generate_series(1,2) AS __(y);;
