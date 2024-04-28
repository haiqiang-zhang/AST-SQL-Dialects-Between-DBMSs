PRAGMA enable_verification;
CREATE TABLE Product(DaysToManufacture int, StandardCost int GENERATED ALWAYS AS (DaysToManufacture * 5));;
INSERT INTO Product VALUES (0), (1), (2), (4);;
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
) AS PivotTable;;