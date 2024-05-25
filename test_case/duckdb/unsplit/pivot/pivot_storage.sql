PRAGMA enable_verification;
CREATE OR REPLACE TABLE monthly_sales(empid INT, amount INT, month TEXT);
INSERT INTO monthly_sales VALUES
    (1, 10000, 'JAN'),
    (1, 400, 'JAN'),
    (2, 4500, 'JAN'),
    (2, 35000, 'JAN'),
    (1, 5000, 'FEB'),
    (1, 3000, 'FEB'),
    (2, 200, 'FEB'),
    (2, 90500, 'FEB'),
    (1, 6000, 'MAR'),
    (1, 5000, 'MAR'),
    (2, 2500, 'MAR'),
    (2, 9500, 'MAR'),
    (1, 8000, 'APR'),
    (1, 10000, 'APR'),
    (2, 800, 'APR'),
    (2, 4500, 'APR');
CREATE VIEW v1 AS SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount) FOR MONTH IN ('JAN', 'FEB', 'MAR', 'APR'))
      AS p
  ORDER BY EMPID;
CREATE MACRO pivot_macro(val)
as TABLE SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount + val) FOR MONTH IN ('JAN', 'FEB', 'MAR', 'APR'))
      AS p
  ORDER BY EMPID;
FROM v1;
FROM pivot_macro(1);
FROM v1;
FROM pivot_macro(1);