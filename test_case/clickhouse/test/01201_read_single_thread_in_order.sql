SET min_insert_block_size_rows = 0, min_insert_block_size_bytes = 0, max_insert_threads = 1;
INSERT INTO t SELECT number FROM numbers(10000000);
SET max_threads = 1, max_block_size = 12345;
SELECT arrayDistinct(arrayPopFront(arrayDifference(groupArray(number)))) FROM t;
DROP TABLE t;
