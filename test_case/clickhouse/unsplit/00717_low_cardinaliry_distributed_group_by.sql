set distributed_foreground_insert = 1;
set allow_suspicious_low_cardinality_types = 1;
DROP TABLE IF EXISTS test_low_null_float;
DROP TABLE IF EXISTS dist_00717;
CREATE TABLE test_low_null_float (a LowCardinality(Nullable(Float64))) ENGINE = Memory;
DROP TABLE IF EXISTS test_low_null_float;
DROP TABLE IF EXISTS dist_00717;
