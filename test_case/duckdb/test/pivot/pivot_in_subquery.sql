PRAGMA enable_verification;
CREATE TABLE Cities(Country VARCHAR, Name VARCHAR, Year INT, Population INT);;
INSERT INTO Cities VALUES ('NL', 'Amsterdam', 2000, 1005);;
INSERT INTO Cities VALUES ('NL', 'Amsterdam', 2010, 1065);;
INSERT INTO Cities VALUES ('NL', 'Amsterdam', 2020, 1158);;
INSERT INTO Cities VALUES ('US', 'Seattle', 2000, 564);;
INSERT INTO Cities VALUES ('US', 'Seattle', 2010, 608);;
INSERT INTO Cities VALUES ('US', 'Seattle', 2020, 738);;
INSERT INTO Cities VALUES ('US', 'New York City', 2000, 8015);;
INSERT INTO Cities VALUES ('US', 'New York City', 2010, 8175);;
INSERT INTO Cities VALUES ('US', 'New York City', 2020, 8772);;
PIVOT Cities ON Year IN (SELECT xx FROM Cities) USING SUM(Population);;
PIVOT Cities ON Year IN (SELECT Year FROM Cities ORDER BY Year DESC) USING SUM(Population);;
PIVOT Cities ON Year IN (SELECT YEAR FROM (SELECT Year, SUM(POPULATION) AS popsum FROM Cities GROUP BY Year ORDER BY popsum DESC)) USING SUM(Population);;
PIVOT Cities ON Year IN (SELECT '2010' UNION ALL SELECT '2000' UNION ALL SELECT '2020') USING SUM(Population);;
