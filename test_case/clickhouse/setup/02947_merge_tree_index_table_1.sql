DROP TABLE IF EXISTS t_merge_tree_index;
CREATE TABLE t_merge_tree_index (a UInt64 CODEC(LZ4), b UInt64 CODEC(LZ4), s String CODEC(LZ4))
ENGINE = MergeTree ORDER BY (a, b)
SETTINGS
    index_granularity = 3,
    min_bytes_for_wide_part = 0,
    ratio_of_defaults_for_sparse_serialization = 1.0;
