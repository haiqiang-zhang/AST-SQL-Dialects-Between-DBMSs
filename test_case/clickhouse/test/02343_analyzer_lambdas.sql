SELECT 'Standalone lambdas';
WITH x -> x + 1 AS lambda SELECT lambda(1);
WITH x -> toString(x) AS lambda_1, lambda_1 AS lambda_2, lambda_2 AS lambda_3 SELECT lambda_1(1), lambda_2(NULL), lambda_3([1,2,3]);
SELECT 'Lambda as function parameter';
SELECT arrayMap(x -> x + 1, [1,2,3]);
WITH x -> x + 1 AS lambda SELECT arrayMap(lambda, [1,2,3]);
SELECT 'Lambda compound argument';
DROP TABLE IF EXISTS test_table_tuple;
CREATE TABLE test_table_tuple
(
    id UInt64,
    value Tuple(value_0_level_0 String, value_1_level_0 String)
) ENGINE=TinyLog;
INSERT INTO test_table_tuple VALUES (0, ('value_0_level_0', 'value_1_level_0'));
SELECT 'Lambda matcher';
WITH cast(tuple(1), 'Tuple (value UInt64)') AS compound_value SELECT id, test_table.* APPLY x -> compound_value.* FROM test_table;
WITH cast(tuple(1, 1), 'Tuple (value_1 UInt64, value_2 UInt64)') AS compound_value SELECT id, test_table.* APPLY x -> plus(compound_value.*) FROM test_table;
SELECT 'Lambda untuple';
SELECT 'Lambda carrying';
SELECT 'Lambda legacy syntax';
SELECT arraySort(lambda((x, y), y), ['world', 'hello'], [2, 1]);
WITH x -> x + 1 AS lambda
SELECT arrayMap(lambda(tuple(x), x + 1), [1, 2, 3]), lambda(1);
WITH (x, y) -> y AS lambda2
SELECT arrayMap(lambda(tuple(x), x + 1), [1, 2, 3]), lambda2(tuple(x), x + 1), 1 AS x;
DROP TABLE test_table_tuple;
DROP TABLE test_table;
