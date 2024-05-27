DROP TABLE IF EXISTS test_rlp;
CREATE TABLE test_rlp (a Int32, b Int32) ENGINE=MergeTree() ORDER BY a SETTINGS index_granularity=5, index_granularity_bytes = '10Mi';
INSERT INTO test_rlp SELECT number, number FROM numbers(15);
ALTER TABLE test_rlp ADD COLUMN c Int32 DEFAULT b+10;