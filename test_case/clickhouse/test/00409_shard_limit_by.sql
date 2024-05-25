SELECT Num FROM limit_by ORDER BY Num LIMIT 2 BY Num;
SELECT Num, count(*) FROM limit_by GROUP BY Num ORDER BY Num LIMIT 2 BY Num;
SELECT Num, Name FROM limit_by ORDER BY Num LIMIT 1 BY Num, Name LIMIT 3;
DROP TABLE IF EXISTS limit_by;
