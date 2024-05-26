DROP TABLE IF EXISTS t_async_inserts_flush;
CREATE TABLE t_async_inserts_flush (a UInt64) ENGINE = Memory;
SET async_insert = 1;
SET wait_for_async_insert = 0;
SET async_insert_busy_timeout_min_ms = 1000000;
SET async_insert_busy_timeout_max_ms = 10000000;
INSERT INTO t_async_inserts_flush VALUES (1) (2);
