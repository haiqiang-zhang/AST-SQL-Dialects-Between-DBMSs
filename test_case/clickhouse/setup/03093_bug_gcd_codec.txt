CREATE TABLE test_gcd(test_col UInt32 CODEC(GCD, LZ4))
ENGINE = MergeTree
ORDER BY tuple()
SETTINGS index_granularity = 8192, index_granularity_bytes = 1024;
INSERT INTO test_gcd SELECT floor(randUniform(1, 3)) FROM numbers(150000);
