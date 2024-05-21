SET max_insert_threads = 1, max_threads = 100, min_insert_block_size_rows = 1048576, max_block_size = 65536;
DROP TABLE IF EXISTS t;
CREATE TABLE t (x UInt64) ENGINE = StripeLog;
INSERT INTO t SELECT * FROM numbers_mt(1000000);
SET max_threads = 1;
SELECT DISTINCT blockSize(), runningDifference(x) FROM t;
DROP TABLE t;