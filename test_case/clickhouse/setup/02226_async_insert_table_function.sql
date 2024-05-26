DROP TABLE IF EXISTS t_async_insert_table_function;
CREATE TABLE t_async_insert_table_function (id UInt32, s String) ENGINE = Memory;
SET async_insert = 1;
