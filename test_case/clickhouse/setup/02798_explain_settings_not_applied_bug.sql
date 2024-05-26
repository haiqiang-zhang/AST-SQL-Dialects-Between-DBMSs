SET read_in_order_two_level_merge_threshold=1000000;
DROP TABLE IF EXISTS t;
CREATE TABLE t(a UInt64)
ENGINE = MergeTree
ORDER BY a;
INSERT INTO t SELECT * FROM numbers_mt(1e3);
