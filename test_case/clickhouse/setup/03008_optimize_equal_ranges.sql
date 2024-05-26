DROP TABLE IF EXISTS t_optimize_equal_ranges;
CREATE TABLE t_optimize_equal_ranges (a UInt64, b String, c UInt64) ENGINE = MergeTree ORDER BY a;
SET max_block_size = 1024;
SET max_bytes_before_external_group_by = 0;
SET optimize_aggregation_in_order = 0;
SET optimize_use_projections = 0;
INSERT INTO t_optimize_equal_ranges SELECT 0, toString(number), number FROM numbers(30000);
INSERT INTO t_optimize_equal_ranges SELECT 1, toString(number), number FROM numbers(30000);
INSERT INTO t_optimize_equal_ranges SELECT 2, toString(number), number FROM numbers(30000);
