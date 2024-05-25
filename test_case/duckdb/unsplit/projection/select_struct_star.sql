PRAGMA enable_verification;
CREATE TABLE test(a STRUCT(i INT, j INT));
CREATE TABLE a(i row(t int));
CREATE TABLE b(i row(t int));
INSERT INTO test VALUES ({i: 1, j: 2});
SELECT a.* FROM test;
SELECT a.* EXCLUDE(j) FROM test;
SELECT a.* EXCLUDE(i) FROM test;
SELECT a.* REPLACE(a.i + 3 AS i) FROM test;