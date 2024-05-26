drop table if exists test_table;
CREATE TABLE test_table
(
    col1 String,
    col2 String,
    INDEX test_table_col2_idx col2 TYPE set(0) GRANULARITY 1
) ENGINE = MergeTree()
      ORDER BY col1
AS SELECT 'v1', 'v2';
