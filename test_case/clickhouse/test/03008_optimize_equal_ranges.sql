SELECT a, uniqExact(b) FROM t_optimize_equal_ranges GROUP BY a ORDER BY a SETTINGS max_threads = 16;
SELECT a, sum(c) FROM t_optimize_equal_ranges GROUP BY a ORDER BY a SETTINGS max_threads = 16;
SYSTEM FLUSH LOGS;
DROP TABLE t_optimize_equal_ranges;
