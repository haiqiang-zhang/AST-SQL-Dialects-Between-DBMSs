SET force_compression='uncompressed';
CREATE TABLE test (a VARCHAR);
INSERT INTO test VALUES ('a'), ('bb'), ('ccc'), ('dddd'), ('eeeee');
INSERT INTO test FROM test;
