PIVOT Cities ON Country || '_' || Name USING SUM(Population) GROUP BY Year;
PIVOT Cities ON (CASE WHEN Country='NL' THEN NULL ELSE Country END) USING SUM(Population) GROUP BY Year;
