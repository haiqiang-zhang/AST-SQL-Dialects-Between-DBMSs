PRAGMA trusted_schema=OFF;
PRAGMA trusted_schema=ON;
PRAGMA trusted_schema=OFF;
PRAGMA trusted_schema=ON;
PRAGMA trusted_schema=Off;
PRAGMA trusted_schema=On;
PRAGMA trusted_schema=off;
PRAGMA trusted_schema=OFF;
CREATE TABLE t3(a,b DEFAULT(f2(25)));
PRAGMA trusted_schema=Off;
INSERT INTO t3(a,b) VALUES(1,2);
CREATE TEMP TABLE temp3(a, b DEFAULT(f3(31)));
SELECT * FROM temp3;
CREATE TABLE t4(a,b,c);
INSERT INTO t4 VALUES(1,2,3),('a','b','c'),(4,'d',0);
SELECT * FROM t4;
CREATE TEMP TABLE temp4(a,b,c);
INSERT INTO temp4 SELECT * FROM t4;
PRAGMA trusted_schema=OFF;
PRAGMA trusted_schema=ON;
PRAGMA trusted_schema=OFF;
CREATE TABLE t5(a,b,c);
INSERT INTO t5 VALUES(1,2,3),(4,5,6),(7,0,-3);
SELECT * FROM t5;
CREATE TEMP TABLE temp5(a,b,c);
INSERT INTO temp5 SELECT * FROM t5;
PRAGMA trusted_schema=OFF;
PRAGMA trusted_schema=ON;
PRAGMA trusted_schema=OFF;
CREATE TABLE t1(a,b,c);
INSERT INTO t1 VALUES(1,2,3),(100,50,75),(-11,22,-33);
CREATE VIEW v1a AS SELECT f3(a+b) FROM t1;
PRAGMA trusted_schema=ON;
PRAGMA trusted_schema=OFF;
DROP VIEW v1a;
CREATE TEMP VIEW v1a AS SELECT f3(a+b) FROM t1;
CREATE VIEW v1b AS SELECT f2(b+c) FROM t1;
PRAGMA trusted_schema=ON;
PRAGMA trusted_schema=OFF;
DROP VIEW v1b;
CREATE TEMP VIEW v1b AS SELECT f2(b+c) FROM t1;
DELETE FROM t1;
CREATE TABLE t2(x);
INSERT INTO t1 VALUES(7,6,5);
SELECT * FROM t1;
SELECT * FROM t2;
PRAGMA trusted_schema=ON;
INSERT INTO t1 VALUES(7,6,5);
SELECT * FROM t1, t2;
DELETE FROM t1;
DELETE FROM t2;
PRAGMA trusted_schema=OFF;
INSERT INTO t1 VALUES(7,6,5);
SELECT * FROM t1;
SELECT * FROM t2;
PRAGMA trusted_schema=OFF;
CREATE VIEW test41(x) AS SELECT json_extract('{"a":123}','$.a');
SELECT * FROM test41;
PRAGMA trusted_schema=ON;
SELECT * FROM test41;
