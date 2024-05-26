DROP TABLE IF EXISTS t_subcolumns_sizes;
SET allow_experimental_object_type = 1;
CREATE TABLE t_subcolumns_sizes (id UInt64, arr Array(UInt64), n Nullable(String), d JSON)
ENGINE = MergeTree ORDER BY id
SETTINGS min_bytes_for_wide_part = 0;
