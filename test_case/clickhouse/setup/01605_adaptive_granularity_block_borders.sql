DROP TABLE IF EXISTS adaptive_table;
CREATE TABLE adaptive_table(
    key UInt64,
    value String
) ENGINE MergeTree()
ORDER BY key
SETTINGS index_granularity_bytes=1048576,
min_bytes_for_wide_part = 0,
min_rows_for_wide_part = 0,
enable_vertical_merge_algorithm = 0;
SET max_block_size=900;
