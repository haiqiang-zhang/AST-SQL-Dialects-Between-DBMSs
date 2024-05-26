SET compile_expressions = 1;
SET min_count_to_compile_expression = 0;
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table (a UInt8, b UInt8) ENGINE = TinyLog;
INSERT INTO test_table VALUES (0, 0), (0, 1), (1, 0), (1, 1);
