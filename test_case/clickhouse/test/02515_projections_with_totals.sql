SET group_by_overflow_mode = 'any', max_rows_to_group_by = 1000, totals_mode = 'after_having_auto';
SELECT x FROM t GROUP BY x WITH TOTALS;
SET optimize_aggregation_in_order=1;
SELECT x FROM t GROUP BY x WITH TOTALS;
DROP TABLE t;
