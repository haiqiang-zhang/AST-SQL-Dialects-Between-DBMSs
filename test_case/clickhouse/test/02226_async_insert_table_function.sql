SET async_insert = 1;
SELECT * FROM t_async_insert_table_function ORDER BY id;
DROP TABLE t_async_insert_table_function;
