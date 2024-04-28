PRAGMA enable_verification;
CREATE TABLE exprtest (a INTEGER, b INTEGER);
INSERT INTO exprtest VALUES (42, 10), (43, 100), (NULL, 1), (45, -1);
CREATE TABLE intest (a INTEGER, b INTEGER, c INTEGER);
INSERT INTO intest VALUES (42, 42, 42), (43, 42, 42), (44, 41, 44);;
CREATE TABLE strtest (a INTEGER, b VARCHAR);
INSERT INTO strtest VALUES (1, 'a'), (2, 'h'), (3, 'd');
INSERT INTO strtest VALUES (4, NULL);
SELECT * FROM exprtest;
SELECT a FROM exprtest WHERE a BETWEEN 43 AND 44;
SELECT a FROM exprtest WHERE a NOT BETWEEN 43 AND 44;
SELECT a FROM exprtest WHERE a BETWEEN b AND 44;
SELECT CASE a WHEN 42 THEN 100 WHEN 43 THEN 200 ELSE 300 END FROM exprtest;
SELECT CASE WHEN a = 42 THEN 100 WHEN a = 43 THEN 200 ELSE 300 END FROM exprtest;
SELECT CASE WHEN a = 42 THEN 100 WHEN a = 43 THEN 200 END FROM exprtest;
SELECT ABS(1), ABS(-1), ABS(NULL);
SELECT ABS(b) FROM exprtest;
SELECT * FROM intest WHERE a IN (42, 43);
SELECT a IN (42, 43) FROM intest;
SELECT * FROM intest WHERE a IN (86, 103, 162);
SELECT * FROM intest WHERE a IN (NULL, NULL, NULL, NULL);
SELECT * FROM intest WHERE a IN (b);
SELECT * FROM intest WHERE a IN (b, c);
SELECT * FROM intest WHERE a IN (43, b) ORDER BY 1;
SELECT * FROM intest WHERE a NOT IN (42, 43);
SELECT * FROM intest WHERE a NOT IN (86, 103, 162) ORDER BY 1;
SELECT * FROM intest WHERE a NOT IN (NULL, NULL);
SELECT * FROM intest WHERE a NOT IN (b) ORDER BY 1;
SELECT * FROM intest WHERE a NOT IN (b, c);
SELECT * FROM intest WHERE a NOT IN (43, b);
SELECT * FROM intest WHERE NULL IN ('a', 'b');
SELECT * FROM intest WHERE NULL NOT IN ('a', 'b');
SELECT a FROM strtest WHERE b = 'a';
SELECT a FROM strtest WHERE b <> 'a';
SELECT a FROM strtest WHERE b < 'h';
SELECT a FROM strtest WHERE b <= 'h';
SELECT a FROM strtest WHERE b > 'h';
SELECT a FROM strtest WHERE b >= 'h';