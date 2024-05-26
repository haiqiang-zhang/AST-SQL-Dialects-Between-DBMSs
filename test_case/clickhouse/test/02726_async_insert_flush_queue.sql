SELECT count() FROM t_async_inserts_flush;
SYSTEM FLUSH ASYNC INSERT QUEUE;
DROP TABLE t_async_inserts_flush;
