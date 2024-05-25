SET timeout_overflow_mode='break';
SET max_execution_time=0.1;
SELECT * FROM t WHERE value IN (SELECT number FROM numbers(1000000000));
DROP TABLE t;
