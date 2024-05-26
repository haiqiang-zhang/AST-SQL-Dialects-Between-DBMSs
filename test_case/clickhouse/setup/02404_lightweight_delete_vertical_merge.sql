DROP TABLE IF EXISTS lwd_test;
CREATE TABLE lwd_test
(
    `id` UInt64,
    `value` String
)
ENGINE = MergeTree
ORDER BY id
SETTINGS
    vertical_merge_algorithm_min_rows_to_activate = 1,
    vertical_merge_algorithm_min_columns_to_activate = 1,
    min_rows_for_wide_part = 1,
    min_bytes_for_wide_part = 1;
INSERT INTO lwd_test SELECT number AS id, toString(number) AS value FROM numbers(10);
