WITH lhs(i, j, k) AS (VALUES
	(100, 10, 1),
	(200, 20, 2)
),
rhs(p, q, r) AS (VALUES
	(100, 10, 1),
	(200, 20, 2)
)
SELECT lhs.*, rhs.*
FROM lhs, rhs
WHERE i <= p AND j <> q AND k IS DISTINCT FROM r;
WITH lhs(i, j, k) AS (VALUES
	(100, 10, 1),
	(200, 20, 2)
),
rhs(p, q, r) AS (VALUES
	(100, 10, 1),
	(200, 20, 2)
)
SELECT lhs.*, rhs.*
FROM lhs, rhs
WHERE i <= p AND k >= r AND j <= q
ORDER BY i;
SELECT * FROM wide;
SELECT z FROM limits;
SELECT i, z
FROM wide, limits
WHERE c0 < z
  AND c1 < z
  AND c2 < z
  AND c3 < z
  AND c4 < z
  AND c5 < z
  AND c6 < z
  AND c7 < z
  AND c8 < z
  AND c9 < z
ORDER BY 1, 2;
SELECT * FROM wide_nulls;
SELECT * FROM limits_nulls;
SELECT i, z
FROM wide_nulls, limits_nulls
WHERE c0 < z
  AND c1 < z
  AND c2 < z
  AND c3 < z
  AND c4 < z
  AND c5 < z
  AND c6 < z
  AND c7 < z
  AND c8 < z
  AND c9 < z
ORDER BY 1, 2;
SELECT i, z
FROM wide, limits
WHERE z BETWEEN c8 AND c9
ORDER BY 1, 2;
SELECT i, z
FROM wide_nulls, limits_nulls
WHERE z BETWEEN c8 AND c9
ORDER BY 1, 2;
SELECT i, z
FROM wide, limits
WHERE z NOT BETWEEN c8 AND c9
ORDER BY 1, 2;
SELECT i, z
FROM wide_nulls, limits_nulls
WHERE z NOT BETWEEN c8 AND c9
ORDER BY 1, 2;
SELECT lhs.i, rhs.i
FROM wide_nulls lhs, wide_nulls rhs
WHERE lhs.c3 < rhs.c0
  AND lhs.c8 IS DISTINCT FROM rhs.c3
ORDER BY 1, 2;
EXPLAIN
SELECT lhs.i, rhs.i
FROM wide_nulls lhs, wide_nulls rhs
WHERE lhs.c3 < rhs.c0
  AND lhs.c8 IS DISTINCT FROM rhs.c3
ORDER BY 1, 2;
SELECT COUNT(*)
FROM many_values, many_bounds
WHERE val BETWEEN lo AND hi;
