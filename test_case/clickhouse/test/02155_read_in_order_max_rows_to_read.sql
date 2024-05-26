SELECT a FROM t_max_rows_to_read WHERE a = 10 SETTINGS max_rows_to_read = 4;
SELECT a FROM t_max_rows_to_read ORDER BY a LIMIT 5 SETTINGS max_rows_to_read = 12;
SELECT a FROM t_max_rows_to_read WHERE a = 10 OR a = 20 SETTINGS max_rows_to_read = 12;
DROP TABLE t_max_rows_to_read;
