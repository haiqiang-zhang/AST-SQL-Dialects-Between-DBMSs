SET max_rows_to_group_by = 100000;
SET group_by_overflow_mode = 'any';
SET group_by_two_level_threshold_bytes = 100000000;
SET group_by_two_level_threshold = 1000000;
SET totals_mode = 'after_having_auto';
SELECT dummy, count() GROUP BY dummy WITH TOTALS;
SET totals_mode = 'after_having_inclusive';
SET totals_mode = 'after_having_exclusive';
SET totals_mode = 'before_having';
