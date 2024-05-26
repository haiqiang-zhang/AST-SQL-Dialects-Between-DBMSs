SET optimize_on_insert = 0;
DROP TABLE IF EXISTS replacing_table;
CREATE TABLE replacing_table (a UInt32, b UInt32, c UInt32)
ENGINE = ReplacingMergeTree ORDER BY a
SETTINGS vertical_merge_algorithm_min_rows_to_activate = 1,
    vertical_merge_algorithm_min_columns_to_activate = 1,
    index_granularity = 16,
    min_bytes_for_wide_part = 0,
    merge_max_block_size = 16;
