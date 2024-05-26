SET compile_expressions = 1;
SET min_count_to_compile_expression = 0;
SET short_circuit_function_evaluation='enable';
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table (message String) ENGINE=TinyLog;
INSERT INTO test_table VALUES ('Test');
