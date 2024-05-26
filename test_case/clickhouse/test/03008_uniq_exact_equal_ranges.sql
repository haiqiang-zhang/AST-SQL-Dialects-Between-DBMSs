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
