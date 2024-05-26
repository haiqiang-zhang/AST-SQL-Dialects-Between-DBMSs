CREATE TABLE table1 (a INTEGER DEFAULT -1, b INTEGER DEFAULT -2, c INTEGER DEFAULT -3);
insert into table1(a) select * from range (0, 4000, 1) t1(a);
CREATE TABLE table2 (a2 INTEGER, b2 INTEGER, c2 INTEGER);
CREATE TABLE table3 (a3 INTEGER, b3 INTEGER, c3 INTEGER);
INSERT INTO table2 VALUES (1, 1, 1), (2, 2, 2), (3, 3, 3), (100, 100, 100), (200, 200, 200);
INSERT INTO table3 VALUES (1, 4, 4), (2, 6, 7), (8, 8, 8);
CREATE TABLE table4 (a4 INTEGER, b4 INTEGER, c4 INTEGER);
CREATE TABLE table5 (a5 INTEGER, b5 INTEGER, c5 INTEGER);
INSERT INTO table4 VALUES (1, 0, 2), (2, 0, 1), (3, 0, 0);
INSERT INTO table5 VALUES (1, 0, 0), (2, 0, 0), (3, 0, 1), (4, 0, 1), (5, 0, 2), (6, 0, 2);
DROP TABLE table2;
DROP TABLE table3;
DROP TABLE table4;
DROP TABLE table5;
CREATE TABLE table2 (a VARCHAR DEFAULT 'hello world', b INT);
INSERT INTO table2 VALUES ('duckdb', 1);
CREATE SEQUENCE seq;
CREATE TABLE table3 (a INTEGER DEFAULT nextval('seq'), b INTEGER);
INSERT INTO table3(b) VALUES (4), (5) RETURNING a, b;
CREATE TABLE table4 (a INTEGER, b INTEGER, c INTEGER);
CREATE INDEX b_index ON table4(b);
INSERT INTO table4 VALUES (1, 2, 3), (4, 5, 6), (7, 8, 9);
UPDATE table1
SET a=-10
WHERE a = 1 RETURNING a, b, c;
UPDATE table1
SET a=a*-2, b=b*2, c=c*2
WHERE a = 2 RETURNING a, b, c;
UPDATE table1
SET a=a*-2, b=b*2, c=c*2
WHERE a = 3 RETURNING a;
UPDATE table1
SET a=a*-2, b=b*2, c=c*2
WHERE a = 4 RETURNING *;
UPDATE table1
SET a=-5, b=2, c=1
WHERE a=5 AND b=-2 AND c=-3 RETURNING *, c, b, a;
UPDATE table1
SET c=1, b=2, a=3
WHERE a=6 AND b=-2 AND c=-3 RETURNING c, b, a;
UPDATE table1
SET c=1, b=2, a=3
WHERE a=7 AND b=-2 AND c=-3 RETURNING c as aliasc, a as aliasa, b as aliasb;
UPDATE table1
SET c=15
WHERE a=8 RETURNING *;
UPDATE table1
SET a=-9, b=b+7
WHERE a=9
RETURNING a + b + c;
UPDATE table1
SET a=-10
WHERE a=10
RETURNING 'duckdb';
UPDATE table2
SET a='hello world'
WHERE b = 1
RETURNING a, b;
UPDATE table2
SET b=100
WHERE b = 1
RETURNING b::VARCHAR;
UPDATE table2
SET a='Mr.Duck', b=99
WHERE b=100
RETURNING {'a': a, 'b': b};
UPDATE table2
SET b=98
WHERE b=99
RETURNING [a, b::VARCHAR];
UPDATE table3
SET b=b+1
RETURNING *;
UPDATE table4
SET b = 10
WHERE b = 2
RETURNING *;
