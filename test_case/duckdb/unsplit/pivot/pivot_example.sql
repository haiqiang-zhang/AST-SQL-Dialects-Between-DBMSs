PRAGMA enable_verification;
CREATE TABLE Cities(Country VARCHAR, Name VARCHAR, Year INT, Population INT);
INSERT INTO Cities VALUES ('NL', 'Amsterdam', 2000, 1005);
INSERT INTO Cities VALUES ('NL', 'Amsterdam', 2010, 1065);
INSERT INTO Cities VALUES ('NL', 'Amsterdam', 2020, 1158);
INSERT INTO Cities VALUES ('US', 'Seattle', 2000, 564);
INSERT INTO Cities VALUES ('US', 'Seattle', 2010, 608);
INSERT INTO Cities VALUES ('US', 'Seattle', 2020, 738);
INSERT INTO Cities VALUES ('US', 'New York City', 2000, 8015);
INSERT INTO Cities VALUES ('US', 'New York City', 2010, 8175);
INSERT INTO Cities VALUES ('US', 'New York City', 2020, 8772);
SET pivot_filter_threshold=99;
PIVOT Cities ON Country, Name IN ('xx') USING SUM(Population);
PIVOT Cities ON Year USING SUM(Population)
UNION ALL BY NAME
PIVOT Cities ON Name USING SUM(Population);
SET pivot_filter_threshold=0;
CREATE TABLE PivotedCities AS PIVOT Cities ON Year USING SUM(Population);
PIVOT Cities ON Year USING SUM(Population);
SELECT Country, Name, "2000_total_pop", "2010_total_pop", "2020_total_pop" FROM (PIVOT Cities ON Year USING SUM(Population) as total_pop);
PIVOT_WIDER Cities ON Year USING SUM(Population);
FROM Cities PIVOT (SUM(Population) FOR Year IN (2000, 2010, 2020));
PIVOT Cities ON Year IN (2000, 2020) USING SUM(Population);
PIVOT Cities ON Year USING SUM(Population) GROUP BY Country;
FROM
	(PIVOT Cities ON Year USING SUM(Population) GROUP BY Country)
JOIN
	(PIVOT Cities ON Name USING SUM(Population) GROUP BY Country)
USING (Country);
PIVOT Cities ON (Country, Name) IN ('xx') USING SUM(Population);
PIVOT (SELECT Country, Population, Year FROM Cities) ON Year USING SUM(Population) as sum_pop, count(population) as count_pop,;
PIVOT Cities ON Year USING SUM(Population) as sum_pop, count(population) as count_pop, GROUP BY Country;
PIVOT Cities ON Year USING SUM(Population), count(population) GROUP BY Country;
PIVOT Cities ON Year USING SUM(Population) GROUP BY country ORDER BY country desc;
PIVOT Cities ON Year USING SUM(Population) GROUP BY country ORDER BY country desc LIMIT 1;
PIVOT Cities ON Year USING SUM(Population) GROUP BY country ORDER BY country LIMIT 1;
PIVOT Cities ON Year USING SUM(Population) GROUP BY country ORDER BY country LIMIT 1 OFFSET 1;
PIVOT Cities ON Year USING SUM(Population) GROUP BY country ORDER BY ALL;
UNPIVOT PivotedCities ON 2000, 2010, 2020 INTO NAME Year VALUE Population;
FROM PivotedCities UNPIVOT(Population FOR Year IN (2000, 2010, 2020));
UNPIVOT PivotedCities ON 2000, 2010, 2020;
UNPIVOT PivotedCities ON COLUMNS('\d+');
UNPIVOT PivotedCities ON * EXCLUDE (Country, Name);
PIVOT_LONGER PivotedCities ON 2000, 2010, 2020;
UNPIVOT PivotedCities ON 2000, 2010, 2020 ORDER BY ALL LIMIT 1;
UNPIVOT PivotedCities ON 2000, 2010, 2020 ORDER BY 1 LIMIT 1 OFFSET 1;
