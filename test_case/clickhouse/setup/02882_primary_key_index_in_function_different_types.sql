DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
    id UInt64,
    value UInt64
) ENGINE=MergeTree ORDER BY (id, value) SETTINGS index_granularity = 8192, index_granularity_bytes = '1Mi';
INSERT INTO test_table SELECT number, number FROM numbers(10);
set allow_experimental_analyzer = 0;
