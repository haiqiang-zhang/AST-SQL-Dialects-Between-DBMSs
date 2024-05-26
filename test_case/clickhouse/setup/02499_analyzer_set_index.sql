SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
    id UInt64,
    value String,
    INDEX value_idx (value) TYPE set(1000) GRANULARITY 1
) ENGINE=MergeTree ORDER BY id;
INSERT INTO test_table SELECT number, toString(number) FROM numbers(10);
