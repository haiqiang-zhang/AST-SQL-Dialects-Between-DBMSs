DROP TABLE IF EXISTS limit_by;
CREATE TABLE limit_by (Num UInt32, Name String) ENGINE = Memory;
INSERT INTO limit_by (Num, Name) VALUES (1, 'John');
INSERT INTO limit_by (Num, Name) VALUES (1, 'John');
INSERT INTO limit_by (Num, Name) VALUES (3, 'Mary');
INSERT INTO limit_by (Num, Name) VALUES (3, 'Mary');
INSERT INTO limit_by (Num, Name) VALUES (3, 'Mary');
INSERT INTO limit_by (Num, Name) VALUES (4, 'Mary');
INSERT INTO limit_by (Num, Name) VALUES (4, 'Mary');
INSERT INTO limit_by (Num, Name) VALUES (5, 'Bill');
INSERT INTO limit_by (Num, Name) VALUES (7, 'Bill');
INSERT INTO limit_by (Num, Name) VALUES (7, 'Bill');
INSERT INTO limit_by (Num, Name) VALUES (7, 'Mary');
INSERT INTO limit_by (Num, Name) VALUES (7, 'John');
SELECT Num FROM limit_by ORDER BY Num LIMIT 2 BY Num;
SELECT Num, count(*) FROM limit_by GROUP BY Num ORDER BY Num LIMIT 2 BY Num;
SELECT Num, Name FROM limit_by ORDER BY Num LIMIT 1 BY Num, Name LIMIT 3;
DROP TABLE IF EXISTS limit_by;
