SET max_threads=0;
SET optimize_read_in_order=1;
SET read_in_order_two_level_merge_threshold=100;
DROP TABLE IF EXISTS t_read_in_order;
CREATE TABLE t_read_in_order(date Date, i UInt64, v UInt64)
ENGINE = MergeTree ORDER BY (date, i) SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
INSERT INTO t_read_in_order SELECT '2020-10-10', number % 10, number FROM numbers(100000);
INSERT INTO t_read_in_order SELECT '2020-10-11', number % 10, number FROM numbers(100000);
