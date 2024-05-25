-- String field
SELECT Name FROM (SELECT DISTINCT Name FROM distinct) ORDER BY Name;
SELECT Num FROM (SELECT DISTINCT Num FROM distinct) ORDER BY Num;
SELECT DISTINCT 1 as a, 2 as b FROM distinct;
DROP TABLE IF EXISTS distinct;
