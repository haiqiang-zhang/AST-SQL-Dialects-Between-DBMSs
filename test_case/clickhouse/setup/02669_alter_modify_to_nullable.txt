DROP TABLE IF EXISTS t_modify_to_nullable;
CREATE TABLE t_modify_to_nullable (key UInt64, id UInt64, s String)
ENGINE = MergeTree ORDER BY id PARTITION BY key
SETTINGS min_bytes_for_wide_part = 0, ratio_of_defaults_for_sparse_serialization = 0.9;
INSERT INTO t_modify_to_nullable SELECT 1, number, 'foo' FROM numbers(10000);
INSERT INTO t_modify_to_nullable SELECT 2, number, if (number % 23 = 0, 'bar', '') FROM numbers(10000);
