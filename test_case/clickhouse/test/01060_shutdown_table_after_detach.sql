DROP TABLE IF EXISTS test;
SELECT count() FROM test;
ALTER TABLE test DETACH PARTITION tuple();
SELECT count() FROM test;
DETACH TABLE test;
ATTACH TABLE test;
ALTER TABLE test ATTACH PARTITION tuple();
SELECT count() FROM test;
DROP TABLE test;