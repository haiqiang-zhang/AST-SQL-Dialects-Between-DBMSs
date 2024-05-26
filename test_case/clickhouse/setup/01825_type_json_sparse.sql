DROP TABLE IF EXISTS t_json_sparse;
SET allow_experimental_object_type = 1;
CREATE TABLE t_json_sparse (data JSON)
ENGINE = MergeTree ORDER BY tuple()
SETTINGS ratio_of_defaults_for_sparse_serialization = 0.1,
min_bytes_for_wide_part = 0, index_granularity = 8192, index_granularity_bytes = '10Mi';
