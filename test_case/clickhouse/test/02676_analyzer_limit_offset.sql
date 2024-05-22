set allow_experimental_analyzer=1;
DROP TABLE IF EXISTS test;
CREATE TABLE test (i UInt64) Engine = MergeTree() order by i;
INSERT INTO test SELECT number FROM numbers(100);
INSERT INTO test SELECT number FROM numbers(10,100);
OPTIMIZE TABLE test FINAL;
SET limit = 5;
SELECT * FROM test;
SELECT * FROM test OFFSET 20;
SELECT * FROM (SELECT i FROM test LIMIT 10 OFFSET 50) TMP;
SELECT * FROM test LIMIT 4 OFFSET 192;
SELECT * FROM test LIMIT 10 OFFSET 195;
-- Only set offset
SET limit = 0;
SET offset = 195;
SELECT * FROM test;
SELECT * FROM test OFFSET 20;
SELECT * FROM test LIMIT 100;
SET offset = 10;
SELECT * FROM test LIMIT 20 OFFSET 100;
SELECT * FROM test LIMIT 11 OFFSET 100;
-- offset and limit together
SET limit = 10;
SELECT * FROM test LIMIT 50 OFFSET 50;
SELECT * FROM test LIMIT 50 OFFSET 190;
SELECT * FROM test LIMIT 50 OFFSET 185;
SELECT * FROM test LIMIT 18 OFFSET 5;
DROP TABLE test;
