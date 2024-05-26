SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS test_table_join_1;
CREATE TABLE test_table_join_1
(
    id UInt64,
    value UInt64
) ENGINE=SummingMergeTree(value)
ORDER BY id
SAMPLE BY id;
