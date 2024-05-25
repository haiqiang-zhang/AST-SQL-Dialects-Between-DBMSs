SET max_block_size = 10;
SET max_rows_to_read = 20;
SET read_overflow_mode = 'throw';
SELECT number FROM numbers(30) LIMIT 1;
SELECT number FROM numbers(5);
SELECT a FROM t_max_rows_to_read LIMIT 1;
DROP TABLE t_max_rows_to_read;
