PRAGMA enable_verification;
ATTACH DATABASE ':memory:' AS db1;;
CREATE TABLE db1.test(a INTEGER, b INTEGER, c VARCHAR(10));;
INSERT INTO db1.test VALUES (42, 88, 'hello');;
COPY FROM DATABASE db1 TO memory;
COPY FROM DATABASE dbxx TO memory;
COPY FROM DATABASE db1 TO dbxx;
SELECT * FROM memory.test;;
