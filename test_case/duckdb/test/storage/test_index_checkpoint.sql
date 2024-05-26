CHECKPOINT;
SELECT total_blocks < 6291456 / get_block_size('index_checkpoint') * 1.2 FROM pragma_database_size();
