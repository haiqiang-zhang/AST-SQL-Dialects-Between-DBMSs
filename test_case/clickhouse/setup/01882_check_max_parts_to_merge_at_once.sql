DROP TABLE IF EXISTS limited_merge_table;
SET max_threads = 1;
SET max_block_size = 1;
SET min_insert_block_size_rows = 1;
CREATE TABLE limited_merge_table
(
    key UInt64
)
ENGINE = MergeTree()
ORDER BY key
SETTINGS max_parts_to_merge_at_once = 3;
