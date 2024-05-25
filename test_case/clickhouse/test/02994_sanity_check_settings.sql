EXPLAIN PIPELINE SELECT zero + 1 AS x FROM system.zeros SETTINGS max_block_size = 9223372036854775806, max_rows_to_read = 20, read_overflow_mode = 'break';
