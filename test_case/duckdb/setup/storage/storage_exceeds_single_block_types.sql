SET force_compression='uncompressed';
CREATE TABLE test (a INTEGER, b BIGINT);
INSERT INTO test VALUES (11, 22), (13, 22), (12, 21), (NULL, NULL);
INSERT INTO test FROM test;
