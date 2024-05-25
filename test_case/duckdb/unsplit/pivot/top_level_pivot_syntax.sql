PRAGMA enable_verification;
CREATE OR REPLACE TABLE monthly_sales(empid INT, amount INT, month TEXT);
INSERT INTO monthly_sales VALUES
    (1, 10000, '1-JAN'),
    (1, 400, '1-JAN'),
    (2, 4500, '1-JAN'),
    (2, 35000, '1-JAN'),
    (1, 5000, '2-FEB'),
    (1, 3000, '2-FEB'),
    (2, 200, '2-FEB'),
    (2, 90500, '2-FEB'),
    (1, 6000, '3-MAR'),
    (1, 5000, '3-MAR'),
    (2, 2500, '3-MAR'),
    (2, 9500, '3-MAR'),
    (1, 8000, '4-APR'),
    (1, 10000, '4-APR'),
    (2, 800, '4-APR'),
    (2, 4500, '4-APR');
ALTER TABLE monthly_sales ADD COLUMN status VARCHAR;
UPDATE monthly_sales SET status=CASE WHEN amount >= 10000 THEN 'important' ELSE 'regular' END;
CREATE VIEW v1 AS PIVOT monthly_sales ON MONTH IN ('1-JAN', '2-FEB', '3-MAR', '4-APR') USING SUM(AMOUNT) GROUP BY empid ORDER BY ALL;
PIVOT monthly_sales ON MONTH USING SUM(AMOUNT);
FROM (PIVOT monthly_sales ON MONTH USING SUM(AMOUNT));
PIVOT monthly_sales ON MONTH USING SUM(AMOUNT) GROUP BY empid;
PIVOT monthly_sales ON MONTH IN ('1-JAN', '2-FEB', '3-MAR', '4-APR') USING SUM(AMOUNT) GROUP BY empid;
PIVOT monthly_sales ON MONTH IN ('1-JAN', '2-FEB', '3-MAR') USING SUM(AMOUNT) GROUP BY empid;
PIVOT monthly_sales ON MONTH USING SUM(AMOUNT) GROUP BY empid;
FROM (PIVOT monthly_sales ON MONTH USING SUM(AMOUNT)) ORDER BY ALL;
PIVOT monthly_sales ON MONTH USING SUM(AMOUNT) GROUP BY empid ORDER BY ALL;
FROM (PIVOT monthly_sales ON MONTH USING SUM(AMOUNT) GROUP BY status) ORDER BY ALL;
SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount) FOR MONTH IN ('1-JAN', '2-FEB', '3-MAR', '4-APR') GROUP BY status)
      AS p
  ORDER BY 1;
WITH pivoted_sales AS (PIVOT monthly_sales ON MONTH USING SUM(AMOUNT) GROUP BY empid)
SELECT * FROM pivoted_sales ORDER BY empid DESC;
WITH pivoted_sales AS MATERIALIZED (PIVOT monthly_sales ON MONTH USING SUM(AMOUNT) GROUP BY empid)
SELECT * FROM pivoted_sales ORDER BY empid DESC;
FROM v1;
