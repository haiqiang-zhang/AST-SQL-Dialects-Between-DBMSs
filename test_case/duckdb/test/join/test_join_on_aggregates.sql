PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER);
INSERT INTO integers VALUES (1), (2), (3), (NULL);
CREATE TABLE groups(i INTEGER, j INTEGER);
INSERT INTO groups VALUES (1, 1), (2, 1), (3, 2), (NULL, 2);
SELECT * FROM (SELECT SUM(i) AS x FROM integers) a, (SELECT SUM(i) AS x FROM integers) b WHERE a.x=b.x;;
SELECT a.j,a.x,a.y,b.y FROM (SELECT j, MIN(i) AS y, SUM(i) AS x FROM groups GROUP BY j) a, (SELECT j, MIN(i) AS y, SUM(i) AS x FROM groups GROUP BY j) b WHERE a.j=b.j AND a.x=b.x ORDER BY a.j;;