SET force_compression='uncompressed';
CREATE TABLE test (a VARCHAR);;
INSERT INTO test VALUES ('a'), ('bb'), ('ccc'), ('dddd'), ('eeeee');
INSERT INTO test FROM test;
SELECT a, COUNT(*) FROM test GROUP BY a ORDER BY a;
SELECT a, COUNT(*) FROM test GROUP BY a ORDER BY a;
SELECT count(a) FROM test WHERE a='a';
UPDATE test SET a='aaa' WHERE a='a';
SELECT a, COUNT(*) FROM test GROUP BY a ORDER BY a;
