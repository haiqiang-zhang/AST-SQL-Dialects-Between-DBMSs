SELECT number, count() FROM (SELECT * FROM system.numbers LIMIT 100000) GROUP BY number WITH TOTALS HAVING number % 3 = 0 ORDER BY number LIMIT 1;
SET totals_mode = 'after_having_inclusive';
SET totals_mode = 'after_having_exclusive';
SET totals_mode = 'after_having_auto';
SET totals_auto_threshold = 0.5;
