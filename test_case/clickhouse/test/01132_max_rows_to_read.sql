SET max_block_size = 10;
SET max_rows_to_read = 20;
SET read_overflow_mode = 'throw';
SELECT count() FROM numbers(19);
SELECT count() FROM numbers(20);
SELECT count() FROM numbers(21);
-- check early exception if the estimated number of rows is high
SELECT * FROM numbers(30);
SET read_overflow_mode = 'break';
SELECT count() FROM numbers(19);
SELECT count() FROM numbers(20);
SELECT count() FROM numbers(21);
SELECT count() FROM numbers(29);
SELECT count() FROM numbers(30);
SELECT count() FROM numbers(31);
SELECT * FROM numbers(30);
SET max_block_size = 11;
SELECT * FROM numbers(30);
SET max_block_size = 9;
SELECT * FROM numbers(30);
