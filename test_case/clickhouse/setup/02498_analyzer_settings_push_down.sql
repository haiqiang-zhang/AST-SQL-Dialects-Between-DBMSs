SET allow_experimental_analyzer = 1;
SET optimize_functions_to_subcolumns = 0;
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table (id UInt64, value Tuple(a UInt64)) ENGINE=MergeTree ORDER BY id;
INSERT INTO test_table VALUES (0, tuple(0));
