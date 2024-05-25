DROP TABLE IF EXISTS adaptive_table;
-- granularity will adjust the amount of marks correctly.
-- Data for test was empirically derived, it's quite hard to get good parameters.

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
OPTIMIZE TABLE adaptive_table FINAL;
SELECT marks FROM system.parts WHERE table = 'adaptive_table' and database=currentDatabase() and active;
SET enable_filesystem_cache = 0;
SET max_memory_usage='30M';
SET max_threads = 1;
SELECT max(length(value)) FROM adaptive_table;
DROP TABLE IF EXISTS adaptive_table;
