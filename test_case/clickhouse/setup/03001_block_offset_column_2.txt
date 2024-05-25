DROP TABLE IF EXISTS t_block_offset;
CREATE TABLE t_block_offset (id UInt32) ENGINE = MergeTree ORDER BY id SETTINGS index_granularity = 3;
INSERT INTO t_block_offset SELECT number * 2 FROM numbers(8);
INSERT INTO t_block_offset SELECT number * 2 FROM numbers(8, 8);
