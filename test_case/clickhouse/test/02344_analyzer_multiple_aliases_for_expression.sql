SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table
(
    id UInt64,
    value String
) ENGINE=TinyLog;
INSERT INTO test_table VALUES (0, 'Value');
SELECT 1 AS value, 1 AS value;
SELECT id AS value, id AS value FROM test_table;
WITH x -> x + 1 AS lambda, x -> x + 1 AS lambda SELECT lambda(1);
SELECT (SELECT 1) AS subquery, (SELECT 1) AS subquery;
SELECT 1 AS value, 2 AS value;
SELECT plus(1, 1) AS value, 2 AS value;
SELECT (SELECT 1) AS subquery, 1 AS subquery;
WITH x -> x + 1 AS lambda, x -> x + 2 AS lambda SELECT lambda(1);
WITH x -> x + 1 AS lambda SELECT (SELECT 1) AS lambda;
WITH x -> x + 1 AS lambda SELECT 1 AS lambda;
SELECT id AS value, value AS value FROM test_table;
SELECT id AS value_1, value AS value_1 FROM test_table;
SELECT id AS value, (id + 1) AS value FROM test_table;
DROP TABLE test_table;