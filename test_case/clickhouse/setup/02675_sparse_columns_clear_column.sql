DROP TABLE IF EXISTS t_sparse_columns_clear;
CREATE TABLE t_sparse_columns_clear (arr Array(UInt64), v UInt64)
ENGINE = MergeTree ORDER BY tuple()
SETTINGS
    ratio_of_defaults_for_sparse_serialization = 0.9,
    min_bytes_for_wide_part=0;
INSERT INTO t_sparse_columns_clear SELECT [number], 0 FROM numbers(1000);
