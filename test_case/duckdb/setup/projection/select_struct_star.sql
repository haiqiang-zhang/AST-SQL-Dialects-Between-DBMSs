PRAGMA enable_verification;
CREATE TABLE test(a STRUCT(i INT, j INT));
CREATE TABLE a(i row(t int));
CREATE TABLE b(i row(t int));
INSERT INTO test VALUES ({i: 1, j: 2});
