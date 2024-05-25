-- This test exists to prevent unintended changes to existing behaviour.
--
-- Although this behaviour might not be ideal it can be exploited for 0-downtime changes to materialized views.
-- Step 1: Add new column to source table. Step 2: Create new view reading source column.
-- Step 3: Swap views using `RENAME TABLE`. Step 4: Add new column to destination table as well.
CREATE MATERIALIZED VIEW mv_extra_columns_view TO mv_extra_columns_dst
AS SELECT
  v1 as v,
  v2 as v2
FROM mv_extra_columns_src;
INSERT INTO mv_extra_columns_src VALUES (0, 0), (1, 1), (2, 2);
SELECT * FROM mv_extra_columns_dst ORDER by v;
DROP TABLE mv_extra_columns_view;
DROP TABLE mv_extra_columns_src;
DROP TABLE mv_extra_columns_dst;
