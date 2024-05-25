DROP TABLE IF EXISTS t_uniq_exact;
CREATE TABLE t_uniq_exact (a UInt64, b String, c UInt64) ENGINE = MergeTree ORDER BY a;
SET group_by_two_level_threshold_bytes = 1;
SET group_by_two_level_threshold = 1;
SET max_threads = 4;
SET max_bytes_before_external_group_by = 0;
SET optimize_aggregation_in_order = 0;
OPTIMIZE TABLE t_uniq_exact FINAL;
SELECT a, uniqExact(b) FROM t_uniq_exact GROUP BY a ORDER BY a
SETTINGS min_hit_rate_to_use_consecutive_keys_optimization = 1.0
EXCEPT
SELECT a, uniqExact(b) FROM t_uniq_exact GROUP BY a ORDER BY a
SETTINGS min_hit_rate_to_use_consecutive_keys_optimization = 0.5;
SELECT a, sum(c) FROM t_uniq_exact GROUP BY a ORDER BY a
SETTINGS min_hit_rate_to_use_consecutive_keys_optimization = 1.0
EXCEPT
SELECT a, sum(c) FROM t_uniq_exact GROUP BY a ORDER BY a
SETTINGS min_hit_rate_to_use_consecutive_keys_optimization = 0.5;
DROP TABLE t_uniq_exact;
