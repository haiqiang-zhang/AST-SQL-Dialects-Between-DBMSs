DROP TABLE IF EXISTS test;
CREATE TABLE test (i UInt64) Engine = MergeTree() order by i;
INSERT INTO test SELECT number FROM numbers(100);
INSERT INTO test SELECT number FROM numbers(10,100);
