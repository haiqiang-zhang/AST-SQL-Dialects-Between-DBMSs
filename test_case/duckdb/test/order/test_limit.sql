PRAGMA enable_verification;
CREATE TABLE test (a INTEGER, b INTEGER);;
INSERT INTO test VALUES (11, 22), (12, 21), (13, 22);
SELECT a FROM test LIMIT a;
SELECT a FROM test LIMIT a+1;
SELECT a FROM test LIMIT SUM(42);
SELECT a FROM test LIMIT row_number() OVER ();
CREATE TABLE test2 (a STRING);;
INSERT INTO test2 VALUES ('Hello World');
PREPARE v1 AS SELECT * FROM test2 LIMIT 3;
select 1 limit date '1992-01-01';;
CREATE TABLE integers(i INTEGER);;
INSERT INTO integers VALUES (1), (2), (3), (4), (5);;
CREATE SEQUENCE seq START 3;;
PRAGMA disable_verification;;
SELECT * FROM integers LIMIT RANDOM();;
CREATE SEQUENCE of_seq START 1;;
SELECT * FROM integers OFFSET RANDOM();;
SELECT * FROM integers as int LIMIT (SELECT -1);;
SELECT * FROM integers as int LIMIT (SELECT 'ab');;
CREATE OR REPLACE TABLE t AS SELECT range x FROM range(10);;
PRAGMA enable_verification;;
SELECT * FROM t ORDER BY x LIMIT (SELECT -1);;
SELECT * FROM t ORDER BY x OFFSET (SELECT -1);;
create table t0(c0 int);;
insert into t0 values (1), (2), (3), (4), (5), (6), (7);;
SELECT a FROM test LIMIT 1;
SELECT a FROM test LIMIT 1.25;
SELECT a FROM test LIMIT 2-1;
EXECUTE v1;
SELECT * FROM integers LIMIT nextval('seq');;
SELECT * FROM integers LIMIT nextval('seq');;
SELECT * FROM integers as int LIMIT (SELECT MIN(integers.i) FROM integers);;
SELECT * FROM integers OFFSET nextval('of_seq');;
SELECT * FROM integers OFFSET nextval('of_seq');;
SELECT * FROM integers as int OFFSET (SELECT MIN(integers.i) FROM integers);;
SELECT * FROM integers as int LIMIT (SELECT MAX(integers.i) FROM integers) OFFSET (SELECT MIN(integers.i) FROM integers);;
SELECT * FROM integers as int LIMIT (SELECT max(integers.i) FROM integers where i > 5);
SELECT * FROM integers as int LIMIT (SELECT max(integers.i) FROM integers where i > 5);
SELECT * FROM integers as int LIMIT (SELECT NULL);
SELECT * FROM t ORDER BY x;;
SELECT * FROM t ORDER BY x OFFSET 5;;
SELECT * FROM t ORDER BY x OFFSET (SELECT 5);;
SELECT * FROM t ORDER BY x LIMIT (SELECT 5);;
SELECT * FROM t ORDER BY x LIMIT (SELECT 3) OFFSET (SELECT 3);;
SELECT * FROM t ORDER BY x LIMIT 3 OFFSET (SELECT 3);;
SELECT * FROM t ORDER BY x LIMIT (SELECT 3) OFFSET 3;;
SELECT * FROM t0 ORDER BY ALL OFFSET (SELECT DISTINCT 6.5 FROM (SELECT 1) t1(c0) UNION ALL SELECT 3);;
