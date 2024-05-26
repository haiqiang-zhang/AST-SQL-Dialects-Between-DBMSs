WITH
helper AS (
  SELECT
    *
  FROM
    03033_example_table
  ORDER BY
    ColumnA WITH FILL INTERPOLATE (
      ColumnB AS ColumnC,
      ColumnC AS ColumnA
    )
)
SELECT ColumnB FROM helper;
DROP TABLE IF EXISTS 03033_example_table;
