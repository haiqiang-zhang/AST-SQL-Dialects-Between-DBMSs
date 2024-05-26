SELECT x, any(x) FROM dest_view GROUP BY x ORDER BY x;
DROP TABLE dest_view;
DROP TABLE source_table;
