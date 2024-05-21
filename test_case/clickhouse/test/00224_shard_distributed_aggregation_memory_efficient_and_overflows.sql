DROP TABLE IF EXISTS numbers_100k_log;
CREATE TABLE numbers_100k_log ENGINE = Log AS SELECT * FROM system.numbers LIMIT 100000;
SET distributed_aggregation_memory_efficient = 1,
    group_by_two_level_threshold = 1000,
    group_by_overflow_mode = 'any',
    max_rows_to_group_by = 1000,
    totals_mode = 'after_having_auto';
DROP TABLE numbers_100k_log;
