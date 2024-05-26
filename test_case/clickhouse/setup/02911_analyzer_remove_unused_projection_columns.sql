SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
    id UInt64,
    value String
) ENGINE = MergeTree ORDER BY id;
INSERT INTO test_table VALUES (0, 'Value_0');
SET max_columns_to_read = 1;
