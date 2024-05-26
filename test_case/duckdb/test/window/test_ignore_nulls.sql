SELECT
  id,
  user_id,
  order_id,
  LAST_VALUE (order_id IGNORE NULLS) over (
    PARTITION BY user_id
    ORDER BY id
    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
  ) AS last_order_id
FROM issue2549
ORDER BY ALL;
SELECT
  id,
  user_id,
  order_id,
  FIRST_VALUE (order_id IGNORE NULLS) over (
    PARTITION BY user_id
    ORDER BY id
    ROWS BETWEEN 1 PRECEDING AND UNBOUNDED FOLLOWING
  ) AS last_order_id
FROM issue2549
ORDER BY ALL;
SELECT
  id,
  user_id,
  order_id,
  NTH_VALUE (order_id, 2 IGNORE NULLS) over (
    PARTITION BY user_id
    ORDER BY id
    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
  ) AS last_order_id
FROM issue2549
ORDER BY ALL;
SELECT
  id,
  user_id,
  order_id,
  LEAD(order_id, 1, -1 IGNORE NULLS) over (
    PARTITION BY user_id
    ORDER BY id
  ) AS last_order_id
FROM issue2549
ORDER BY ALL;
SELECT
  id,
  user_id,
  order_id,
  LAG(order_id, 1, -1 IGNORE NULLS) over (
    PARTITION BY user_id
    ORDER BY id
  ) AS last_order_id
FROM issue2549
ORDER BY ALL;
SELECT
  id,
  user_id,
  order_id,
  LAG(order_id, 0, -1 IGNORE NULLS) over (
    PARTITION BY user_id
    ORDER BY id
  ) AS last_order_id
FROM issue2549
ORDER BY ALL;
SELECT
  id,
  user_id,
  order_id,
  LAST_VALUE (order_id RESPECT NULLS) over (
    PARTITION BY user_id
    ORDER BY id
    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
  ) AS last_order_id
FROM issue2549
ORDER BY ALL;
SELECT
  id,
  user_id,
  order_id,
  FIRST_VALUE (order_id RESPECT NULLS) over (
    PARTITION BY user_id
    ORDER BY id
    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
  ) AS last_order_id
FROM issue2549
ORDER BY ALL;
SELECT
  id,
  user_id,
  order_id,
  NTH_VALUE (order_id, 2 RESPECT NULLS) over (
    PARTITION BY user_id
    ORDER BY id
    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
  ) AS last_order_id
FROM issue2549
ORDER BY ALL;
SELECT
  id,
  user_id,
  order_id,
  LEAD(order_id, 1, -1 RESPECT NULLS) over (
    PARTITION BY user_id
    ORDER BY id
  ) AS last_order_id
FROM issue2549
ORDER BY ALL;
SELECT
  id,
  user_id,
  order_id,
  LAG(order_id, 1, -1 RESPECT NULLS) over (
    PARTITION BY user_id
    ORDER BY id
  ) AS last_order_id
FROM issue2549
ORDER BY ALL;
SELECT
  id,
  user_id,
  order_id,
  LAG(order_id, 0, -1 RESPECT NULLS) over (
    PARTITION BY user_id
    ORDER BY id
  ) AS last_order_id
FROM issue2549
ORDER BY ALL;
SELECT *, 
	first(data IGNORE NULLS) OVER w, 
	last(data IGNORE NULLS) OVER w,
	nth_value(data, 1 IGNORE NULLS) OVER w
FROM issue6635
WINDOW w AS (
	ORDER BY index 
	ROWS BETWEEN 1 FOLLOWING 
	 AND UNBOUNDED FOLLOWING
);
WITH gen AS (
    SELECT *,
        ((id * 1327) % 9973) / 10000.0 AS rnd
    FROM generate_series(1, 10000) tbl(id)
),
lvl AS (
    SELECT id,
        rnd,
        CASE
            WHEN rnd <= 0.1 THEN 'shallow'
            WHEN rnd >= 0.9 THEN 'high'
        END AS water_level
    FROM gen
)
SELECT *,
    LAST_VALUE(water_level IGNORE NULLS) OVER (
        ORDER BY id
    ) AS grade
FROM lvl
ORDER BY id;
