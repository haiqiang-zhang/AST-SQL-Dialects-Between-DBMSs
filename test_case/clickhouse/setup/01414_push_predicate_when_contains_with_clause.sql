DROP TABLE IF EXISTS numbers_indexed;
DROP TABLE IF EXISTS squares;
CREATE TABLE numbers_indexed Engine=MergeTree ORDER BY number PARTITION BY bitShiftRight(number,8) SETTINGS index_granularity=8 AS SELECT * FROM numbers(16384);
CREATE VIEW squares AS WITH number*2 AS square_number SELECT number, square_number FROM numbers_indexed;
SET max_rows_to_read=8, read_overflow_mode='throw';
