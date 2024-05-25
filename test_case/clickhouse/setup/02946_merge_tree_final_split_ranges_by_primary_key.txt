DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
    id UInt64,
    value String
) ENGINE=ReplacingMergeTree ORDER BY id SETTINGS index_granularity = 2;
INSERT INTO test_table SELECT 0, '0';
INSERT INTO test_table SELECT number + 1, number + 1 FROM numbers(15);
