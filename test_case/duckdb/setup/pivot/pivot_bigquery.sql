PRAGMA enable_verification;
CREATE TABLE Produce AS
  SELECT 'Kale' as product, 51 as sales, 'Q1' as quarter, 2020 as year UNION ALL
  SELECT 'Kale', 23, 'Q2', 2020 UNION ALL
  SELECT 'Kale', 45, 'Q3', 2020 UNION ALL
  SELECT 'Kale', 3, 'Q4', 2020 UNION ALL
  SELECT 'Kale', 70, 'Q1', 2021 UNION ALL
  SELECT 'Kale', 85, 'Q2', 2021 UNION ALL
  SELECT 'Apple', 77, 'Q1', 2020 UNION ALL
  SELECT 'Apple', 0, 'Q2', 2020 UNION ALL
  SELECT 'Apple', 1, 'Q1', 2021;
CREATE OR REPLACE TABLE Produce AS
  SELECT 'Kale' as product, 51 as Q1, 23 as Q2, 45 as Q3, 3 as Q4 UNION ALL
  SELECT 'Apple', 77, 0, 25, 2;
