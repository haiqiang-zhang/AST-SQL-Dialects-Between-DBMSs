PRAGMA enable_verification;
CREATE TABLE exprtest (a INTEGER, b INTEGER);
INSERT INTO exprtest VALUES (42, 10), (43, 100), (NULL, 1), (45, -1);
CREATE TABLE intest (a INTEGER, b INTEGER, c INTEGER);
INSERT INTO intest VALUES (42, 42, 42), (43, 42, 42), (44, 41, 44);
CREATE TABLE strtest (a INTEGER, b VARCHAR);
INSERT INTO strtest VALUES (1, 'a'), (2, 'h'), (3, 'd');
INSERT INTO strtest VALUES (4, NULL);