SET force_compression='uncompressed';
CREATE TABLE test (a VARCHAR, j BIGINT);;
INSERT INTO test VALUES (repeat('a', 64), 1);
INSERT INTO test SELECT a||a||a||a||a||a||a||a||a||a, ${i} FROM test;
DELETE FROM test WHERE j=${i} - 1;
SELECT LENGTH(a) FROM test;
SELECT LENGTH(a) FROM test;
SELECT LENGTH(a) FROM test;
SELECT LENGTH(a) FROM test;
