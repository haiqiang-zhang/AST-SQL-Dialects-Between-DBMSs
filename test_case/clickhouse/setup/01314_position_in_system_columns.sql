DROP TABLE IF EXISTS test;
CREATE TABLE test (x UInt8, y String, z Array(String)) ENGINE = MergeTree ORDER BY tuple();
INSERT INTO test (x) VALUES (1);
