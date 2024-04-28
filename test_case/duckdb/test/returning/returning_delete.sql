CREATE TABLE table1 (a INTEGER DEFAULT -1, b INTEGER DEFAULT -2, c INTEGER DEFAULT -3);;
insert into table1(a) select * from range (0, 4000, 1) t1(a);;
DELETE FROM table1 WHERE a >= 13 AND a <= 15 RETURNING SUM(a);;
CREATE TABLE table2 (a2 INTEGER, b2 INTEGER, c2 INTEGER);;
CREATE TABLE table3 (a3 INTEGER, b3 INTEGER, c3 INTEGER);;
INSERT INTO table2 VALUES (1, 1, 1), (2, 2, 2), (3, 3, 3), (100, 100, 100), (200, 200, 200);;
INSERT INTO table3 VALUES (1, 4, 4), (2, 6, 7), (8, 8, 8);;
CREATE TABLE table4 (a4 INTEGER, b4 INTEGER, c4 INTEGER);;
CREATE TABLE table5 (a5 INTEGER, b5 INTEGER, c5 INTEGER);;
INSERT INTO table4 VALUES (1, 0, 2), (2, 0, 1), (3, 0, 0);;
INSERT INTO table5 VALUES (1, 0, 0), (2, 0, 0), (3, 0, 1), (4, 0, 1), (5, 0, 2), (6, 0, 2);;
DELETE FROM table1 WHERE a = 14 RETURNING a IN (SELECT a FROM table1);;
DROP TABLE table2;;
DROP TABLE table3;;
DROP TABLE table4;;
DROP TABLE table5;;
CREATE TABLE table2 (a VARCHAR DEFAULT 'hello world', b INT);;
INSERT INTO table2 VALUES ('duckdb', 1), ('postgres', 2), ('sqlite', 3), ('mysql', 4), ('mongo', 5);;
CREATE SEQUENCE seq;;
CREATE TABLE table3 (a INTEGER DEFAULT nextval('seq'), b INTEGER);;
INSERT INTO table3(b) VALUES (4), (5) RETURNING a, b;;
DROP TABLE table1;;
CREATE TABLE table1 (a INTEGER DEFAULT -1, b INTEGER DEFAULT -2, c INTEGER DEFAULT -3);;
insert into table1(a) select * from range (0, 4000, 1) t1(a);;
DELETE FROM table1
WHERE a < 5 RETURNING a, b, c;;
DELETE FROM table1
WHERE a = 6 RETURNING a;;
DELETE FROM table1
WHERE a = 7 RETURNING *;;
DELETE FROM table1
WHERE a=8 AND b=-2 AND c=-3 RETURNING *, c, b, a;;
DELETE FROM table1
WHERE a=9 RETURNING c, b, a;;
DELETE FROM table1
WHERE a>=10 AND a <=13  RETURNING c as aliasc, a as aliasa, b as aliasb;;
DELETE FROM table1
WHERE a=14
RETURNING a + b + c;;
DELETE FROM table1
WHERE a=10
RETURNING 'duckdb';;
DELETE FROM table1
WHERE a=15
RETURNING 'duckdb';;
DELETE FROM table3
WHERE a3 IN (
	SELECT a2 from table2
) RETURNING *;;
DELETE FROM table4
WHERE a4 IN (SELECT sum(a5) FROM table5 GROUP BY c5)
RETURNING *;;
DELETE FROM table4 WHERE a4 = 1 RETURNING CASE WHEN b4=0 THEN a4 ELSE b4 END;;
DELETE FROM table4 WHERE a4 = 2 RETURNING CASE WHEN b4=1 THEN a4 ELSE b4 END;;
DELETE FROM table2
WHERE b = 1
RETURNING a, b;;
DELETE FROM table2
WHERE b = 2
RETURNING b::VARCHAR;;
DELETE FROM table2
WHERE b=3
RETURNING {'a': a, 'b': b};;
DELETE FROM table2
WHERE b=4
RETURNING [a, b::VARCHAR];;
DELETE FROM table3
WHERE b = 4
RETURNING *;;
SELECT count(*) FROM table1;;
DELETE FROM table1 RETURNING a;;
