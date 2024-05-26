DROP TABLE IF EXISTS t_merge_tree_index;
SET print_pretty_type_names = 0;
CREATE TABLE t_merge_tree_index
(
    `a` UInt64,
    `b` UInt64,
    `sp` UInt64,
    `arr` Array(LowCardinality(String)),
    `n` Nested(c1 String, c2 UInt64),
    `t` Tuple(c1 UInt64, c2 UInt64),
    `column.with.dots` UInt64
)
ENGINE = MergeTree
ORDER BY (a, b, sipHash64(sp) % 100)
SETTINGS
    index_granularity = 3,
    min_bytes_for_wide_part = 0,
    min_rows_for_wide_part = 6,
    ratio_of_defaults_for_sparse_serialization = 0.9;
