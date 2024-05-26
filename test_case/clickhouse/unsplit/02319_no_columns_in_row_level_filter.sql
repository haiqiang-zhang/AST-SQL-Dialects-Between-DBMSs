DROP ROW POLICY IF EXISTS test_filter_policy ON test_table;
DROP ROW POLICY IF EXISTS test_filter_policy_2 ON test_table;
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table (`n` UInt64, `s` String)
ENGINE = MergeTree
PRIMARY KEY n ORDER BY n SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
INSERT INTO test_table SELECT number, concat('some string ', CAST(number, 'String')) FROM numbers(1000000);
SELECT count(1) FROM test_table;
DROP TABLE test_table;
