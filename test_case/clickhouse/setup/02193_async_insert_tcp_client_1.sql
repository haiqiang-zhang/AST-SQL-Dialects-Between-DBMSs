SET log_queries = 1;
DROP TABLE IF EXISTS t_async_insert_02193_1;
CREATE TABLE t_async_insert_02193_1 (id UInt32, s String) ENGINE = Memory;
SET async_insert = 1;
INSERT INTO t_async_insert_02193_1 VALUES (3, 'ccc');
