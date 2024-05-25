SET send_logs_level='error';
CREATE TABLE buffer_table1__fuzz_28 (`x` Nullable(UInt32)) ENGINE = Buffer(currentDatabase(), 'merge_tree_table1', 16, 10, 60, 10, 1000, 1048576, 2097152);
SELECT * FROM buffer_table1__fuzz_28 PREWHERE x = toLowCardinality(1);
SELECT * FROM buffer_table1__fuzz_28;
