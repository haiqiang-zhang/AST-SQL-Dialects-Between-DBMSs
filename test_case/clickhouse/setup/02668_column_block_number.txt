DROP TABLE IF EXISTS test;
CREATE TABLE test (id UInt32, a UInt32) ENGINE = MergeTree ORDER BY id SETTINGS allow_experimental_block_number_column = true;
INSERT INTO test(id,a) VALUES (1,1),(2,2),(3,3);
INSERT INTO test(id,a) VALUES (4,4),(5,5),(6,6);
