SELECT a, min(b), max(b) FROM data_02295 GROUP BY a ORDER BY a, count() SETTINGS optimize_aggregation_in_order = 1;
drop table data_02295;
