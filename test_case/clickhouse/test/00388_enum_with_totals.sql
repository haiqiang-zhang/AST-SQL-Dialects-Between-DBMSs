SELECT e, count() FROM enum_totals GROUP BY e WITH TOTALS ORDER BY e;
DROP TABLE enum_totals;
