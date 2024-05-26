SELECT dummy, count() GROUP BY dummy WITH TOTALS;
SET totals_mode = 'after_having_inclusive';
SET totals_mode = 'after_having_exclusive';
SET totals_mode = 'before_having';
