DROP TABLE IF EXISTS test_buffer_table;
CREATE TABLE test_buffer_table
(
    `a` Int64
)
ENGINE = Buffer('', '', 1, 1000000, 1000000, 1000000, 1000000, 1000000, 1000000);
