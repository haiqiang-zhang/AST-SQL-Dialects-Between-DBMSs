DROP TABLE IF EXISTS buffer_table1__fuzz_28;
DROP TABLE IF EXISTS merge_tree_table1;
CREATE TABLE merge_tree_table1 (`x` UInt32) ENGINE = MergeTree ORDER BY x;
INSERT INTO merge_tree_table1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
SET send_logs_level='error';
CREATE TABLE buffer_table1__fuzz_28 (`x` Nullable(UInt32)) ENGINE = Buffer(currentDatabase(), 'merge_tree_table1', 16, 10, 60, 10, 1000, 1048576, 2097152);
SELECT * FROM buffer_table1__fuzz_28 PREWHERE x = toLowCardinality(1);
SELECT * FROM buffer_table1__fuzz_28;
