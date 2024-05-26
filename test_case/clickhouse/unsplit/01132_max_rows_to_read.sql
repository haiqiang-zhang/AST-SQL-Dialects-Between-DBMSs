SET max_block_size = 10;
SET max_rows_to_read = 20;
SET read_overflow_mode = 'throw';
SELECT count() FROM numbers(19);
SET read_overflow_mode = 'break';
SELECT * FROM numbers(30);
SET max_block_size = 11;
SET max_block_size = 9;
