DROP TABLE IF EXISTS t_max_rows_to_read;
CREATE TABLE t_max_rows_to_read (a UInt64)
ENGINE = MergeTree ORDER BY a
SETTINGS index_granularity = 4, index_granularity_bytes = '10Mi';
INSERT INTO t_max_rows_to_read SELECT number FROM numbers(100);
SET max_block_size = 10;
SET max_rows_to_read = 20;
SET read_overflow_mode = 'throw';
