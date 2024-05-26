DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
    k UInt64,
)
ENGINE = MergeTree
ORDER BY k;
INSERT INTO test_table SELECT number FROM numbers(10000000);
SET allow_experimental_analyzer = 1;
