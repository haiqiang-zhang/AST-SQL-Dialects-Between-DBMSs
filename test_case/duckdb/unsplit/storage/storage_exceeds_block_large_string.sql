SET force_compression='uncompressed';
CREATE TABLE test (a VARCHAR, j BIGINT);
INSERT INTO test VALUES (repeat('a', 64), 1);
SELECT LENGTH(a) FROM test;
SELECT LENGTH(a) FROM test;
SELECT LENGTH(a) FROM test;
SELECT LENGTH(a) FROM test;
