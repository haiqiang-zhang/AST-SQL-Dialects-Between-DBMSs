SELECT count() FROM (SELECT 2000 AS d_year UNION DISTINCT SELECT 2000 AS d_year) WHERE d_year = 2002;
