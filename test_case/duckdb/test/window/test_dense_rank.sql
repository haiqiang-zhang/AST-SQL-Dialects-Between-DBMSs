WITH t AS (
	SELECT i, DENSE_RANK() OVER (ORDER BY i % 50) AS d
	FROM range(3000) tbl(i)
), w AS (
	SELECT d, COUNT(*) as c
	FROM t
	GROUP BY ALL
)
SELECT COUNT(*), MIN(d), MAX(d), MIN(c), MAX(c)
FROM w;
WITH t AS (
	SELECT i, DENSE_RANK() OVER (PARTITION BY i // 3000 ORDER BY i % 50) AS d
	FROM range(9000) tbl(i)
), w AS (
	SELECT d, COUNT(*) as c
	FROM t
	GROUP BY ALL
)
SELECT COUNT(*), MIN(d), MAX(d), MIN(c), MAX(c)
FROM w;
WITH dups AS (
  SELECT ROW_NUMBER() OVER same_idx AS dup
  , COUNT(*) OVER same_idx AS n_dup
  , (DENSE_RANK() OVER asc_spcmn) + (DENSE_RANK() OVER desc_spcmn) - 1 AS n_spcmn
  , *
  FROM issue9416
  WINDOW same_idx AS (
    PARTITION BY idx
    ORDER BY source, project, specimen
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  )
  , asc_spcmn AS (
    PARTITION BY idx
    ORDER BY specimen ASC NULLS FIRST
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  )
  , desc_spcmn AS (
    PARTITION BY idx
    ORDER BY specimen DESC NULLS LAST
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  )
)
SELECT *
FROM dups
WHERE n_spcmn > 1
ORDER BY idx, dup;
