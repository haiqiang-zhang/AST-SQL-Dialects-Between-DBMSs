SYSTEM STOP MERGES t_merge_tree_index;
INSERT INTO t_merge_tree_index SELECT number % 5, number, 'v' || toString(number * number) FROM numbers(10);
INSERT INTO t_merge_tree_index SELECT number % 5, number, 'v' || toString(number * number) FROM numbers(10, 10);
SELECT * FROM t_merge_tree_index ORDER BY _part, a, b;
DROP TABLE t_merge_tree_index;
CREATE TABLE t_merge_tree_index (a UInt64 CODEC(LZ4), b UInt64 CODEC(LZ4), s String CODEC(LZ4))
ENGINE = MergeTree ORDER BY (a, b)
SETTINGS
    index_granularity = 3,
    min_bytes_for_wide_part = '1G',
    ratio_of_defaults_for_sparse_serialization = 1.0;
SYSTEM STOP MERGES t_merge_tree_index;
INSERT INTO t_merge_tree_index SELECT number % 4, number, 'v' || toString(number * number) FROM numbers(10);
INSERT INTO t_merge_tree_index SELECT number % 4, number, 'v' || toString(number * number) FROM numbers(10, 10);
SELECT * FROM t_merge_tree_index ORDER BY _part, a, b;
DROP TABLE t_merge_tree_index;
