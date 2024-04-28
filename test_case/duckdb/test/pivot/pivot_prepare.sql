CREATE OR REPLACE TABLE monthly_sales(empid INT, amount INT, month TEXT);;
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
    (2, 4500, '4-APR');;
PREPARE v1 AS SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount + ?) FOR MONTH IN ('1-JAN', '2-FEB', '3-MAR', '4-APR'))
      AS p
  ORDER BY EMPID;;
PREPARE v2 AS
   PIVOT monthly_sales ON MONTH USING SUM(AMOUNT + ?);
PREPARE v3 AS
   PIVOT (SELECT empid, amount + ? AS amount, month FROM monthly_sales) ON MONTH USING SUM(AMOUNT);
EXECUTE v1(0);
EXECUTE v1(1);
EXECUTE v2(1);