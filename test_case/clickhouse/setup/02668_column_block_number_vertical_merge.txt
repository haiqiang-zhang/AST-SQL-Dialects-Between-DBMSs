DROP TABLE IF EXISTS test;
CREATE TABLE test (id UInt32, a UInt32) ENGINE = MergeTree ORDER BY id SETTINGS allow_experimental_block_number_column = true,
    vertical_merge_algorithm_min_rows_to_activate = 1,
    vertical_merge_algorithm_min_columns_to_activate = 0,
    min_rows_for_wide_part = 1,
    min_bytes_for_wide_part = 1;
INSERT INTO test(id,a) VALUES (1,1),(2,2),(3,3);
INSERT INTO test(id,a) VALUES (4,4),(5,5),(6,6);
