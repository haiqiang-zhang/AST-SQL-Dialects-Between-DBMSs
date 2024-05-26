SET compile_expressions = 1;
SET min_count_to_compile_expression = 0;
DROP TABLE IF EXISTS test_table_1;
DROP TABLE IF EXISTS test_table_2;
CREATE TABLE test_table_1 (id UInt32) ENGINE = MergeTree ORDER BY (id);
create table test_table_2 (id UInt32) ENGINE = MergeTree ORDER BY (id);
INSERT INTO test_table_1 VALUES (2);
INSERT INTO test_table_2 VALUES (2);
