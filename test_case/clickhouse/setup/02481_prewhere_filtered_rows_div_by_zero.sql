DROP TABLE IF EXISTS test_filter;
CREATE TABLE test_filter(a Int32, b Int32, c Int32) ENGINE = MergeTree() ORDER BY a SETTINGS index_granularity = 3, index_granularity_bytes = '10Mi';
INSERT INTO test_filter SELECT number, number+1, (number/2 + 1) % 2 FROM numbers(15);
