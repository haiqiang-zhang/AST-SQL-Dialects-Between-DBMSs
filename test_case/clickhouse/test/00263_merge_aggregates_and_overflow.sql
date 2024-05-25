SET max_block_size = 1000;
CREATE TABLE numbers_10k_log ENGINE = Log AS SELECT number FROM system.numbers LIMIT 10000;
SET max_threads = 4;
SET max_rows_to_group_by = 3000, group_by_overflow_mode = 'any';
DROP TABLE numbers_10k_log;
