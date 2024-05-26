SET allow_experimental_analyzer=1;
DROP TEMPORARY TABLE IF EXISTS test;
CREATE TEMPORARY TABLE test (a Float32, id UInt64);
INSERT INTO test VALUES (10,10),(20,20);
