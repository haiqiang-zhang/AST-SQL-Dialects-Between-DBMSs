DROP TABLE IF EXISTS collapsing_table;
SET optimize_on_insert = 0;
CREATE TABLE collapsing_table
(
    key UInt64,
    value UInt64,
    Sign Int8
)
ENGINE = CollapsingMergeTree(Sign)
ORDER BY key
SETTINGS
    vertical_merge_algorithm_min_rows_to_activate=0,
    vertical_merge_algorithm_min_columns_to_activate=0,
    min_bytes_for_wide_part = 0;
INSERT INTO collapsing_table SELECT if(number == 8192, 8191, number), 1, if(number == 8192, +1, -1) FROM numbers(8193);
