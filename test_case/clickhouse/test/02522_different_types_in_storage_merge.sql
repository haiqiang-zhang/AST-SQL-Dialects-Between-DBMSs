CREATE TABLE test_s64_local (date Date, value Int64) ENGINE = MergeTree order by tuple();
CREATE TABLE test_u64_local (date Date, value UInt64) ENGINE = MergeTree order by tuple();
SELECT * FROM merge(currentDatabase(), '') WHERE value = 1048575;
