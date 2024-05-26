SELECT DaysToManufacture, AVG(StandardCost) AS AverageCost
FROM Product
GROUP BY DaysToManufacture;
SELECT 'AverageCost' AS Cost_Sorted_By_Production_Days,
  "0", "1", "2", "3", "4"
FROM
(
  SELECT DaysToManufacture, StandardCost
  FROM Product
) AS SourceTable
PIVOT
(
  AVG(StandardCost)
  FOR DaysToManufacture IN (0, 1, 2, 3, 4)
) AS PivotTable;
SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount) FOR MONTH IN ('JAN', 'FEB', 'MAR', 'APR'))
      AS p
  ORDER BY EMPID;
SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount+1) FOR MONTH IN ('JAN', 'FEB', 'MAR', 'DEC'))
      AS p
  ORDER BY EMPID;
SELECT *
  FROM monthly_sales
    PIVOT(COUNT(*) FOR MONTH IN ('JAN', 'FEB', 'MAR', 'DEC') GROUP BY empid)
      AS p
  ORDER BY EMPID;
SELECT empid, January, February, March, April
  FROM monthly_sales
    PIVOT(SUM(amount) FOR MONTH IN ('JAN' AS January, 'FEB' AS February, 'MAR' AS March, 'APR' AS April))
      AS p
  ORDER BY EMPID;
SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount) FOR MONTH IN ('JAN', 'FEB', 'MAR'))
      AS p
  ORDER BY EMPID;
SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount) FOR MONTH IN ('JAN', 'FEB', 'MAR', 'DEC'))
      AS p
  ORDER BY EMPID;
SELECT *
FROM monthly_sales
PIVOT(SUM(amount) FOR MONTH IN ('JAN', 'FEB', 'MAR', 'APR'))
  AS p (EMP_ID_renamed, JAN, FEB, MAR, APR)
ORDER BY EMP_ID_renamed;
SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount) FOR MONTH IN (NULL, 'JAN', 'FEB', 'MAR', 'APR'))
      AS p
  ORDER BY EMPID;
SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount) FOR MONTH IN (NULL, 'JAN', 'FEB', 'MAR', 'APR'))
      AS p
    UNPIVOT INCLUDE NULLS(amount FOR MONTH IN ("NULL", JAN, FEB, MAR, APR))
  ORDER BY ALL;
SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount) FOR MONTH IN (NULL, 'JAN', 'FEB', 'MAR', 'APR'))
      AS p
    UNPIVOT EXCLUDE NULLS(amount FOR MONTH IN ("NULL", JAN, FEB, MAR, APR))
  ORDER BY ALL;
SELECT *
  FROM monthly_sales
    PIVOT(SUM(amount) FOR MONTH IN (NULL, 'JAN', 'FEB', 'MAR', 'APR'))
      AS p
    UNPIVOT EXCLUDE NULLS(amount FOR MONTH IN ("NULL", JAN, FEB, MAR, APR))
  ORDER BY EMPID;
FROM
(
  SELECT DaysToManufacture, StandardCost
  FROM Product
) AS SourceTable
PIVOT
(
  AVG(StandardCost)
  FOR DaysToManufacture IN ('zz')
) AS PivotTable;
