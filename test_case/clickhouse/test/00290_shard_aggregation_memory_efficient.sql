SET max_block_size = 1000;
CREATE TABLE numbers_10_00290 ENGINE = Log AS SELECT * FROM system.numbers LIMIT 10000;
SET distributed_aggregation_memory_efficient = 1, group_by_two_level_threshold = 5000;
DROP TABLE numbers_10_00290;
