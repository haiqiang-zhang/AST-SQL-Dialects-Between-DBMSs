SET max_threads = 1;
SET join_algorithm = 'auto';
SET max_rows_in_join = 1000;
SET optimize_aggregation_in_order = 1;
SET max_block_size = 1000;
DROP TABLE IF EXISTS join_on_disk;
