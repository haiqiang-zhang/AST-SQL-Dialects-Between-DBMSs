PRAGMA enable_verification;
CREATE OR REPLACE TABLE sales(empid INT, amount INT, month TEXT, year INT);;
INSERT INTO sales VALUES
    (1, 10000, 'JAN', 2020),
    (1, 400, 'JAN', 2021),
    (2, 4500, 'JAN', 2021),
    (2, 35000, 'JAN', 2020),
    (1, 5000, 'FEB', 2020),
    (1, 3000, 'FEB', 2021),
    (2, 200, 'FEB', 2021),
    (2, 90500, 'FEB', 2020),
    (1, 6000, 'MAR', 2021),
    (1, 5000, 'MAR', 2021),
    (2, 2500, 'MAR', 2021),
    (2, 9500, 'MAR', 2021),
    (1, 8000, 'APR', 2020),
    (1, 10000, 'APR', 2020),
    (2, 800, 'APR', 2021),
    (2, 4500, 'APR', 2020);;
SET pivot_limit=10000;
SELECT *
  FROM sales
    PIVOT(
    	SUM(amount)
    	FOR YEAR IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
    		MONTH IN ('JAN', 'FEB', 'MAR', 'APR')
    		amount IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
    		empid IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
    ) AS p
  ORDER BY EMPID;;
SELECT *
  FROM sales
    PIVOT(
        SUM(amount)
        FOR YEAR IN (2020, 2021)
            MONTH IN ('JAN', 'FEB', 'MAR', 'APR')
    ) AS p
  ORDER BY EMPID;;
SELECT *
  FROM sales
    PIVOT(
        SUM(amount + year)
        FOR YEAR IN (2020, 2021)
            MONTH IN ('JAN', 'FEB', 'MAR', 'APR')
    ) AS p
  ORDER BY EMPID;;